
TellMeWhenDB = {
	["profileKeys"] = {
		["Mxzq - Golemagg"] = "HUNTER",
		["Vermina - Golemagg"] = "PALADIN",
		["Mxyz - Golemagg"] = "PRIEST",
		["Battlearm - Golemagg"] = "DEATHKNIGHT",
		["Battitude - Golemagg"] = "ROGUE",
		["Kaonac - Jin'do"] = "PRIEST",
		["Tandaram - Jin'do"] = "WARRIOR",
		["Poklopac - Dreadnaught"] = "HUNTER",
		["Tudum - Ashbringer"] = "WARRIOR",
		["Augustin - Golemagg"] = "MAGE",
		["Tudum - Jin'do"] = "WARRIOR",
		["Mxyzptlk - Golemagg"] = "WARLOCK",
		["Pitchwise - Ashbringer"] = "SHAMAN",
		["Poklopac - Mirage Raceway"] = "HUNTER",
		["Provokator - Jin'do"] = "HUNTER",
		["Wells - Jin'do"] = "DRUID",
		["Moolatz - Golemagg"] = "DRUID",
		["Vermin - Golemagg"] = "WARRIOR",
		["Moolatz - Dreadnaught"] = "DRUID",
	},
	["global"] = {
		["BackdropColor"] = "00ffffff",
		["TextLayouts"] = {
			["TMW:textlayout:1YXC4srUja8k"] = {
				{
					["SkinAs"] = "HotKey",
					["Anchors"] = {
						{
							["y"] = -2,
							["x"] = -2,
							["point"] = "TOPLEFT",
							["relativePoint"] = "TOPLEFT",
						}, -- [1]
						{
							["y"] = -2,
							["x"] = -2,
							["point"] = "TOPRIGHT",
							["relativePoint"] = "TOPRIGHT",
						}, -- [2]
						["n"] = 2,
					},
					["StringName"] = "Binding/Label",
				}, -- [1]
				{
					["Outline"] = "OUTLINE",
					["Anchors"] = {
						{
							["y"] = 2,
							["point"] = "BOTTOM",
							["relativePoint"] = "TOP",
						}, -- [1]
					},
					["DefaultText"] = "[Stacks:Hide(0)]",
					["StringName"] = "Stacks",
				}, -- [2]
				{
					["Outline"] = "OUTLINE",
					["DefaultText"] = "[Duration:TMWFormatDuration]",
					["StringName"] = "Duration",
				}, -- [3]
				["GUID"] = "TMW:textlayout:1YXC4srUja8k",
				["Name"] = "STACKS & DURATION",
				["n"] = 3,
			},
			["bar2"] = {
				{
				}, -- [1]
				{
				}, -- [2]
			},
			["TMW:textlayout:1TZve345g=GK"] = {
				{
					["SkinAs"] = "HotKey",
					["Anchors"] = {
						{
							["y"] = -2,
							["x"] = -2,
							["point"] = "TOPLEFT",
							["relativePoint"] = "TOPLEFT",
						}, -- [1]
						{
							["y"] = -2,
							["x"] = -2,
							["point"] = "TOPRIGHT",
							["relativePoint"] = "TOPRIGHT",
						}, -- [2]
						["n"] = 2,
					},
					["StringName"] = "Binding/Label",
				}, -- [1]
				{
					["Outline"] = "OUTLINE",
					["SkinAs"] = "Count",
					["DefaultText"] = "[Stacks:Hide(0)]",
					["StringName"] = "Stacks",
					["Anchors"] = {
						{
							["y"] = 2,
							["point"] = "BOTTOMRIGHT",
							["relativePoint"] = "BOTTOMRIGHT",
						}, -- [1]
					},
					["Size"] = 9,
				}, -- [2]
				["GUID"] = "TMW:textlayout:1TZve345g=GK",
				["Name"] = "STACKS",
				["n"] = 2,
			},
			["icon1"] = {
				{
				}, -- [1]
				{
				}, -- [2]
			},
			["TMW:textlayout:1Y9UVC8yK0C2"] = {
				{
					["DefaultText"] = "[PercentHP(unit=\"Pet\"):Percent:HPColor]  ",
					["Justify"] = "RIGHT",
					["Anchors"] = {
						{
							["point"] = "BOTTOMRIGHT",
							["relativePoint"] = "BOTTOMRIGHT",
						}, -- [1]
					},
					["Outline"] = "OUTLINE",
					["StringName"] = "Number",
					["ConstrainWidth"] = false,
					["Size"] = 8,
				}, -- [1]
				["GUID"] = "TMW:textlayout:1Y9UVC8yK0C2",
				["Name"] = "HPAbove",
			},
		},
		["ShowGUIDs"] = true,
		["CodeSnippets"] = {
			{
				["Enabled"] = false,
				["Name"] = "AOE",
				["Code"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return true\nelse\n    return false\nend",
			}, -- [1]
			["n"] = 1,
		},
		["AllowCombatConfig"] = true,
		["HelpSettings"] = {
			["CNDT_ANDOR_FIRSTSEE"] = true,
			["CNDT_PARENTHESES_FIRSTSEE"] = true,
			["SCROLLBAR_DROPDOWN"] = true,
			["ICON_POCKETWATCH_FIRSTSEE"] = true,
			["SUG_FIRSTHELP"] = true,
			["ICON_EXPORT_DOCOPY"] = true,
		},
	},
	["Version"] = 92500,
	["profiles"] = {
		["HUNTER"] = {
			["Groups"] = {
				{
					["Scale"] = 1.0008,
					["Rows"] = 3,
					["Locked"] = true,
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Icons"] = {
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Type"] = "cooldown",
							["Name"] = "Serpent Sting",
							["Enabled"] = true,
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Serpent Sting",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Serpent Sting",
								}, -- [2]
								{
									["Type"] = "NAME",
									["Unit"] = "target",
									["Name"] = "Princess Theradras",
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
						}, -- [1]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Unit"] = "target",
									["Name"] = "Hunter's Mark",
								}, -- [1]
								["n"] = 1,
							},
							["Name"] = "Hunter's Mark",
							["ShowTimerText"] = true,
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["Enabled"] = true,
							["ManaCheck"] = true,
						}, -- [2]
						{
							["Type"] = "cooldown",
							["Name"] = "Arcane Shot",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1V6lsULwY3_Y",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["Enabled"] = true,
						}, -- [3]
						{
							["Type"] = "cooldown",
							["Name"] = "Aspect of the Hawk",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1V6noP8ARoel",
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Operator"] = ">=",
									["Level"] = 45,
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Aspect of the Hawk",
								}, -- [2]
								["n"] = 2,
							},
						}, -- [4]
						nil, -- [5]
						{
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "if xAOE(20) > 1 then\n    return true\nelse\n    return true\nend",
								}, -- [1]
								{
									["Type"] = "SPEED",
								}, -- [2]
								["n"] = 2,
							},
							["Name"] = "Multi-Shot",
							["GUID"] = "TMW:icon:1YS2u64Alj4P",
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["Enabled"] = true,
						}, -- [6]
						{
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Steady Shot",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Unit"] = "target",
									["Name"] = "Serpent Sting",
									["PrtsBefore"] = 1,
								}, -- [2]
								{
									["Type"] = "NAME",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
									["Name"] = "Princess Theradras",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "SPEED",
								}, -- [4]
								["n"] = 4,
							},
							["Name"] = "Steady Shot",
							["GUID"] = "TMW:icon:1YS2u64Csf0H",
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [3]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["Enabled"] = true,
						}, -- [7]
						{
							["Type"] = "reactive",
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Unit"] = "pet",
								}, -- [1]
								{
									["Type"] = "ALIVE",
									["Unit"] = "pet",
								}, -- [2]
								["n"] = 2,
							},
							["Name"] = "Kill Command",
							["GUID"] = "TMW:icon:1YYUluwZXp0V",
							["ManaCheck"] = true,
							["CooldownCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["Enabled"] = true,
						}, -- [8]
						{
							["Type"] = "cooldown",
							["Name"] = "Aspect of the Viper",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1ZB8mNf2cjSi",
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Operator"] = "<=",
									["Level"] = 5,
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Aspect of the Viper",
								}, -- [2]
								["n"] = 2,
							},
						}, -- [9]
						[18] = {
							["Unit"] = "pet",
							["Type"] = "cooldown",
							["Name"] = "Mend Pet",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1X=OmHlbqz67",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Unit"] = "pet",
									["Level"] = 90,
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Unit"] = "pet",
									["Name"] = "Mend Pet",
								}, -- [2]
								{
									["Type"] = "EXISTS",
									["Unit"] = "pet",
								}, -- [3]
								{
									["Type"] = "ALIVE",
									["Unit"] = "pet",
								}, -- [4]
								["n"] = 4,
							},
							["Enabled"] = true,
						},
						[21] = {
							["BuffOrDebuff"] = "EITHER",
							["Unit"] = "target",
							["Type"] = "buff",
							["Name"] = "Enraged",
							["Enabled"] = true,
							["CustomTex"] = "19801",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["ManaCheck"] = true,
						},
						[22] = {
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Unit"] = "target",
									["Name"] = "Serpent Sting",
								}, -- [1]
								["n"] = 1,
							},
							["Name"] = "Chimera Shot",
							["GUID"] = "TMW:icon:1ZDQ16jlvSmQ",
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["Enabled"] = true,
						},
						[23] = {
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Operator"] = "~=",
									["Name"] = "Chimera Shot",
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "if xAOE(20) > 1 then\n    return false\nelse\n    return false\nend",
								}, -- [2]
								["n"] = 2,
							},
							["Name"] = "Aimed Shot",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1ZDQ16jnm6W=",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["Enabled"] = true,
						},
						[24] = {
							["Type"] = "cooldown",
							["Name"] = "Trueshot Aura",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1ZDQ16jpl=uP",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Trueshot Aura",
								}, -- [1]
								["n"] = 1,
							},
						},
						[25] = {
							["Type"] = "cooldown",
							["Name"] = "Deterrence",
							["Enabled"] = true,
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1ZDQ16jrgNie",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 20,
								}, -- [1]
								["n"] = 1,
							},
						},
						[26] = {
							["Type"] = "cooldown",
							["Name"] = "Misdirection",
							["Enabled"] = true,
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1ZDRwPNRMoWc",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Unit"] = "pet",
								}, -- [1]
								{
									["Type"] = "HEALTH_ABS",
									["Operator"] = ">=",
									["Unit"] = "target",
									["Level"] = 2000,
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Unit"] = "target",
									["Operator"] = "~=",
									["Name"] = "Serpent Sting",
								}, -- [3]
								{
									["Type"] = "INSTANCE2",
									["BitFlags"] = 1,
								}, -- [4]
								["n"] = 4,
							},
						},
						[27] = {
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["Type"] = "THREATSCALED",
									["Unit"] = "target",
									["Level"] = 100,
								}, -- [1]
								["n"] = 1,
							},
							["Name"] = "Concussive Shot",
							["GUID"] = "TMW:icon:1ZDRwPNU7Z0Z",
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["Enabled"] = true,
						},
						[28] = {
							["Type"] = "cooldown",
							["Name"] = "Wing Clip",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1ZEKCuryiveD",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["Enabled"] = true,
						},
						[55] = {
							["Type"] = "cooldown",
							["Name"] = "1742",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1ZG0cMPPKbCD",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Unit"] = "pet",
									["Operator"] = "<=",
									["Level"] = 40,
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "pet",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "pet",
								}, -- [3]
								["n"] = 3,
							},
						},
						[56] = {
							["Type"] = "cooldown",
							["Name"] = "53478",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1ZFQDm2Teoqd",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Unit"] = "pet",
									["Level"] = 30,
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "pet",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "pet",
								}, -- [3]
								["n"] = 3,
							},
						},
						[57] = {
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 60,
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZFP_8OYz7Gr",
							["CustomTex"] = "5720",
							["OnlyInBags"] = true,
						},
						[58] = {
							["Type"] = "item",
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 30,
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZFP_8OauieW",
							["CustomTex"] = "28491",
							["OnlyInBags"] = true,
						},
						[59] = {
							["Type"] = "cooldown",
							["Name"] = "Lifeblood",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1ZB9QFefrfi_",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 75,
								}, -- [1]
								["n"] = 1,
							},
						},
						[60] = {
							["Type"] = "item",
							["OnlyInBags"] = true,
							["Name"] = "22795",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1ZB9QFehlUaz",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 55,
								}, -- [1]
								["n"] = 1,
							},
						},
					},
					["Name"] = "SPELLS",
					["Point"] = {
						["y"] = -4.996173281900221,
						["x"] = -0.0002605930177353105,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Alpha"] = 0,
				}, -- [1]
				{
					["Point"] = {
						["y"] = -20,
						["x"] = -230,
					},
					["Scale"] = 1.5,
					["TextureName"] = "Details Flat",
					["OnlyInCombat"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TeVAjjXQ0WB", -- [1]
							},
						}, -- [1]
					},
					["Name"] = "OTHER",
					["GUID"] = "TMW:group:1TWYPj24VzCn",
				}, -- [2]
				{
					["Point"] = {
						["y"] = -100,
						["x"] = -5.450076092640056e-05,
					},
					["Scale"] = 1.5,
					["Locked"] = true,
					["OnlyInCombat"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZG0cMPPKbCD", -- [1]
								"TMW:icon:1ZFQDm2Teoqd", -- [2]
								"TMW:icon:1X=OmHlbqz67", -- [3]
								"TMW:icon:1ZEKCuryiveD", -- [4]
								"TMW:icon:1ZDQ16jpl=uP", -- [5]
								"TMW:icon:1ZDRwPNU7Z0Z", -- [6]
								"TMW:icon:1ZFP_8OYz7Gr", -- [7]
								"TMW:icon:1ZFP_8OauieW", -- [8]
								"TMW:icon:1ZB9QFehlUaz", -- [9]
								"TMW:icon:1ZB9QFefrfi_", -- [10]
								"TMW:icon:1ZDQ16jrgNie", -- [11]
								"TMW:icon:1V6noP8ARoel", -- [12]
								"TMW:icon:1ZB8mNf2cjSi", -- [13]
								"TMW:icon:1TeVAjjXQ0WB", -- [14]
								"TMW:icon:1YYUluwZXp0V", -- [15]
								"TMW:icon:1ZDRwPNRMoWc", -- [16]
								"TMW:icon:1ZDQ16jlvSmQ", -- [17]
								"TMW:icon:1ZDQ16jnm6W=", -- [18]
								"TMW:icon:1YS2u64Alj4P", -- [19]
								"TMW:icon:1V6lsULwY3_Y", -- [20]
								"TMW:icon:1YS2u64Csf0H", -- [21]
							},
							["Conditions"] = {
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [4]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Volley",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Feign Death",
								}, -- [6]
								{
									["Type"] = "LUA",
									["Name"] = "return not IsAltKeyDown()",
								}, -- [7]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Food",
								}, -- [8]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Drink",
								}, -- [9]
								["n"] = 9,
							},
							["Enabled"] = true,
						}, -- [1]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1X=OmHlbqz67", -- [1]
								"TMW:icon:1YYUluwZXp0V", -- [2]
								"TMW:icon:1YS2u64Alj4P", -- [3]
								"TMW:icon:1YS2u64Csf0H", -- [4]
							},
							["Enabled"] = true,
						}, -- [2]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1X=OmHlbqz67", -- [1]
							},
							["Enabled"] = true,
						}, -- [3]
					},
					["Name"] = "ROTATION CENTER",
					["GUID"] = "TMW:group:1TeVDtajUwqa",
				}, -- [3]
				{
					["Point"] = {
						["y"] = -0.00067138671875,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Scale"] = 0.4,
					["Locked"] = true,
					["OnlyInCombat"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZG0cMPPKbCD", -- [1]
								"TMW:icon:1ZFQDm2Teoqd", -- [2]
								"TMW:icon:1X=OmHlbqz67", -- [3]
								"TMW:icon:1ZEKCuryiveD", -- [4]
								"TMW:icon:1ZDQ16jpl=uP", -- [5]
								"TMW:icon:1ZDRwPNU7Z0Z", -- [6]
								"TMW:icon:1ZFP_8OYz7Gr", -- [7]
								"TMW:icon:1ZFP_8OauieW", -- [8]
								"TMW:icon:1ZB9QFehlUaz", -- [9]
								"TMW:icon:1ZB9QFefrfi_", -- [10]
								"TMW:icon:1ZDQ16jrgNie", -- [11]
								"TMW:icon:1V6noP8ARoel", -- [12]
								"TMW:icon:1ZB8mNf2cjSi", -- [13]
								"TMW:icon:1TeVAjjXQ0WB", -- [14]
								"TMW:icon:1YYUluwZXp0V", -- [15]
								"TMW:icon:1ZDRwPNRMoWc", -- [16]
								"TMW:icon:1ZDQ16jlvSmQ", -- [17]
								"TMW:icon:1ZDQ16jnm6W=", -- [18]
								"TMW:icon:1YS2u64Alj4P", -- [19]
								"TMW:icon:1V6lsULwY3_Y", -- [20]
								"TMW:icon:1YS2u64Csf0H", -- [21]
							},
							["Conditions"] = {
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [4]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Volley",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Feign Death",
								}, -- [6]
								{
									["Type"] = "LUA",
									["Name"] = "return not IsAltKeyDown()",
								}, -- [7]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Food",
								}, -- [8]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Drink",
								}, -- [9]
								["n"] = 9,
							},
							["Enabled"] = true,
						}, -- [1]
					},
					["Name"] = "ROTATION TOPLEFT",
					["GUID"] = "TMW:group:1YWH=DtwTpKV",
				}, -- [4]
			},
			["NumGroups"] = 4,
			["TextureName"] = "Glamour2",
			["Version"] = 92500,
			["Locked"] = true,
		},
		["WARRIOR"] = {
			["Version"] = 92500,
			["Locked"] = true,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TQvxnAfbGyU",
					["Columns"] = 20,
					["Scale"] = 1,
					["Rows"] = 2,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Rend",
							["RangeCheck"] = true,
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Rend",
									["Unit"] = "target",
								}, -- [1]
								{
									["Name"] = "if xAOE(5) > 1 then\n    return false\nelse\n    return true\nend",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Name"] = "Defensive Stance; Battle Stance",
									["Type"] = "STANCE",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1TQv_LtTwAae",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Battle Shout",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
								},
							},
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "BUFFDUR",
									["Name"] = "Battle Shout",
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "Commanding Shout",
								}, -- [2]
								{
									["Name"] = "Greater Blessing of Might",
									["Type"] = "BUFFDUR",
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["PrtsAfter"] = 1,
									["Name"] = "Blessing of Might",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1TQv_Ltf40Wl",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [2]
						{
							["GUID"] = "TMW:icon:1TQv_Lti1RyX",
							["Type"] = "reactive",
							["Name"] = "Heroic Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "if xAOE(10)>1 then\n    return false\nelse \n    return true\n    end",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Heroic Strike",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 40,
									["Operator"] = ">=",
								}, -- [3]
								["n"] = 3,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [3]
						{
							["GUID"] = "TMW:icon:1TU=hLnlwyeY",
							["Type"] = "cooldown",
							["Name"] = "Overpower",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "REACTIVE",
									["Checked"] = true,
									["Name"] = "Overpower",
								}, -- [1]
								{
									["Name"] = "Battle Stance",
									["Type"] = "STANCE",
								}, -- [2]
								["n"] = 2,
							},
							["ShowTimerText"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [4]
						{
							["GUID"] = "TMW:icon:1TWZdpV26rm5",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Demoralizing Shout",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Demoralizing Shout",
									["Unit"] = "target",
								}, -- [1]
								{
									["Unit"] = "target",
									["Level"] = 5,
									["Type"] = "LIBRANGECHECK",
									["Operator"] = "<=",
								}, -- [2]
								["n"] = 2,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [5]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1TYYu4EDbfSz",
							["Name"] = "Sunder Armor",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks:Hide(0)]", -- [2]
									},
								},
							},
							["HideIfNoUnits"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFSTACKS",
									["Name"] = "Sunder Armor",
									["PrtsBefore"] = 2,
									["Level"] = 3,
									["Unit"] = "target",
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sunder Armor",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["Level"] = 6,
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
								}, -- [2]
								{
									["Operator"] = ">=",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "if xAOE(5) > 1 then\n    return false\nelse\n    return true\nend",
								}, -- [4]
								{
									["PrtsBefore"] = 1,
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Type"] = "DEBUFFSTACKS",
									["Name"] = "Sunder Armor",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["Level"] = 3,
									["PrtsAfter"] = 1,
									["Operator"] = "<",
								}, -- [6]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sunder Armor",
									["PrtsBefore"] = 1,
									["Level"] = 6,
									["Unit"] = "target",
									["Operator"] = "<=",
								}, -- [7]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "if xAOE(5) > 1 then\n    return false\nelse\n    return true\nend",
								}, -- [8]
								["n"] = 8,
							},
							["RangeCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [6]
						{
							["GUID"] = "TMW:icon:1TZvNvflXM0_",
							["Type"] = "reactive",
							["Name"] = "Execute",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [7]
						{
							["GUID"] = "TMW:icon:1Xrn34GriOqy",
							["Type"] = "cooldown",
							["Name"] = "Revenge",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "REACTIVE",
									["Checked"] = true,
									["Name"] = "Revenge",
								}, -- [1]
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [2]
								["n"] = 2,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [8]
						{
							["GUID"] = "TMW:icon:1Y2=7t59vfSn",
							["Type"] = "reactive",
							["Name"] = "Cleave",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Cleave",
									["Level"] = 1,
								}, -- [1]
								{
									["PrtsBefore"] = 2,
									["Type"] = "LUA",
									["Name"] = "if xAOE(10) > 1 then\n    return true\nelse\n    return false\nend",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 40,
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "LUA",
									["Name"] = "if xAOE(10) > 2 then\n    return true\nelse\n    return false\nend",
									["AndOr"] = "OR",
								}, -- [4]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 25,
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
								}, -- [5]
								["n"] = 5,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [9]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Whirlwind",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Berserker Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Operator"] = ">",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [3]
								{
									["PrtsBefore"] = 1,
									["Type"] = "LUA",
									["Name"] = "if xAOE(10) > 1 then\n    return true\nelse\n    return false\nend",
								}, -- [4]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Mortal Strike",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Operator"] = "~=",
								}, -- [5]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Bloodthirst",
									["AndOr"] = "OR",
									["PrtsAfter"] = 2,
									["Operator"] = "~=",
								}, -- [6]
								["n"] = 6,
							},
							["GUID"] = "TMW:icon:1Xwc=6KNp27d",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [10]
						{
							["ManaCheck"] = true,
							["Type"] = "reactive",
							["Name"] = "Victory Rush",
							["RangeCheck"] = true,
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1YP2Xjgjriiu",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [11]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Spell Reflection",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Defensive Stance; Battle Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Name"] = "IsEquippedItemType(\"Shields\")",
									["Type"] = "LUA",
								}, -- [2]
								{
									["PrtsBefore"] = 1,
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "local red, green, blue, alpha = RotationFrame_AOERANGECASTING:GetBackdropColor()\nif xRound(red,2) == 0 and xRound(green,2) ==1 and xRound(blue,2) == 0.5 then\n    return true\nend",
								}, -- [3]
								{
									["Type"] = "NAME",
									["AndOr"] = "OR",
									["Name"] = "Tempest-Forge Peacekeeper",
									["Unit"] = "target",
								}, -- [4]
								{
									["PrtsBefore"] = 1,
									["Type"] = "ISPLAYER",
									["AndOr"] = "OR",
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [6]
								["n"] = 6,
							},
							["GUID"] = "TMW:icon:1ZGdp_HEzv8p",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [12]
						{
							["GUID"] = "TMW:icon:1XzwOSGxkHLD",
							["Type"] = "cooldown",
							["Name"] = "Mortal Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "if xAOE(5) > 1 then\n    return false\nelse\n    return true\nend",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["Name"] = "Battle Stance; Berserker Stance",
									["AndOr"] = "OR",
								}, -- [2]
								["n"] = 2,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [13]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Pummel",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Berserker Stance",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["States"] = {
								[3] = {
									["Alpha"] = 0,
								},
							},
						}, -- [14]
						[24] = {
							["GUID"] = "TMW:icon:1Z55tRwA_pKn",
							["Type"] = "cooldown",
							["Name"] = "Shield Slam",
							["RangeCheck"] = true,
							["Enabled"] = true,
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[25] = {
							["GUID"] = "TMW:icon:1Z7AzkxDmWSh",
							["Type"] = "cooldown",
							["Name"] = "Vigilance",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Unit"] = "focus",
								}, -- [1]
								{
									["Type"] = "ALIVE",
									["Unit"] = "focus",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 2,
									["Unit"] = "focus",
								}, -- [3]
								["n"] = 3,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[26] = {
							["GUID"] = "TMW:icon:1Z679nrqAgG4",
							["Type"] = "cooldown",
							["Name"] = "Concussion Blow",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 2,
									["Type"] = "SPELLCD",
									["Name"] = "Shield Bash",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["PrtsAfter"] = 1,
									["Name"] = "Defensive Stance",
								}, -- [2]
								{
									["PrtsBefore"] = 1,
									["Type"] = "STANCE",
									["Name"] = "Berserker Stance",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["PrtsAfter"] = 2,
									["Type"] = "SPELLCD",
									["Name"] = "Pummel",
									["Operator"] = "~=",
								}, -- [4]
								{
									["Name"] = "local name_casting, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible_casting, spellId = UnitCastingInfo('target')\nlocal name_channeling, text, texture, startTimeMS, endTimeMS, isTradeSkill, notInterruptible_chanelling, spellId = UnitChannelInfo('target')\nif (name_casting ~= nil and not notInterruptible_casting) or (name_channeling ~= nil and not notInterruptible_chanelling) then\n    return true\nelse\n    return false\nend",
									["Type"] = "LUA",
								}, -- [5]
								["n"] = 5,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[27] = {
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shield Wall",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 40,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1Z7PEaKwPKnX",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[28] = {
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Commanding Shout",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "Battle Shout",
								}, -- [1]
								{
									["Name"] = "Commanding Shout",
									["Type"] = "BUFFDUR",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1Z7PEaK_TNq3",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[29] = {
							["ManaCheck"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "EITHER",
							["Name"] = "Feared",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1Z7R_6NwuWuK",
							["Conditions"] = {
								{
									["Name"] = "Berserker Rage",
									["Type"] = "SPELLCD",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "18499",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[16] = {
							["GUID"] = "TMW:icon:1YEqZQbYmmFD",
							["Type"] = "cooldown",
							["Name"] = "Bloodthirst",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "if xAOE(5) > 1 then\n    return false\nelse\n    return true\nend",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["Name"] = "Battle Stance; Berserker Stance",
									["AndOr"] = "OR",
								}, -- [2]
								["n"] = 2,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[17] = {
							["GUID"] = "TMW:icon:1YO4Qlh73rOw",
							["Type"] = "reactive",
							["Name"] = "Rampage",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Level"] = 10,
									["Name"] = "Rampage",
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[18] = {
							["GUID"] = "TMW:icon:1YO55KEUKaW4",
							["Type"] = "cooldown",
							["Name"] = "Sweeping Strikes",
							["Conditions"] = {
								{
									["Name"] = "Battle Stance; Berserker Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Name"] = "if xAOE(10) > 1 then\n    return true\nelse\n    return false\nend",
									["Type"] = "LUA",
								}, -- [2]
								["n"] = 2,
							},
							["Enabled"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[19] = {
							["GUID"] = "TMW:icon:1YWHZ7T27TKe",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Thunder Clap",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Thunder Clap",
									["Unit"] = "target",
								}, -- [2]
								{
									["Name"] = "Sweeping Strikes",
									["Type"] = "BUFFDUR",
								}, -- [3]
								{
									["Name"] = "if xAOE(10) >= 1 then\n    return true\nelse\n    return false\nend",
									["Type"] = "LUA",
								}, -- [4]
								{
									["Operator"] = "<=",
									["Level"] = 5,
									["Type"] = "LIBRANGECHECK",
									["Unit"] = "target",
								}, -- [5]
								["n"] = 5,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[20] = {
							["GUID"] = "TMW:icon:1TWYMfcUzmi6",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Name"] = "Hamstring",
							["Enabled"] = true,
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "ISPLAYER",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Hamstring",
									["Unit"] = "target",
								}, -- [2]
								{
									["Name"] = "Battle Stance; Berserker Stance",
									["Type"] = "STANCE",
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Hand of Freedom",
									["Unit"] = "target",
								}, -- [4]
								["n"] = 4,
							},
							["RangeCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[21] = {
							["GUID"] = "TMW:icon:1Z55tRw3mJGc",
							["Type"] = "cooldown",
							["Name"] = "Devastate",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[22] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Last Stand",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 50,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1Z55tRw68qC=",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[23] = {
							["GUID"] = "TMW:icon:1Z55tRw8OaCM",
							["Type"] = "cooldown",
							["Name"] = "Shield Block",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[31] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Disarm",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ISPLAYER",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "PVPFLAG",
								}, -- [5]
								{
									["Type"] = "CLASS2",
									["Unit"] = "target",
									["BitFlags"] = 43,
								}, -- [6]
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [7]
								["n"] = 7,
							},
							["GUID"] = "TMW:icon:1Z9CIRRFbqSA",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
					},
					["Name"] = "SPELLS",
					["Locked"] = true,
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Alpha"] = 0,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYSTcQ410f",
					["Columns"] = 20,
					["Scale"] = 1,
					["Alpha"] = 0,
					["TextureName"] = "Details Flat",
					["Name"] = "GENERAL",
					["Locked"] = true,
					["Point"] = {
						["y"] = -65,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TWYSTcSCl0z",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Name"] = "Blood Fury",
							["Enabled"] = true,
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Enrage",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1TZve345g=GK",
								},
							},
							["ShowTimerText"] = true,
							["GUID"] = "TMW:icon:1TZvNvgAkfmq",
						}, -- [2]
						{
							["GUID"] = "TMW:icon:1Xx3hMFQR0cV",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Name"] = "Recently Bandaged",
							["Enabled"] = true,
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1TZve345g=GK",
								},
							},
							["Name"] = "Sweeping Strikes",
							["GUID"] = "TMW:icon:1YXBo4F3g7mS",
						}, -- [4]
						nil, -- [5]
						nil, -- [6]
						nil, -- [7]
						nil, -- [8]
						nil, -- [9]
						nil, -- [10]
						nil, -- [11]
						nil, -- [12]
						{
							["Enabled"] = true,
							["Type"] = "reactive",
							["Name"] = "Revenge",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZG=mGUq7AKQ",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
							},
						}, -- [13]
						nil, -- [14]
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905",
							["GUID"] = "TMW:icon:1Z9jhZwz5hvH",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 35,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "28491",
							["OnlyInBags"] = true,
						}, -- [15]
						nil, -- [16]
						nil, -- [17]
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["GUID"] = "TMW:icon:1X=ERE5iZ8VU",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 60,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "5720",
							["OnlyInBags"] = true,
						}, -- [18]
						nil, -- [19]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "Poison",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1YXC4srUja8k",
									["Texts"] = {
										"", -- [1]
										"[Stacks:Hide(0)]", -- [2]
									},
								},
							},
							["BuffOrDebuff"] = "HARMFUL",
							["Type"] = "buff",
							["GUID"] = "TMW:icon:1ZGQG2qG9S8B",
						}, -- [20]
					},
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Point"] = {
						["y"] = -24.39078281325337,
						["x"] = -225.6130916101359,
					},
					["Name"] = "OTHER PORTRAIT",
					["Scale"] = 1.5,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZGQG2qG9S8B", -- [1]
								"TMW:icon:1Z7R_6NwuWuK", -- [2]
								"TMW:icon:1TWYSTcSCl0z", -- [3]
								"TMW:icon:1TZvNvgAkfmq", -- [4]
								"TMW:icon:1Xx3hMFQR0cV", -- [5]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TWYSTcSCl0z", -- [1]
							},
						}, -- [2]
					},
					["TextureName"] = "Details Flat",
				}, -- [3]
				{
					["GUID"] = "TMW:group:1TQuFk14Ix42",
					["Point"] = {
						["y"] = -88,
						["x"] = -5.450076092640056e-05,
					},
					["Scale"] = 1.5,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["BuffOrDebuff"] = "HARMFUL",
							["Icons"] = {
								"TMW:icon:1X=ERE5iZ8VU", -- [1]
								"TMW:icon:1Z9jhZwz5hvH", -- [2]
								"TMW:icon:1YO55KEUKaW4", -- [3]
								"TMW:icon:1TZvNvflXM0_", -- [4]
								"TMW:icon:1Z7R_6NwuWuK", -- [5]
								"TMW:icon:1TWYMfcUzmi6", -- [6]
								"TMW:icon:1Z9CIRRFbqSA", -- [7]
								"TMW:icon:1YP2Xjgjriiu", -- [8]
								"TMW:icon:1TQv_Ltf40Wl", -- [9]
								"TMW:icon:1Z7PEaK_TNq3", -- [10]
								"TMW:icon:1YWHZ7T27TKe", -- [11]
								"TMW:icon:1Xrn34GriOqy", -- [12]
								"TMW:icon:1TWZdpV26rm5", -- [13]
								"TMW:icon:1Z55tRwA_pKn", -- [14]
								"TMW:icon:1TYYu4EDbfSz", -- [15]
								"TMW:icon:1TU=hLnlwyeY", -- [16]
								"TMW:icon:1TQv_LtTwAae", -- [17]
								"TMW:icon:1YEqZQbYmmFD", -- [18]
								"TMW:icon:1XzwOSGxkHLD", -- [19]
								"TMW:icon:1Xwc=6KNp27d", -- [20]
								"TMW:icon:1Z55tRw3mJGc", -- [21]
							},
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Rend",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0)]",
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Divine Shield",
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Arcane Bubble",
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Ice Block",
									["Unit"] = "target",
								}, -- [7]
								["n"] = 7,
							},
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Sort"] = -1,
							["Name"] = "Battle Shout",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
								}, -- [1]
								["n"] = 1,
							},
							["DurationMinEnabled"] = true,
							["DurationMin"] = 15,
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								[100] = {
									["Alpha"] = 1,
								},
							},
						}, -- [2]
					},
					["TextureName"] = "Details Flat",
					["LayoutDirection"] = 2,
					["SortPriorities"] = {
						{
							["Order"] = -1,
						}, -- [1]
					},
					["Name"] = "ROTATION CENTER",
					["SettingsPerView"] = {
						["icon"] = {
							["BorderInset"] = false,
							["BorderColor"] = "00000000",
						},
					},
					["Locked"] = true,
					["Conditions"] = {
						{
							["Type"] = "MOUNTED",
							["Level"] = 1,
						}, -- [1]
						["n"] = 1,
					},
					["Columns"] = 1,
					["OnlyInCombat"] = true,
				}, -- [4]
				{
					["GUID"] = "TMW:group:1YWsxTHpfSuR",
					["Point"] = {
						["y"] = -0.00042724609375,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Scale"] = 0.4,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["BuffOrDebuff"] = "HARMFUL",
							["Icons"] = {
								"TMW:icon:1X=ERE5iZ8VU", -- [1]
								"TMW:icon:1Z9jhZwz5hvH", -- [2]
								"TMW:icon:1YO55KEUKaW4", -- [3]
								"TMW:icon:1TZvNvflXM0_", -- [4]
								"TMW:icon:1Z7R_6NwuWuK", -- [5]
								"TMW:icon:1TWYMfcUzmi6", -- [6]
								"TMW:icon:1Z9CIRRFbqSA", -- [7]
								"TMW:icon:1YP2Xjgjriiu", -- [8]
								"TMW:icon:1TQv_Ltf40Wl", -- [9]
								"TMW:icon:1Z7PEaK_TNq3", -- [10]
								"TMW:icon:1YWHZ7T27TKe", -- [11]
								"TMW:icon:1Xrn34GriOqy", -- [12]
								"TMW:icon:1TWZdpV26rm5", -- [13]
								"TMW:icon:1Z55tRwA_pKn", -- [14]
								"TMW:icon:1TYYu4EDbfSz", -- [15]
								"TMW:icon:1TU=hLnlwyeY", -- [16]
								"TMW:icon:1TQv_LtTwAae", -- [17]
								"TMW:icon:1YEqZQbYmmFD", -- [18]
								"TMW:icon:1XzwOSGxkHLD", -- [19]
								"TMW:icon:1Xwc=6KNp27d", -- [20]
								"TMW:icon:1Z55tRw3mJGc", -- [21]
								"TMW:icon:1ZG=mGUq7AKQ", -- [22]
							},
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Rend",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0)]",
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Divine Shield",
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Arcane Bubble",
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Ice Block",
									["Unit"] = "target",
								}, -- [7]
								["n"] = 7,
							},
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Sort"] = -1,
							["Name"] = "Battle Shout",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
								}, -- [1]
								["n"] = 1,
							},
							["DurationMinEnabled"] = true,
							["DurationMin"] = 15,
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								[100] = {
									["Alpha"] = 1,
								},
							},
						}, -- [2]
					},
					["TextureName"] = "Details Flat",
					["LayoutDirection"] = 2,
					["Name"] = "ROTATION TOPLEFT",
					["SettingsPerView"] = {
						["icon"] = {
							["BorderInset"] = false,
							["BorderColor"] = "00000000",
						},
					},
					["Locked"] = true,
					["SortPriorities"] = {
						{
							["Order"] = -1,
						}, -- [1]
					},
					["Columns"] = 1,
					["OnlyInCombat"] = true,
				}, -- [5]
				{
					["GUID"] = "TMW:group:1ZHnkWuhaAG=",
					["Point"] = {
						["x"] = 161,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Scale"] = 0.4,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TQv_Lti1RyX", -- [1]
								"TMW:icon:1Y2=7t59vfSn", -- [2]
								"TMW:icon:1Z7PEaKwPKnX", -- [3]
								"TMW:icon:1Z55tRw68qC=", -- [4]
								"TMW:icon:1ZGdp_HEzv8p", -- [5]
							},
							["Conditions"] = {
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Divine Shield",
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Arcane Bubble",
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Ice Block",
									["Unit"] = "target",
								}, -- [7]
								["n"] = 7,
							},
						}, -- [1]
					},
					["Name"] = "ROTATION QUEUE",
					["Locked"] = true,
					["Conditions"] = {
						{
							["Type"] = "EXISTS",
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "ALIVE",
							["Unit"] = "target",
						}, -- [2]
						["n"] = 3,
					},
					["Columns"] = 1,
					["OnlyInCombat"] = true,
				}, -- [6]
			},
			["NumGroups"] = 6,
			["TextureName"] = "Glamour2",
		},
		["ROGUE"] = {
			["Locked"] = true,
			["NumGroups"] = 4,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Scale"] = 1,
					["Rows"] = 3,
					["Alpha"] = 0,
					["Name"] = "Rogue Spells",
					["Locked"] = true,
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["Type"] = "cooldown",
							["Name"] = "Sinister Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Maul\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Level"] = 4,
									["Operator"] = "<",
								}, -- [2]
								["n"] = 2,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["RangeCheck"] = true,
							["OnlyMine"] = true,
							["Name"] = "Eviscerate",
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["Conditions"] = {
								{
									["Type"] = "COMBO",
									["Level"] = 4,
									["Operator"] = ">=",
								}, -- [1]
								["n"] = 1,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [2]
						[58] = {
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838",
							["GUID"] = "TMW:icon:1ZBi1G1Ik=8q",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 35,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "28491",
							["OnlyInBags"] = true,
						},
						[60] = {
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Lifeblood",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 75,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZB9ydEakN46",
						},
						[59] = {
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["GUID"] = "TMW:icon:1ZBi1G1LSN04",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 60,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "5720",
							["OnlyInBags"] = true,
						},
					},
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Columns"] = 1,
					["Point"] = {
						["y"] = -20.00000522536274,
						["x"] = -229.9999934656047,
					},
					["Scale"] = 1.5,
					["Name"] = "Other",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1Z3Dak8Afvm1", -- [1]
							},
						}, -- [1]
					},
					["TextureName"] = "Details Flat",
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TeVDtajUwqa",
					["Name"] = "Rotation CENTER",
					["Point"] = {
						["y"] = -140,
						["x"] = -5.450076092640056e-05,
					},
					["Locked"] = true,
					["Scale"] = 1.5,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZB9ydEakN46", -- [1]
								"TMW:icon:1ZBi1G1Ik=8q", -- [2]
								"TMW:icon:1ZBi1G1LSN04", -- [3]
								"TMW:icon:1TeVAjjavXC6", -- [4]
								"TMW:icon:1TeVAjjXQ0WB", -- [5]
							},
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [1]
								{
									["Unit"] = "target",
									["Type"] = "ALIVE",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Level"] = 1,
									["Type"] = "MOUNTED",
								}, -- [4]
								["n"] = 4,
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1YXd9eWHzTSH", -- [1]
								"TMW:icon:1YXd9eWMwI0j", -- [2]
								"TMW:icon:1V6noP8ARoel", -- [3]
								"TMW:icon:1V6lsULwY3_Y", -- [4]
							},
						}, -- [2]
					},
					["OnlyInCombat"] = true,
				}, -- [3]
				{
					["GUID"] = "TMW:group:1YWtClNC=L8S",
					["Name"] = "Rotation TOPLEFT",
					["Point"] = {
						["y"] = 6.103515625e-05,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Locked"] = true,
					["Scale"] = 0.4,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZB9ydEakN46", -- [1]
								"TMW:icon:1ZBi1G1Ik=8q", -- [2]
								"TMW:icon:1ZBi1G1LSN04", -- [3]
								"TMW:icon:1TeVAjjavXC6", -- [4]
								"TMW:icon:1TeVAjjXQ0WB", -- [5]
							},
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [1]
								{
									["Unit"] = "target",
									["Type"] = "ALIVE",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Level"] = 1,
									["Type"] = "MOUNTED",
								}, -- [4]
								["n"] = 4,
							},
						}, -- [1]
						{
							["Type"] = "meta",
						}, -- [2]
					},
					["OnlyInCombat"] = true,
				}, -- [4]
			},
			["Version"] = 92500,
		},
		["MAGE"] = {
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TQvxnAfbGyU",
					["Locked"] = true,
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Alpha"] = 0,
					["Scale"] = 1,
					["Columns"] = 20,
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TQv_LtTwAae",
							["OnlyMine"] = true,
							["ShowTimerText"] = true,
							["Type"] = "buff",
							["Name"] = "Dampen Magic",
							["Enabled"] = true,
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1TQv_Ltf40Wl",
							["Type"] = "buff",
							["Name"] = "Mana Shield",
							["ShowTimerText"] = true,
							["Enabled"] = true,
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Frost Nova",
							["ShowTimerText"] = true,
							["CooldownCheck"] = true,
							["GUID"] = "TMW:icon:1TQv_Lti1RyX",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [3]
						{
							["GUID"] = "TMW:icon:1TU=hLnlwyeY",
							["Type"] = "cooldown",
							["ShowTimerText"] = true,
							["Enabled"] = true,
							["Name"] = "Blink",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [4]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Demoralizing Shout",
							["Unit"] = "target",
							["BuffOrDebuff"] = "HARMFUL",
							["Conditions"] = {
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1TWZdpV26rm5",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [5]
						{
							["GUID"] = "TMW:icon:1TYYu4EDbfSz",
							["Type"] = "buff",
							["Name"] = "Sunder Armor",
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
							["ShowTimerText"] = true,
							["Unit"] = "target",
						}, -- [6]
						{
							["Enabled"] = true,
							["Type"] = "reactive",
							["Name"] = "Execute",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 15,
									["Operator"] = ">=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1TZvNvflXM0_",
						}, -- [7]
						[20] = {
							["BuffOrDebuff"] = "HARMFUL",
							["GUID"] = "TMW:icon:1TWYMfcUzmi6",
						},
					},
					["Name"] = "Spells",
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYSTcQ410f",
					["Columns"] = 20,
					["Scale"] = 1,
					["Alpha"] = 0,
					["TextureName"] = "Details Flat",
					["Name"] = "General Buffs/Debbufs",
					["Locked"] = true,
					["Point"] = {
						["y"] = -40,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TWYSTcSCl0z",
							["Type"] = "buff",
							["Name"] = "Renew",
							["ShowTimerText"] = true,
							["Enabled"] = true,
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1TZve345g=GK",
								},
							},
							["GUID"] = "TMW:icon:1TZvNvgAkfmq",
							["Name"] = "Enrage",
						}, -- [2]
					},
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Point"] = {
						["y"] = -29.2003912925716,
						["x"] = -209.401206970214,
					},
					["Name"] = "BuffTrack",
					["SettingsPerView"] = {
						["icon"] = {
							["SpacingX"] = 3,
						},
					},
					["Scale"] = 1.25,
					["Columns"] = 6,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TQv_LtTwAae", -- [1]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TQv_Ltf40Wl", -- [1]
							},
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TQv_Lti1RyX", -- [1]
							},
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TU=hLnlwyeY", -- [1]
							},
						}, -- [4]
						nil, -- [5]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TWYSTcSCl0z", -- [1]
							},
						}, -- [6]
					},
					["TextureName"] = "Details Flat",
				}, -- [3]
			},
			["Locked"] = true,
			["Version"] = 91200,
			["NumGroups"] = 3,
			["TextureName"] = "Glamour2",
		},
		["PRIEST"] = {
			["Locked"] = true,
			["NumGroups"] = 3,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Columns"] = 1,
					["Point"] = {
						["y"] = -20,
						["x"] = -230,
					},
					["Scale"] = 1.5,
					["Name"] = "Other",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1VjwkIsn7fZp", -- [1]
							},
						}, -- [1]
					},
					["TextureName"] = "Details Flat",
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Name"] = "Hunter Spells",
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Serpent Sting",
							["Conditions"] = {
								{
									["Type"] = "MANA_ABS",
									["Level"] = 100,
									["Operator"] = ">",
								}, -- [1]
								{
									["Unit"] = "target",
									["Level"] = 35,
									["Type"] = "LIBRANGECHECK",
									["Operator"] = "<=",
								}, -- [2]
								["n"] = 2,
							},
							["Enabled"] = true,
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 0.15,
								}, -- [2]
							},
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
							["Name"] = "Hunter's Mark",
							["Unit"] = "target",
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Arcane Shot",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "MANA_ABS",
									["Level"] = 100,
									["Operator"] = ">",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1V6lsULwY3_Y",
						}, -- [3]
						{
							["GUID"] = "TMW:icon:1V6noP8ARoel",
							["Type"] = "buff",
							["Name"] = "Aspect of the Hawk",
							["Enabled"] = true,
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [4]
						[19] = {
							["GUID"] = "TMW:icon:1VjwkIslWpyf",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
							["Name"] = "Crystal Gaze",
							["Unit"] = "pet",
						},
						[20] = {
							["GUID"] = "TMW:icon:1VjwkIsn7fZp",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
							["Name"] = "Weakened Soul",
						},
					},
					["Locked"] = true,
					["Columns"] = 20,
					["Alpha"] = 0,
					["Scale"] = 1,
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TeVDtajUwqa",
					["Name"] = "Hunter Rotation",
					["Point"] = {
						["y"] = -88,
						["x"] = 4.06901041666667e-05,
					},
					["Locked"] = true,
					["Scale"] = 1.5,
					["Columns"] = 3,
					["Icons"] = {
						{
							["Icons"] = {
								"TMW:icon:1V6noP8ARoel", -- [1]
							},
							["Type"] = "meta",
						}, -- [1]
						{
							["Icons"] = {
								"TMW:icon:1V6lsULwY3_Y", -- [1]
							},
							["Type"] = "meta",
						}, -- [2]
					},
					["OnlyInCombat"] = true,
				}, -- [3]
			},
			["Version"] = 92500,
		},
		["SHAMAN"] = {
			["Locked"] = true,
			["Version"] = 92500,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1ZF8PYL8n6L4",
				}, -- [1]
			},
		},
		["Poklopac - Mirage Raceway"] = {
			["Version"] = 92500,
		},
		["PALADIN"] = {
			["Locked"] = true,
			["NumGroups"] = 4,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Scale"] = 1,
					["Rows"] = 3,
					["Icons"] = {
						[46] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Lay on Hands",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 20,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Name"] = "Forbearance",
									["Type"] = "DEBUFFDUR",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1Z6tL7hZeq4n",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[48] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Divine Protection",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 60,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Name"] = "Forbearance",
									["Type"] = "DEBUFFDUR",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1Z6tL7hdj2mo",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[50] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Seal of Command",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Level"] = 10,
									["Name"] = "Seal of Command",
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1Z6uOhVXfBCq",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[41] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blessing of Might",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Blessing of Might",
									["AndOr"] = "OR",
									["Level"] = 10,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1YXd9eWHzTSH",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[43] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Divine Storm",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Operator"] = "~=",
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Wisdom",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1YatF3BT0RKW",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[45] = {
							["GUID"] = "TMW:icon:1Z6tL7hXaSCZ",
							["Type"] = "cooldown",
							["Name"] = "Exorcism",
							["RangeCheck"] = true,
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[47] = {
							["GUID"] = "TMW:icon:1Z6tL7hbgPqi",
							["Type"] = "buff",
							["Name"] = "Poison; Disease",
							["Enabled"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["ManaCheck"] = true,
							["CustomTex"] = "1152",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[49] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Consecration",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "if xAOE(10) > 2 then\n    return true\nelse\n    return false\nend",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1Z6tL7hfkyqu",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[51] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Judgement of Light",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Wisdom",
									["Level"] = 2,
									["Operator"] = "<=",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Light",
									["Level"] = 2,
									["Operator"] = "<=",
									["Unit"] = "target",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1Z6uOhVZgoW8",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[42] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Judgement of Wisdom",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Wisdom",
									["Operator"] = "<=",
									["AndOr"] = "OR",
									["Level"] = 2,
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Light",
									["Level"] = 2,
									["Operator"] = "<=",
									["Unit"] = "target",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1YXd9eWMwI0j",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[44] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Crusader Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Operator"] = "~=",
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Wisdom",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1YawP4LcafCX",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
					},
					["Name"] = "Paladin Spells",
					["Locked"] = true,
					["Columns"] = 20,
					["Alpha"] = 0,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Columns"] = 1,
					["Point"] = {
						["y"] = -20.00000522536274,
						["x"] = -229.9999934656047,
					},
					["Scale"] = 1.5,
					["Name"] = "Other",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
						}, -- [1]
					},
					["TextureName"] = "Details Flat",
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TeVDtajUwqa",
					["Point"] = {
						["y"] = -140,
						["x"] = -5.450076092640056e-05,
					},
					["Name"] = "Rotation CENTER",
					["Scale"] = 1.5,
					["Locked"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1Z6tL7hZeq4n", -- [1]
								"TMW:icon:1Z6tL7hbgPqi", -- [2]
								"TMW:icon:1Z6tL7hdj2mo", -- [3]
								"TMW:icon:1Z6uOhVXfBCq", -- [4]
								"TMW:icon:1YXd9eWHzTSH", -- [5]
								"TMW:icon:1Z6uOhVZgoW8", -- [6]
								"TMW:icon:1YXd9eWMwI0j", -- [7]
								"TMW:icon:1YatF3BT0RKW", -- [8]
								"TMW:icon:1Z6tL7hfkyqu", -- [9]
								"TMW:icon:1YawP4LcafCX", -- [10]
							},
							["Conditions"] = {
								{
									["Name"] = "return not IsAltKeyDown();",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1YXd9eWHzTSH", -- [1]
								"TMW:icon:1YXd9eWMwI0j", -- [2]
								"TMW:icon:1V6noP8ARoel", -- [3]
								"TMW:icon:1V6lsULwY3_Y", -- [4]
							},
						}, -- [2]
					},
					["OnlyInCombat"] = true,
				}, -- [3]
				{
					["GUID"] = "TMW:group:1YWtClNC=L8S",
					["Point"] = {
						["y"] = 6.103515625e-05,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Name"] = "Rotation TOPLEFT",
					["Scale"] = 0.4,
					["Locked"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1Z6tL7hZeq4n", -- [1]
								"TMW:icon:1Z6tL7hbgPqi", -- [2]
								"TMW:icon:1Z6tL7hdj2mo", -- [3]
								"TMW:icon:1Z6uOhVXfBCq", -- [4]
								"TMW:icon:1YXd9eWHzTSH", -- [5]
								"TMW:icon:1Z6uOhVZgoW8", -- [6]
								"TMW:icon:1YXd9eWMwI0j", -- [7]
								"TMW:icon:1YatF3BT0RKW", -- [8]
								"TMW:icon:1Z6tL7hfkyqu", -- [9]
								"TMW:icon:1YawP4LcafCX", -- [10]
							},
							["Conditions"] = {
								{
									["Name"] = "return not IsAltKeyDown();",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
							},
						}, -- [1]
						{
							["Type"] = "meta",
						}, -- [2]
					},
					["OnlyInCombat"] = true,
				}, -- [4]
			},
			["Version"] = 92500,
		},
		["DEATHKNIGHT"] = {
			["Locked"] = true,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Scale"] = 1,
					["Rows"] = 3,
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["Type"] = "cooldown",
							["Name"] = "Blood Tap",
							["Enabled"] = true,
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["OnlyMine"] = true,
							["Name"] = "Icebound Fortitude",
							["Enabled"] = true,
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 50,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["Type"] = "cooldown",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [2]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Horn of Winter",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "Horn of Winter",
									["Type"] = "BUFFDUR",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1V6lsULwY3_Y",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [3]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [3]
						{
							["GUID"] = "TMW:icon:1V6noP8ARoel",
							["Type"] = "reactive",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Rune Strike",
							["Enabled"] = true,
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Rune Strike",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Divine Shield",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Ice Block",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Anti-Magic Shell",
									["Unit"] = "target",
								}, -- [4]
								["n"] = 4,
							},
							["RangeCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [4]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Anti-Magic Shell",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "local red, green, blue, alpha = RotationFrame_AOERANGECASTING:GetBackdropColor()\nif xRound(red,2) == 0 and xRound(green,2) == 1 and xRound(blue,2) == 0.5 then    \n    return true\nend",
									["Type"] = "LUA",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "ISPLAYER",
									["AndOr"] = "OR",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1ZGiKdRg6oif",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [5]
						[24] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Death Coil",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEFAULT_ABS",
									["Level"] = 20,
									["Operator"] = ">=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1YZamy7DqjiW",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[25] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Death Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "Frost Fever",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "Blood Plague",
									["Unit"] = "target",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1YaXVCdLMBa8",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[26] = {
							["GUID"] = "TMW:icon:1YbFYj2F1X0v",
							["Type"] = "cooldown",
							["Name"] = "Blood Strike",
							["RangeCheck"] = true,
							["Enabled"] = true,
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[27] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Rune Tap",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 65,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1YbGRIr4FVqp",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[28] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blood Boil",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "if xAOE(10) > 4 then\n    return true\nelse\n    return false\nend",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Type"] = "INSTANCE2",
									["BitFlags"] = 2552,
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1Z3Dak8Afvm1",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[29] = {
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Pestilence",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "IsShiftKeyDown();",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Name"] = "Frost Fever",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "Blood Plague",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<=",
									["PrtsBefore"] = 1,
									["Level"] = 5,
									["Name"] = "Frost Fever",
									["Unit"] = "target",
								}, -- [4]
								{
									["Operator"] = "<=",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Blood Plague",
									["Level"] = 5,
									["AndOr"] = "OR",
									["PrtsAfter"] = 2,
									["Unit"] = "target",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1Z4FFfpv6jKF",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[60] = {
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905",
							["GUID"] = "TMW:icon:1ZGiKddAIuOA",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 35,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "28491",
							["OnlyInBags"] = true,
						},
						[21] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Plague Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Blood Plague",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1YYs1I2bCNGy",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [3]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[22] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Icy Touch",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Frost Fever",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1YYs1I2c_Meo",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[23] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Heart Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "Frost Fever",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "Blood Plague",
									["Unit"] = "target",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1YYv3MYeNeSM",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[59] = {
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["GUID"] = "TMW:icon:1ZGiKdd7WnyK",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 60,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "5720",
							["OnlyInBags"] = true,
						},
					},
					["Name"] = "DK Spells",
					["Locked"] = true,
					["Columns"] = 20,
					["Alpha"] = 0,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Columns"] = 1,
					["Point"] = {
						["y"] = -20.00000522536274,
						["x"] = -229.9999934656047,
					},
					["Scale"] = 1.5,
					["Name"] = "Other",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
						}, -- [1]
					},
					["TextureName"] = "Details Flat",
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TeVDtajUwqa",
					["Point"] = {
						["y"] = -140,
						["x"] = -5.450076092640056e-05,
					},
					["Scale"] = 1.5,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZGiKdd7WnyK", -- [1]
								"TMW:icon:1ZGiKddAIuOA", -- [2]
								"TMW:icon:1TeVAjjavXC6", -- [3]
								"TMW:icon:1YYs1I2c_Meo", -- [4]
								"TMW:icon:1Z4FFfpv6jKF", -- [5]
								"TMW:icon:1YYs1I2bCNGy", -- [6]
								"TMW:icon:1YZamy7DqjiW", -- [7]
								"TMW:icon:1YaXVCdLMBa8", -- [8]
								"TMW:icon:1YYv3MYeNeSM", -- [9]
								"TMW:icon:1V6lsULwY3_Y", -- [10]
							},
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [4]
								{
									["Name"] = "return not IsAltKeyDown()",
									["Type"] = "LUA",
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Ice Block",
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Divine Shield",
									["Unit"] = "target",
								}, -- [7]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Anti-Magic Shell",
									["Unit"] = "target",
								}, -- [8]
								["n"] = 8,
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1YXd9eWHzTSH", -- [1]
								"TMW:icon:1YXd9eWMwI0j", -- [2]
								"TMW:icon:1V6noP8ARoel", -- [3]
								"TMW:icon:1V6lsULwY3_Y", -- [4]
							},
						}, -- [2]
					},
					["Name"] = "Rotation CENTER",
					["Locked"] = true,
					["Conditions"] = {
						{
							["Type"] = "MOUNTED",
							["Level"] = 1,
						}, -- [1]
						["n"] = 1,
					},
					["Columns"] = 1,
					["OnlyInCombat"] = true,
				}, -- [3]
				{
					["GUID"] = "TMW:group:1YWtClNC=L8S",
					["Point"] = {
						["y"] = 6.103515625e-05,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Scale"] = 0.4,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZGiKdd7WnyK", -- [1]
								"TMW:icon:1ZGiKddAIuOA", -- [2]
								"TMW:icon:1TeVAjjavXC6", -- [3]
								"TMW:icon:1Z4FFfpv6jKF", -- [4]
								"TMW:icon:1YYs1I2c_Meo", -- [5]
								"TMW:icon:1YYs1I2bCNGy", -- [6]
								"TMW:icon:1YZamy7DqjiW", -- [7]
								"TMW:icon:1YaXVCdLMBa8", -- [8]
								"TMW:icon:1YYv3MYeNeSM", -- [9]
								"TMW:icon:1V6lsULwY3_Y", -- [10]
							},
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [4]
								{
									["Name"] = "return not IsAltKeyDown()",
									["Type"] = "LUA",
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Divine Shield",
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Ice Block",
									["Unit"] = "target",
								}, -- [7]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Anti-Magic Shell",
									["Unit"] = "target",
								}, -- [8]
								["n"] = 8,
							},
						}, -- [1]
						{
							["Type"] = "meta",
						}, -- [2]
					},
					["Name"] = "Rotation TOPLEFT",
					["Locked"] = true,
					["Conditions"] = {
						{
							["Type"] = "MOUNTED",
							["Level"] = 1,
						}, -- [1]
						["n"] = 1,
					},
					["Columns"] = 1,
					["OnlyInCombat"] = true,
				}, -- [4]
				{
					["GUID"] = "TMW:group:1ZI3EjwMFimH",
					["Point"] = {
						["x"] = 161,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Name"] = "ROTATION QUEUE",
					["Scale"] = 0.4,
					["Locked"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1V6noP8ARoel", -- [1]
								"TMW:icon:1TeVAjjXQ0WB", -- [2]
								"TMW:icon:1YbGRIr4FVqp", -- [3]
								"TMW:icon:1ZGiKdRg6oif", -- [4]
							},
							["Conditions"] = {
								{
									["Name"] = "return not IsAltKeyDown()",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
							},
						}, -- [1]
					},
					["OnlyInCombat"] = true,
				}, -- [5]
			},
			["Version"] = 92500,
			["NumGroups"] = 5,
		},
		["DRUID"] = {
			["Locked"] = true,
			["NumGroups"] = 5,
			["Version"] = 92500,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Scale"] = 1,
					["Rows"] = 3,
					["Alpha"] = 0,
					["Name"] = "Druid Spells",
					["Locked"] = true,
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Icons"] = {
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Maul",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "STANCE",
									["Name"] = "Bear Form; Dire Bear Form",
								}, -- [1]
								{
									["Name"] = "if xAOE(10) > 1 then\n    return false\nelse\n    return true\nend",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Name"] = "Berserk",
									["Type"] = "BUFFDUR",
								}, -- [3]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 15,
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
								}, -- [4]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 40,
									["AndOr"] = "OR",
									["Operator"] = ">=",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["RangeCheck"] = true,
							["OnlyMine"] = true,
							["Name"] = "Demoralizing Roar",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Bear Form; Dire Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Demoralizing Roar",
									["Unit"] = "target",
								}, -- [2]
								{
									["Operator"] = "<=",
									["Level"] = 8,
									["Type"] = "LIBRANGECHECK",
									["Unit"] = "target",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [2]
						{
							["GUID"] = "TMW:icon:1V6lsULwY3_Y",
							["Type"] = "cooldown",
							["Name"] = "Swipe (Bear)",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "STANCE",
									["Name"] = "Bear Form; Dire Bear Form",
								}, -- [1]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "if xAOE(10) > 1 then\n    return true\nelse\n    return false\nend",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 40,
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "CURRENTSPELL",
									["PrtsAfter"] = 1,
									["Name"] = "Maul",
								}, -- [4]
								["n"] = 4,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [3]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [3]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Barkskin",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 60,
									["Name"] = "Bear Form; Cat Form",
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1V6noP8ARoel",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [4]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mangle (Cat)",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["Operator"] = "<=",
									["AndOr"] = "OR",
									["Level"] = 10,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["PrtsBefore"] = 1,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["Level"] = 10,
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1Z69muUIlNiY",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [5]
						{
							["GUID"] = "TMW:icon:1Z69muUKqqKC",
							["Type"] = "cooldown",
							["Name"] = "Survival Instincts",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Name"] = "Mangle (Bear)",
									["AndOr"] = "OR",
									["Level"] = 50,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [6]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mangle (Bear)",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Bear Form; Dire Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["PrtsBefore"] = 2,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["Level"] = 10,
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
								}, -- [3]
								{
									["PrtsBefore"] = 1,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["Level"] = 10,
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["AndOr"] = "OR",
									["Name"] = "Berserk",
									["Operator"] = "~=",
								}, -- [6]
								{
									["Type"] = "RAGE",
									["Level"] = 70,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
								}, -- [7]
								["n"] = 7,
							},
							["GUID"] = "TMW:icon:1Z6o5cxM6Qma",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [7]
						[58] = {
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838",
							["GUID"] = "TMW:icon:1ZBi1G1Ik=8q",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 35,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "28491",
							["OnlyInBags"] = true,
						},
						[59] = {
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["GUID"] = "TMW:icon:1ZBi1G1LSN04",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 60,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "5720",
							["OnlyInBags"] = true,
						},
						[60] = {
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Lifeblood",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 75,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZB9ydEakN46",
						},
						[21] = {
							["GUID"] = "TMW:icon:1YYs1I2bCNGy",
							["Type"] = "cooldown",
							["Name"] = "Claw",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Level"] = 4,
									["Operator"] = "<",
								}, -- [2]
								{
									["Name"] = "-- not behind target\nlocal red, green, blue, alpha = RotationFrame_BEHIND:GetBackdropColor()\n\nif xRound(red,2) == 1 and xRound(green,2) == 1 and xRound(blue,2) == 1 then\n    return true\nend",
									["Type"] = "LUA",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["PrtsBefore"] = 1,
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [5]
								["n"] = 5,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [3]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[42] = {
							["GUID"] = "TMW:icon:1YXd9eWMwI0j",
							["Type"] = "buff",
							["Name"] = "Thorns",
							["Conditions"] = {
								{
									["Name"] = "None",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "GROUP2",
									["BitFlags"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["Enabled"] = true,
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						},
						[22] = {
							["GUID"] = "TMW:icon:1ZJNiKMfEYOM",
							["Type"] = "cooldown",
							["Name"] = "Lacerate",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Bear Form; Dire Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Unit"] = "target",
									["PrtsBefore"] = 1,
									["Level"] = 5,
									["Name"] = "Lacerate",
									["Operator"] = "<",
								}, -- [2]
								{
									["Type"] = "RAGE",
									["AndOr"] = "OR",
									["Level"] = 70,
									["Operator"] = ">=",
								}, -- [3]
								{
									["Operator"] = ">",
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Lacerate",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<=",
									["Name"] = "Lacerate",
									["Level"] = 5,
									["PrtsAfter"] = 2,
									["Unit"] = "target",
								}, -- [5]
								{
									["Name"] = "if xAOE(10) > 1 then\n    return false\nelse\n    return true\nend",
									["Type"] = "LUA",
								}, -- [6]
								["n"] = 6,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[44] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Cower",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Unit"] = "target",
									["Level"] = 85,
									["Type"] = "THREATSCALED",
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "GROUP2",
									["Checked"] = true,
									["BitFlags"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1YawP4LcafCX",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[23] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shred",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Name"] = "-- behind target\nlocal red, green, blue, alpha = RotationFrame_BEHIND:GetBackdropColor()\nif xRound(red,2) == 0 and xRound(green,2) == 0 and xRound(blue,2) == 1 then\n    return true\nend",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["PrtsBefore"] = 1,
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [4]
								{
									["Type"] = "COMBO",
									["Level"] = 4,
									["Operator"] = "<",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1YYv3MYeNeSM",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[24] = {
							["GUID"] = "TMW:icon:1YZamy7DqjiW",
							["Type"] = "cooldown",
							["Name"] = "Rake",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Level"] = 4,
									["Operator"] = "<",
								}, -- [2]
								{
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Rake",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["PrtsBefore"] = 1,
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [5]
								{
									["Unit"] = "target",
									["Level"] = 1000,
									["Type"] = "HEALTH_ABS",
									["Operator"] = ">=",
								}, -- [6]
								["n"] = 6,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[25] = {
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Rip",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Level"] = 4,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Unit"] = "target",
									["Level"] = 5000,
									["Type"] = "HEALTH_ABS",
									["Operator"] = ">",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["PrtsBefore"] = 1,
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [5]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Rip",
									["Unit"] = "target",
								}, -- [6]
								["n"] = 6,
							},
							["GUID"] = "TMW:icon:1YaXVCdLMBa8",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[26] = {
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Ferocious Bite",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "HEALTH_ABS",
									["PrtsBefore"] = 1,
									["Level"] = 5000,
									["Unit"] = "target",
									["Operator"] = "<=",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Name"] = "Rip",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = ">=",
									["Name"] = "Rip",
									["Level"] = 5,
									["PrtsAfter"] = 2,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "COMBO",
									["Level"] = 4,
									["Operator"] = ">=",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1YbFYj2F1X0v",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[41] = {
							["GUID"] = "TMW:icon:1YXd9eWHzTSH",
							["Type"] = "buff",
							["Name"] = "Mark of the Wild",
							["Conditions"] = {
								{
									["Name"] = "None",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						},
						[27] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Nature's Grasp",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "ISPLAYER",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1ZJOZ6wmptif",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[29] = {
							["GUID"] = "TMW:icon:1Z4qW_DgW_ek",
							["Type"] = "cooldown",
							["Name"] = "Tiger's Fury",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "Rake",
									["Unit"] = "target",
								}, -- [2]
								{
									["Name"] = "Berserk",
									["Type"] = "BUFFDUR",
								}, -- [3]
								["n"] = 3,
							},
							["ManaCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[28] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Pounce",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Prowl",
									["Operator"] = "~=",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1Z3Dak8Afvm1",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
						[56] = {
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Curse",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1YXC4srUja8k",
									["Texts"] = {
										[2] = "[Stacks:Hide(0)]",
									},
								},
							},
							["BuffOrDebuff"] = "HARMFUL",
							["GUID"] = "TMW:icon:1ZKevCddhaS_",
						},
						[57] = {
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Poison",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1YXC4srUja8k",
								},
							},
							["BuffOrDebuff"] = "HARMFUL",
							["GUID"] = "TMW:icon:1ZKevCdgnbud",
						},
						[43] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Faerie Fire (Feral)",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Bear Form; Cat Form; Dire Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Faerie Fire (Feral)",
									["Unit"] = "target",
								}, -- [2]
								{
									["Name"] = "Prowl",
									["Type"] = "BUFFDUR",
								}, -- [3]
								{
									["Operator"] = "<=",
									["Level"] = 5,
									["Type"] = "LIBRANGECHECK",
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "CREATURETYPE",
									["Level"] = 1,
									["Name"] = "Elemental",
									["Unit"] = "target",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1YatF3BT0RKW",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						},
					},
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Columns"] = 1,
					["Point"] = {
						["y"] = -20.00000522536274,
						["x"] = -229.9999934656047,
					},
					["Scale"] = 1.5,
					["Name"] = "Other",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1Z3Dak8Afvm1", -- [1]
								"TMW:icon:1ZKevCdgnbud", -- [2]
								"TMW:icon:1ZKevCddhaS_", -- [3]
							},
						}, -- [1]
					},
					["TextureName"] = "Details Flat",
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TeVDtajUwqa",
					["Point"] = {
						["y"] = -140,
						["x"] = -5.450076092640056e-05,
					},
					["Name"] = "Rotation CENTER",
					["Scale"] = 1.5,
					["Locked"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZB9ydEakN46", -- [1]
								"TMW:icon:1ZBi1G1Ik=8q", -- [2]
								"TMW:icon:1ZBi1G1LSN04", -- [3]
								"TMW:icon:1V6noP8ARoel", -- [4]
								"TMW:icon:1Z69muUKqqKC", -- [5]
								"TMW:icon:1YatF3BT0RKW", -- [6]
								"TMW:icon:1TeVAjjavXC6", -- [7]
								"TMW:icon:1ZJNiKMfEYOM", -- [8]
								"TMW:icon:1YbFYj2F1X0v", -- [9]
								"TMW:icon:1YaXVCdLMBa8", -- [10]
								"TMW:icon:1Z6o5cxM6Qma", -- [11]
								"TMW:icon:1Z69muUIlNiY", -- [12]
								"TMW:icon:1V6lsULwY3_Y", -- [13]
								"TMW:icon:1Z4qW_DgW_ek", -- [14]
								"TMW:icon:1YZamy7DqjiW", -- [15]
								"TMW:icon:1YYs1I2bCNGy", -- [16]
								"TMW:icon:1YYv3MYeNeSM", -- [17]
							},
							["Conditions"] = {
								{
									["Name"] = "return not IsAltKeyDown();",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1YXd9eWHzTSH", -- [1]
								"TMW:icon:1YXd9eWMwI0j", -- [2]
								"TMW:icon:1V6noP8ARoel", -- [3]
								"TMW:icon:1V6lsULwY3_Y", -- [4]
							},
						}, -- [2]
					},
					["OnlyInCombat"] = true,
				}, -- [3]
				{
					["GUID"] = "TMW:group:1YWtClNC=L8S",
					["Columns"] = 1,
					["Scale"] = 0.4,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZB9ydEakN46", -- [1]
								"TMW:icon:1ZBi1G1Ik=8q", -- [2]
								"TMW:icon:1ZBi1G1LSN04", -- [3]
								"TMW:icon:1V6noP8ARoel", -- [4]
								"TMW:icon:1Z69muUKqqKC", -- [5]
								"TMW:icon:1YatF3BT0RKW", -- [6]
								"TMW:icon:1TeVAjjavXC6", -- [7]
								"TMW:icon:1YbFYj2F1X0v", -- [8]
								"TMW:icon:1YaXVCdLMBa8", -- [9]
								"TMW:icon:1Z6o5cxM6Qma", -- [10]
								"TMW:icon:1Z69muUIlNiY", -- [11]
								"TMW:icon:1ZJNiKMfEYOM", -- [12]
								"TMW:icon:1V6lsULwY3_Y", -- [13]
								"TMW:icon:1Z4qW_DgW_ek", -- [14]
								"TMW:icon:1YZamy7DqjiW", -- [15]
								"TMW:icon:1YYs1I2bCNGy", -- [16]
								"TMW:icon:1YYv3MYeNeSM", -- [17]
							},
							["Conditions"] = {
								{
									["Name"] = "return not IsAltKeyDown();",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
							},
						}, -- [1]
						{
							["Type"] = "meta",
						}, -- [2]
					},
					["SortPriorities"] = {
						{
							["Order"] = -1,
						}, -- [1]
					},
					["Name"] = "Rotation TOPLEFT",
					["Locked"] = true,
					["Point"] = {
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["OnlyInCombat"] = true,
				}, -- [4]
				{
					["GUID"] = "TMW:group:1ZI1LEibEVeR",
					["Point"] = {
						["x"] = 161,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Name"] = "ROTATION QUEUE",
					["Scale"] = 0.4,
					["Locked"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TeVAjjXQ0WB", -- [1]
								"TMW:icon:1ZJOZ6wmptif", -- [2]
							},
							["Conditions"] = {
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [1]
								{
									["Name"] = "return not IsAltKeyDown();",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [5]
								["n"] = 5,
							},
						}, -- [1]
					},
					["OnlyInCombat"] = true,
				}, -- [5]
			},
		},
		["Tudum - Ashbringer"] = {
			["Version"] = 92500,
		},
		["WARLOCK"] = {
			["Locked"] = true,
			["NumGroups"] = 5,
			["Version"] = 91200,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Point"] = {
						["y"] = -20,
						["x"] = -230,
					},
					["Name"] = "Other",
					["Scale"] = 1.5,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TZvNvgAkfmq", -- [1]
								"TMW:icon:1TWYSTcSCl0z", -- [2]
							},
						}, -- [1]
					},
					["TextureName"] = "Details Flat",
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYSTcQ410f",
					["Columns"] = 20,
					["Scale"] = 1,
					["Alpha"] = 0,
					["TextureName"] = "Details Flat",
					["Name"] = "General Buffs/Debbufs",
					["Locked"] = true,
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TWYSTcSCl0z",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
							["Name"] = "Blood Fury",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1TZve345g=GK",
								},
							},
							["Name"] = "Enrage",
							["GUID"] = "TMW:icon:1TZvNvgAkfmq",
						}, -- [2]
					},
					["Point"] = {
						["y"] = -40,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
				}, -- [2]
				{
					["GUID"] = "TMW:group:1V6krZ0tqss=",
					["Point"] = {
						["y"] = 6.103515625e-05,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Scale"] = 0.4,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1V6ky7UjmQN=", -- [1]
								"TMW:icon:1V6ky7UreCKN", -- [2]
								"TMW:icon:1V6ky7Uy=NmE", -- [3]
								"TMW:icon:1YXBfKWFOMGr", -- [4]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1V6ky7UreCKN", -- [1]
							},
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1V6ky7Uy=NmE", -- [1]
							},
						}, -- [3]
					},
					["LayoutDirection"] = 2,
					["Name"] = "Rotation TOPLEFT",
					["Locked"] = true,
					["Columns"] = 1,
					["OnlyInCombat"] = true,
				}, -- [3]
				{
					["GUID"] = "TMW:group:1V6ky7Uf4nZ5",
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Name"] = "Warlock Spells",
					["Alpha"] = 0,
					["Scale"] = 1,
					["Columns"] = 20,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Immolate",
							["Conditions"] = {
								{
									["Operator"] = "<=",
									["Level"] = 30,
									["Type"] = "LIBRANGECHECK",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Immolate",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1V6ky7UjmQN=",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Corruption",
							["Conditions"] = {
								{
									["Operator"] = "<=",
									["Level"] = 30,
									["Type"] = "LIBRANGECHECK",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1V6ky7UreCKN",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Curse of Agony",
							["Conditions"] = {
								{
									["Operator"] = "<=",
									["Level"] = 30,
									["Type"] = "LIBRANGECHECK",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1V6ky7Uy=NmE",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [3]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shadow Bolt",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Shadow Bolt",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1YXBfKWFOMGr",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [4]
						[20] = {
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "healh",
						},
					},
					["Locked"] = true,
				}, -- [4]
				{
					["GUID"] = "TMW:group:1YWt9BdVNgGm",
					["Columns"] = 1,
					["Scale"] = 1.5,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1V6ky7UjmQN=", -- [1]
								"TMW:icon:1V6ky7UreCKN", -- [2]
								"TMW:icon:1V6ky7Uy=NmE", -- [3]
								"TMW:icon:1YXBfKWFOMGr", -- [4]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1V6ky7UreCKN", -- [1]
							},
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1V6ky7Uy=NmE", -- [1]
							},
						}, -- [3]
					},
					["LayoutDirection"] = 2,
					["Name"] = "Rotation CENTER",
					["Locked"] = true,
					["Point"] = {
						["y"] = -88,
						["x"] = -5.450076092640056e-05,
					},
					["OnlyInCombat"] = true,
				}, -- [5]
			},
		},
	},
}
