
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
		["Handrmandr - Golemagg"] = "WARRIOR",
		["Tudum - Ashbringer"] = "WARRIOR",
		["Augustin - Golemagg"] = "MAGE",
		["Tudum - Jin'do"] = "WARRIOR",
		["Vermin - Golemagg"] = "WARRIOR",
		["Mxyzptlk - Golemagg"] = "WARLOCK",
		["Moolatz - Golemagg"] = "DRUID",
		["Poklopac - Mirage Raceway"] = "HUNTER",
		["Provokator - Jin'do"] = "HUNTER",
		["Wells - Jin'do"] = "DRUID",
		["Miqa - Golemagg"] = "PRIEST",
		["Pitchwise - Ashbringer"] = "SHAMAN",
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
			["TMW:textlayout:1Y9UVC8yK0C2"] = {
				{
					["Outline"] = "OUTLINE",
					["Justify"] = "RIGHT",
					["Anchors"] = {
						{
							["point"] = "BOTTOMRIGHT",
							["relativePoint"] = "BOTTOMRIGHT",
						}, -- [1]
					},
					["DefaultText"] = "[PercentHP(unit=\"Pet\"):Percent:HPColor]  ",
					["ConstrainWidth"] = false,
					["StringName"] = "Number",
					["Size"] = 8,
				}, -- [1]
				["GUID"] = "TMW:textlayout:1Y9UVC8yK0C2",
				["Name"] = "HPAbove",
			},
			["icon1"] = {
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
					["DefaultText"] = "[Stacks:Hide(0)]",
					["Anchors"] = {
						{
							["y"] = 2,
							["point"] = "BOTTOMRIGHT",
							["relativePoint"] = "BOTTOMRIGHT",
						}, -- [1]
					},
					["Outline"] = "OUTLINE",
					["StringName"] = "Stacks",
					["SkinAs"] = "Count",
					["Size"] = 9,
				}, -- [2]
				["GUID"] = "TMW:textlayout:1TZve345g=GK",
				["Name"] = "STACKS",
				["n"] = 2,
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
	["Version"] = 100500,
	["profiles"] = {
		["HUNTER"] = {
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Point"] = {
						["y"] = -4.996173281900221,
						["x"] = -0.0002605930177353105,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Scale"] = 1.0008,
					["Rows"] = 3,
					["Alpha"] = 0,
					["Name"] = "SPELLS",
					["Locked"] = true,
					["Columns"] = 20,
					["Icons"] = {
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Serpent Sting",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Serpent Sting",
									["Level"] = 1,
								}, -- [1]
								{
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Serpent Sting",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "NAME",
									["Level"] = 1,
									["Name"] = "Princess Theradras",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "CREATURETYPE",
									["Level"] = 1,
									["Name"] = "Elemental",
									["Unit"] = "target",
								}, -- [4]
								["n"] = 4,
							},
							["RangeCheck"] = true,
							["States"] = {
								{
								}, -- [1]
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Enabled"] = true,
							["ShowTimerText"] = true,
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["Name"] = "Hunter's Mark",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Hunter's Mark",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["RangeCheck"] = true,
							["States"] = {
								{
								}, -- [1]
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Arcane Shot",
							["RangeCheck"] = true,
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1V6lsULwY3_Y",
							["States"] = {
								{
								}, -- [1]
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Aspect of the Hawk",
							["GUID"] = "TMW:icon:1V6noP8ARoel",
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Level"] = 60,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Name"] = "Aspect of the Hawk",
									["Type"] = "BUFFDUR",
								}, -- [2]
								["n"] = 2,
							},
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [4]
						{
							["Enabled"] = true,
							["Type"] = "reactive",
							["Name"] = "Kill Shot",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1ZNfjO2NI8Ga",
							["CooldownCheck"] = true,
							["States"] = {
								{
								}, -- [1]
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Multi-Shot",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "if xAOE(20) > 1 then\n    return true\nelse\n    return true\nend",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "SPEED",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1YS2u64Alj4P",
							["States"] = {
								{
								}, -- [1]
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Steady Shot",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Steady Shot",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["PrtsBefore"] = 1,
									["Operator"] = "~=",
									["Name"] = "Serpent Sting",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "NAME",
									["Name"] = "Princess Theradras",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "SPEED",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1YS2u64Csf0H",
							["States"] = {
								{
								}, -- [1]
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
						}, -- [7]
						{
							["Enabled"] = true,
							["Type"] = "reactive",
							["RangeCheck"] = true,
							["CooldownCheck"] = true,
							["Name"] = "Kill Command",
							["ManaCheck"] = true,
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
							["GUID"] = "TMW:icon:1YYUluwZXp0V",
							["States"] = {
								{
								}, -- [1]
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Aspect of the Viper",
							["GUID"] = "TMW:icon:1ZB8mNf2cjSi",
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Level"] = 10,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Name"] = "Aspect of the Viper",
									["Type"] = "BUFFDUR",
								}, -- [2]
								["n"] = 2,
							},
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [9]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [10]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [11]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [12]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [13]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [14]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [15]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [16]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [17]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["RangeCheck"] = true,
							["Unit"] = "pet",
							["Name"] = "Mend Pet",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Operator"] = "<=",
									["Level"] = 90,
									["Type"] = "HEALTH",
									["Unit"] = "pet",
								}, -- [1]
								{
									["Checked"] = true,
									["Type"] = "BUFFDUR",
									["Name"] = "Mend Pet",
									["Unit"] = "pet",
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
							["GUID"] = "TMW:icon:1X=OmHlbqz67",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [18]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [19]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [20]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "EITHER",
							["Unit"] = "target",
							["Name"] = "Enraged",
							["RangeCheck"] = true,
							["ManaCheck"] = true,
							["CustomTex"] = "19801",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [21]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Chimera Shot",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "Serpent Sting",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZDQ16jlvSmQ",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [22]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Aimed Shot",
							["GUID"] = "TMW:icon:1ZDQ16jnm6W=",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Name"] = "Chimera Shot",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Name"] = "if xAOE(20) > 1 then\n    return false\nelse\n    return false\nend",
									["Type"] = "LUA",
								}, -- [2]
								["n"] = 2,
							},
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [23]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Trueshot Aura",
							["Conditions"] = {
								{
									["Name"] = "Trueshot Aura",
									["Type"] = "BUFFDUR",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZDQ16jpl=uP",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [24]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Deterrence",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 20,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZDQ16jrgNie",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [25]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Misdirection",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Unit"] = "pet",
								}, -- [1]
								{
									["Operator"] = ">=",
									["Level"] = 2000,
									["Type"] = "HEALTH_ABS",
									["Unit"] = "target",
								}, -- [2]
								{
									["Unit"] = "target",
									["Type"] = "DEBUFFDUR",
									["Name"] = "Serpent Sting",
									["Operator"] = "~=",
								}, -- [3]
								{
									["Type"] = "INSTANCE2",
									["BitFlags"] = 1,
								}, -- [4]
								["n"] = 4,
							},
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
						}, -- [26]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Concussive Shot",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "THREATSCALED",
									["Level"] = 100,
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZDRwPNU7Z0Z",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [27]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Wing Clip",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Wing Clip",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZEKCuryiveD",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [28]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [29]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [30]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [31]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [32]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [33]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [34]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [35]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [36]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [37]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [38]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [39]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [40]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [41]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [42]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [43]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [44]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [45]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [46]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [47]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [48]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [49]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [50]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [51]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [52]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [53]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [54]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "1742",
							["Conditions"] = {
								{
									["Unit"] = "pet",
									["Level"] = 40,
									["Type"] = "HEALTH",
									["Operator"] = "<=",
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
							["GUID"] = "TMW:icon:1ZG0cMPPKbCD",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [55]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "53478",
							["Conditions"] = {
								{
									["Operator"] = "<=",
									["Level"] = 30,
									["Type"] = "HEALTH",
									["Unit"] = "pet",
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
							["GUID"] = "TMW:icon:1ZFQDm2Teoqd",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [56]
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["GUID"] = "TMW:icon:1ZFP_8OYz7Gr",
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
						}, -- [57]
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["GUID"] = "TMW:icon:1ZFP_8OauieW",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 30,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "28491",
							["OnlyInBags"] = true,
						}, -- [58]
						{
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
							["GUID"] = "TMW:icon:1ZB9QFefrfi_",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [59]
						{
							["GUID"] = "TMW:icon:1ZB9QFehlUaz",
							["Type"] = "item",
							["Name"] = "22795",
							["OnlyInBags"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 55,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [60]
					},
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["TextureName"] = "Details Flat",
					["Name"] = "OTHER",
					["Point"] = {
						["y"] = -20,
						["x"] = -230,
					},
					["Scale"] = 1.5,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TeVAjjXQ0WB", -- [1]
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
					},
					["OnlyInCombat"] = true,
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TeVDtajUwqa",
					["Point"] = {
						["y"] = -100,
						["x"] = -5.450076092640056e-05,
					},
					["Name"] = "ROTATION CENTER",
					["Scale"] = 1.5,
					["Locked"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
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
									["Type"] = "CURRENTSPELL",
									["Name"] = "Volley",
									["Level"] = 1,
								}, -- [5]
								{
									["Name"] = "Feign Death",
									["Type"] = "BUFFDUR",
								}, -- [6]
								{
									["Name"] = "return not IsAltKeyDown()",
									["Type"] = "LUA",
								}, -- [7]
								{
									["Name"] = "Food",
									["Type"] = "BUFFDUR",
								}, -- [8]
								{
									["Name"] = "Drink",
									["Type"] = "BUFFDUR",
								}, -- [9]
								["n"] = 9,
							},
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
								"TMW:icon:1ZNfjO2NI8Ga", -- [15]
								"TMW:icon:1YYUluwZXp0V", -- [16]
								"TMW:icon:1ZDQ16jlvSmQ", -- [17]
								"TMW:icon:1ZDQ16jnm6W=", -- [18]
								"TMW:icon:1YS2u64Alj4P", -- [19]
								"TMW:icon:1V6lsULwY3_Y", -- [20]
								"TMW:icon:1YS2u64Csf0H", -- [21]
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1X=OmHlbqz67", -- [1]
								"TMW:icon:1YYUluwZXp0V", -- [2]
								"TMW:icon:1YS2u64Alj4P", -- [3]
								"TMW:icon:1YS2u64Csf0H", -- [4]
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1X=OmHlbqz67", -- [1]
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [3]
					},
					["OnlyInCombat"] = true,
				}, -- [3]
				{
					["GUID"] = "TMW:group:1YWH=DtwTpKV",
					["Point"] = {
						["y"] = -0.00067138671875,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Name"] = "ROTATION TOPLEFT",
					["Scale"] = 0.4,
					["Locked"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
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
									["Type"] = "CURRENTSPELL",
									["Name"] = "Volley",
									["Level"] = 1,
								}, -- [5]
								{
									["Name"] = "Feign Death",
									["Type"] = "BUFFDUR",
								}, -- [6]
								{
									["Name"] = "return not IsAltKeyDown()",
									["Type"] = "LUA",
								}, -- [7]
								{
									["Name"] = "Food",
									["Type"] = "BUFFDUR",
								}, -- [8]
								{
									["Name"] = "Drink",
									["Type"] = "BUFFDUR",
								}, -- [9]
								["n"] = 9,
							},
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
								"TMW:icon:1ZNfjO2NI8Ga", -- [15]
								"TMW:icon:1YYUluwZXp0V", -- [16]
								"TMW:icon:1ZDQ16jlvSmQ", -- [17]
								"TMW:icon:1ZDQ16jnm6W=", -- [18]
								"TMW:icon:1YS2u64Alj4P", -- [19]
								"TMW:icon:1V6lsULwY3_Y", -- [20]
								"TMW:icon:1YS2u64Csf0H", -- [21]
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
					},
					["OnlyInCombat"] = true,
				}, -- [4]
				{
					["GUID"] = "TMW:group:1ZNbDZWSALqf",
					["Point"] = {
						["x"] = 30,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Name"] = "OFFGCD",
					["Scale"] = 0.4,
					["Locked"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZDRwPNRMoWc", -- [1]
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
					},
					["OnlyInCombat"] = true,
				}, -- [5]
			},
			["Locked"] = true,
			["Version"] = 100500,
			["NumGroups"] = 5,
			["TextureName"] = "Glamour2",
		},
		["WARRIOR"] = {
			["Version"] = 100500,
			["NumGroups"] = 7,
			["TextureName"] = "Glamour2",
			["Groups"] = {
				{
					["Scale"] = 1,
					["Rows"] = 2,
					["Locked"] = true,
					["GUID"] = "TMW:group:1TQvxnAfbGyU",
					["Columns"] = 20,
					["Icons"] = {
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Type"] = "cooldown",
							["ManaCheck"] = true,
							["Name"] = "Rend",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Rend",
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "if xAOE(5) > 1 then\n    return false\nelse\n    return true\nend",
									["PrtsBefore"] = 1,
								}, -- [2]
								{
									["Type"] = "SPEC",
									["PrtsAfter"] = 1,
									["AndOr"] = "OR",
									["Level"] = 2,
								}, -- [3]
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance; Battle Stance",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1TQv_LtTwAae",
							["States"] = {
								{
								}, -- [1]
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
						}, -- [1]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Battle Shout",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Battle Shout",
									["PrtsBefore"] = 1,
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "Commanding Shout",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Greater Blessing of Might",
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["PrtsAfter"] = 1,
									["Name"] = "Blessing of Might",
								}, -- [4]
								["n"] = 4,
							},
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1TQv_Ltf40Wl",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
								},
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [2]
						{
							["Type"] = "reactive",
							["Enabled"] = true,
							["Name"] = "Heroic Strike",
							["GUID"] = "TMW:icon:1TQv_Lti1RyX",
							["ManaCheck"] = true,
							["States"] = {
								{
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
									["Type"] = "LUA",
									["Name"] = "if xAOE(10)>1 then\n    return false\nelse \n    return true\nend",
								}, -- [1]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Heroic Strike",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 60,
								}, -- [3]
								{
									["Type"] = "LUA",
									["Name"] = "return xRange(10)",
								}, -- [4]
								["n"] = 4,
							},
						}, -- [3]
						{
							["Type"] = "cooldown",
							["Name"] = "Overpower",
							["ShowTimerText"] = true,
							["GUID"] = "TMW:icon:1TU=hLnlwyeY",
							["States"] = {
								{
								}, -- [1]
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
							["Conditions"] = {
								{
									["Type"] = "REACTIVE",
									["Checked"] = true,
									["Name"] = "Overpower",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["Name"] = "Battle Stance",
								}, -- [2]
								["n"] = 2,
							},
						}, -- [4]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Demoralizing Shout",
							["GUID"] = "TMW:icon:1TWZdpV26rm5",
							["ManaCheck"] = true,
							["States"] = {
								{
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
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Unit"] = "target",
									["Name"] = "Demoralizing Shout",
								}, -- [2]
								{
									["Type"] = "LUA",
									["Name"] = "return xRange(5)",
								}, -- [3]
								["n"] = 3,
							},
						}, -- [5]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Type"] = "cooldown",
							["HideIfNoUnits"] = true,
							["Enabled"] = true,
							["Name"] = "Sunder Armor",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFSTACKS",
									["Operator"] = "<",
									["Unit"] = "target",
									["Name"] = "Sunder Armor",
									["PrtsBefore"] = 2,
									["Level"] = 5,
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
									["Level"] = 6,
									["Unit"] = "target",
									["Name"] = "Sunder Armor",
									["AndOr"] = "OR",
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["Unit"] = "target",
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "INSTANCE2",
									["BitFlags"] = 480,
								}, -- [4]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "if xAOE(5) > 1 then\n    return false\nelse\n    return true\nend",
								}, -- [5]
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [6]
								{
									["Type"] = "DEBUFFSTACKS",
									["Operator"] = "<",
									["Unit"] = "target",
									["Name"] = "Sunder Armor",
									["PrtsBefore"] = 1,
									["Level"] = 5,
								}, -- [7]
								{
									["Type"] = "DEBUFFDUR",
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
									["AndOr"] = "OR",
									["Unit"] = "target",
									["Name"] = "Sunder Armor",
									["Level"] = 6,
								}, -- [8]
								{
									["Type"] = "LUA",
									["Name"] = "if xAOE(5) > 1 then\n    return false\nelse\n    return true\nend",
								}, -- [9]
								{
									["Type"] = "REACTIVE",
									["Checked"] = true,
									["PrtsAfter"] = 1,
									["Name"] = "Revenge",
									["Level"] = 1,
								}, -- [10]
								["n"] = 10,
							},
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1TYYu4EDbfSz",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks:Hide(0)]", -- [2]
									},
								},
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
						}, -- [6]
						{
							["Type"] = "reactive",
							["IgnoreNomana"] = true,
							["Enabled"] = true,
							["Name"] = "Execute",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1TZvNvflXM0_",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
						}, -- [7]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Revenge",
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1Xrn34GriOqy",
							["Conditions"] = {
								{
									["Type"] = "REACTIVE",
									["Checked"] = true,
									["Name"] = "Revenge",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
								}, -- [2]
								["n"] = 2,
							},
						}, -- [8]
						{
							["Type"] = "reactive",
							["Enabled"] = true,
							["Name"] = "Cleave",
							["GUID"] = "TMW:icon:1Y2=7t59vfSn",
							["ManaCheck"] = true,
							["States"] = {
								{
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
									["Type"] = "CURRENTSPELL",
									["Name"] = "Cleave",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "if xAOE(10) > 1 then\n    return true\nelse\n    return false\nend",
									["PrtsBefore"] = 2,
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
									["Level"] = 60,
								}, -- [3]
								{
									["Type"] = "LUA",
									["Name"] = "if xAOE(10) > 2 then\n    return true\nelse\n    return false\nend",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [4]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Name"] = "Defensive Stance",
									["Level"] = 25,
								}, -- [5]
								{
									["Type"] = "STANCE",
									["PrtsAfter"] = 2,
								}, -- [6]
								{
									["Type"] = "LUA",
									["Name"] = "return xRange(10)",
								}, -- [7]
								["n"] = 7,
							},
						}, -- [9]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Whirlwind",
							["GUID"] = "TMW:icon:1Xwc=6KNp27d",
							["States"] = {
								{
								}, -- [1]
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
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Berserker Stance",
								}, -- [1]
								{
									["Type"] = "HEALTH",
									["Unit"] = "target",
									["Operator"] = ">",
									["Level"] = 20,
								}, -- [2]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "LUA",
									["Name"] = "if xAOE(10) > 1 then\n    return true\nelse\n    return false\nend",
									["PrtsBefore"] = 1,
								}, -- [4]
								{
									["Type"] = "SPELLCD",
									["Operator"] = "~=",
									["Name"] = "Mortal Strike",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 2,
									["Operator"] = "~=",
									["Name"] = "Bloodthirst",
									["AndOr"] = "OR",
								}, -- [6]
								["n"] = 6,
							},
						}, -- [10]
						{
							["Type"] = "reactive",
							["Enabled"] = true,
							["Name"] = "Victory Rush",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1YP2Xjgjriiu",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
						}, -- [11]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Spell Reflection",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1ZGdp_HEzv8p",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance; Battle Stance",
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "IsEquippedItemType(\"Shields\")",
									["PrtsBefore"] = 1,
								}, -- [2]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "local red, green, blue, alpha = RotationFrame_AOERANGECASTING:GetBackdropColor()\nif xRound(red,2) == 0 and xRound(green,2) ==1 and xRound(blue,2) == 0.5 then\n    return true\nend",
									["PrtsBefore"] = 1,
								}, -- [3]
								{
									["Type"] = "NAME",
									["Unit"] = "target",
									["Name"] = "Tempest-Forge Peacekeeper",
									["AndOr"] = "OR",
								}, -- [4]
								{
									["Type"] = "ISPLAYER",
									["Unit"] = "target",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Type"] = "REACT",
									["PrtsAfter"] = 2,
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [6]
								["n"] = 6,
							},
						}, -- [12]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Mortal Strike",
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1XzwOSGxkHLD",
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "if xAOE(5) > 1 then\n    return false\nelse\n    return true\nend",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["Name"] = "Battle Stance; Berserker Stance",
									["AndOr"] = "OR",
								}, -- [2]
								["n"] = 2,
							},
						}, -- [13]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Pummel",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
								}, -- [4]
							},
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Berserker Stance",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [14]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Slam",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "Slam!",
									["AndOr"] = "OR",
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 40,
								}, -- [2]
								{
									["Type"] = "SPEED",
								}, -- [3]
								{
									["Type"] = "SPEC",
									["Name"] = "DPS",
									["Level"] = 2,
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1ZQcfScLCzCQ",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
						}, -- [15]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Bloodthirst",
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1YEqZQbYmmFD",
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "if xAOE(5) > 1 then\n    return false\nelse\n    return true\nend",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["Name"] = "Battle Stance; Berserker Stance",
									["AndOr"] = "OR",
								}, -- [2]
								["n"] = 2,
							},
						}, -- [16]
						{
							["Type"] = "reactive",
							["Enabled"] = true,
							["Name"] = "Rampage",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Operator"] = "<=",
									["Name"] = "Rampage",
									["Level"] = 10,
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1YO4Qlh73rOw",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [17]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Sweeping Strikes",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Battle Stance; Berserker Stance",
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "if xAOE(10) > 1 then\n    return true\nelse\n    return false\nend",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1YO55KEUKaW4",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [18]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Thunder Clap",
							["GUID"] = "TMW:icon:1YWHZ7T27TKe",
							["ManaCheck"] = true,
							["States"] = {
								{
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
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Unit"] = "target",
									["Name"] = "Thunder Clap",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Sweeping Strikes",
								}, -- [3]
								{
									["Type"] = "LUA",
									["Name"] = "if xAOE(10) >= 1 then\n    return true\nelse\n    return false\nend",
								}, -- [4]
								{
									["Type"] = "LUA",
									["Name"] = "return xRange(5)",
								}, -- [5]
								["n"] = 5,
							},
						}, -- [19]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Hamstring",
							["Conditions"] = {
								{
									["Type"] = "ISPLAYER",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Unit"] = "target",
									["Name"] = "Hamstring",
								}, -- [2]
								{
									["Type"] = "STANCE",
									["Name"] = "Battle Stance; Berserker Stance",
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Unit"] = "target",
									["Name"] = "Hand of Freedom",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1TWYMfcUzmi6",
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
						}, -- [20]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Devastate",
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1Z55tRw3mJGc",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [21]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Last Stand",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1Z55tRw68qC=",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 50,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [22]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Shield Block",
							["GUID"] = "TMW:icon:1Z55tRw8OaCM",
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [23]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Shield Slam",
							["GUID"] = "TMW:icon:1Z55tRwA_pKn",
							["States"] = {
								{
								}, -- [1]
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
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "IsEquippedItemType(\"Shields\")",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [24]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Vigilance",
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1Z7AzkxDmWSh",
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
									["Unit"] = "focus",
									["Level"] = 2,
								}, -- [3]
								["n"] = 3,
							},
						}, -- [25]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Concussion Blow",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
									["PrtsBefore"] = 4,
								}, -- [1]
								{
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
									["Name"] = "Shield Bash",
								}, -- [2]
								{
									["Type"] = "STANCE",
									["Name"] = "Berserker Stance",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
									["Name"] = "Pummel",
								}, -- [4]
								{
									["Type"] = "STANCE",
									["Name"] = "Battle Stance",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Type"] = "LUA",
									["Name"] = "IsEquippedItemType(\"Shields\")",
								}, -- [6]
								{
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 2,
									["Operator"] = "~=",
									["Name"] = "Shield Bash",
								}, -- [7]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "xUnitCasting(\"target\")",
								}, -- [8]
								{
									["Type"] = "ISPLAYER",
									["Unit"] = "target",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [9]
								{
									["Type"] = "REACT",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [10]
								{
									["Type"] = "BUFFDUR",
									["PrtsAfter"] = 1,
									["Name"] = "Spell Reflection",
								}, -- [11]
								{
									["Type"] = "LUA",
									["Name"] = "xUnitCastingNonInteruptable(\"target\")",
									["AndOr"] = "OR",
								}, -- [12]
								["n"] = 12,
							},
							["GUID"] = "TMW:icon:1Z679nrqAgG4",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["RangeCheck"] = true,
						}, -- [26]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Shield Wall",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1Z7PEaKwPKnX",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 40,
								}, -- [1]
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
								}, -- [2]
								["n"] = 2,
							},
						}, -- [27]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Commanding Shout",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1Z7PEaK_TNq3",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "Battle Shout",
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Commanding Shout",
								}, -- [2]
								["n"] = 2,
							},
						}, -- [28]
						{
							["BuffOrDebuff"] = "EITHER",
							["Type"] = "buff",
							["Enabled"] = true,
							["Name"] = "Feared; Sap; Incapacitated",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1Z7R_6NwuWuK",
							["CustomTex"] = "18499",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [29]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [30]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Disarm",
							["GUID"] = "TMW:icon:1Z9CIRRFbqSA",
							["States"] = {
								{
								}, -- [1]
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
									["Unit"] = "target",
									["Level"] = 1,
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
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
								}, -- [7]
								["n"] = 7,
							},
						}, -- [31]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [32]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [33]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [34]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [35]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [36]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [37]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [38]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [39]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [40]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [41]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [42]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [43]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [44]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [45]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [46]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [47]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [48]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [49]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [50]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [51]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [52]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [53]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [54]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [55]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [56]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [57]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [58]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [59]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [60]
					},
					["Name"] = "SPELLS",
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Alpha"] = 0,
				}, -- [1]
				{
					["Scale"] = 1,
					["TextureName"] = "Details Flat",
					["Locked"] = true,
					["GUID"] = "TMW:group:1TWYSTcQ410f",
					["Columns"] = 20,
					["Alpha"] = 0,
					["Name"] = "GENERAL",
					["Point"] = {
						["y"] = -65,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Icons"] = {
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["Name"] = "Blood Fury",
							["GUID"] = "TMW:icon:1TWYSTcSCl0z",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["Enabled"] = true,
						}, -- [1]
						{
							["Type"] = "buff",
							["Name"] = "Enrage",
							["ShowTimerText"] = true,
							["GUID"] = "TMW:icon:1TZvNvgAkfmq",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1TZve345g=GK",
								},
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["Enabled"] = true,
						}, -- [2]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["Name"] = "Recently Bandaged",
							["GUID"] = "TMW:icon:1Xx3hMFQR0cV",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["Enabled"] = true,
						}, -- [3]
						{
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["Name"] = "Sweeping Strikes",
							["GUID"] = "TMW:icon:1YXBo4F3g7mS",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1TZve345g=GK",
								},
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["Enabled"] = true,
						}, -- [4]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [5]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [6]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [7]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [8]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [9]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [10]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [11]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [12]
						{
							["Type"] = "reactive",
							["Enabled"] = true,
							["Name"] = "Revenge",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZG=mGUq7AKQ",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
								}, -- [4]
							},
							["RangeCheck"] = true,
						}, -- [13]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [14]
						{
							["Type"] = "item",
							["Enabled"] = true,
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 35,
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1Z9jhZwz5hvH",
							["CustomTex"] = "28491",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["OnlyInBags"] = true,
						}, -- [15]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [16]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [17]
						{
							["Type"] = "item",
							["Enabled"] = true,
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 50,
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1X=ERE5iZ8VU",
							["CustomTex"] = "5720",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["OnlyInBags"] = true,
						}, -- [18]
						{
							["OnlyEquipped"] = true,
							["Type"] = "item",
							["OnlyInBags"] = true,
							["Name"] = "Battlemaster's Resolve",
							["GUID"] = "TMW:icon:1ZPI5_kvU7St",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 55,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [19]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Type"] = "buff",
							["Enabled"] = true,
							["Name"] = "Poison",
							["GUID"] = "TMW:icon:1ZGQG2qG9S8B",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1YXC4srUja8k",
									["Texts"] = {
										"", -- [1]
										"[Stacks:Hide(0)]", -- [2]
									},
								},
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [20]
					},
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Point"] = {
						["y"] = -24.39078281325337,
						["x"] = -225.6130916101359,
					},
					["Scale"] = 1.5,
					["TextureName"] = "Details Flat",
					["Columns"] = 1,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZGQG2qG9S8B", -- [1]
								"TMW:icon:1Z7R_6NwuWuK", -- [2]
								"TMW:icon:1TWYSTcSCl0z", -- [3]
								"TMW:icon:1TZvNvgAkfmq", -- [4]
								"TMW:icon:1Xx3hMFQR0cV", -- [5]
							},
							["Enabled"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TWYSTcSCl0z", -- [1]
							},
							["Enabled"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [2]
					},
					["Name"] = "OTHER PORTRAIT",
				}, -- [3]
				{
					["Point"] = {
						["y"] = -88,
						["x"] = -5.450076092640056e-05,
					},
					["Scale"] = 1.5,
					["TextureName"] = "Details Flat",
					["Locked"] = true,
					["OnlyInCombat"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1X=ERE5iZ8VU", -- [1]
								"TMW:icon:1Z9jhZwz5hvH", -- [2]
								"TMW:icon:1Z679nrqAgG4", -- [3]
								"TMW:icon:1Z7R_6NwuWuK", -- [4]
								"TMW:icon:1YO55KEUKaW4", -- [5]
								"TMW:icon:1YP2Xjgjriiu", -- [6]
								"TMW:icon:1TYYu4EDbfSz", -- [7]
								"TMW:icon:1TQv_LtTwAae", -- [8]
								"TMW:icon:1TU=hLnlwyeY", -- [9]
								"TMW:icon:1TZvNvflXM0_", -- [10]
								"TMW:icon:1ZQcfScLCzCQ", -- [11]
								"TMW:icon:1TWYMfcUzmi6", -- [12]
								"TMW:icon:1Z9CIRRFbqSA", -- [13]
								"TMW:icon:1YWHZ7T27TKe", -- [14]
								"TMW:icon:1TQv_Ltf40Wl", -- [15]
								"TMW:icon:1Z7PEaK_TNq3", -- [16]
								"TMW:icon:1Xrn34GriOqy", -- [17]
								"TMW:icon:1TWZdpV26rm5", -- [18]
								"TMW:icon:1Z55tRwA_pKn", -- [19]
								"TMW:icon:1YEqZQbYmmFD", -- [20]
								"TMW:icon:1XzwOSGxkHLD", -- [21]
								"TMW:icon:1Xwc=6KNp27d", -- [22]
								"TMW:icon:1Z55tRw3mJGc", -- [23]
							},
							["Enabled"] = true,
							["Name"] = "Rend",
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
									["Type"] = "BUFFDUR",
									["Unit"] = "target",
									["Name"] = "Divine Shield",
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Unit"] = "target",
									["Name"] = "Arcane Bubble",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["Unit"] = "target",
									["Name"] = "Ice Block",
								}, -- [7]
								{
									["Type"] = "LUA",
									["Name"] = "return not UnitInVehicle(\"player\")",
								}, -- [8]
								["n"] = 8,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0)]",
									},
								},
							},
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
						{
							["Sort"] = -1,
							["Type"] = "buff",
							["Enabled"] = true,
							["Name"] = "Battle Shout",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 10,
								}, -- [1]
								["n"] = 1,
							},
							["DurationMinEnabled"] = true,
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
								[100] = {
									["Alpha"] = 1,
								},
							},
							["DurationMin"] = 15,
						}, -- [2]
					},
					["SortPriorities"] = {
						{
							["Order"] = -1,
						}, -- [1]
					},
					["LayoutDirection"] = 2,
					["Name"] = "ROTATION CENTER",
					["SettingsPerView"] = {
						["icon"] = {
							["BorderInset"] = false,
							["BorderColor"] = "00000000",
						},
					},
					["Conditions"] = {
						{
							["Type"] = "MOUNTED",
							["Level"] = 1,
						}, -- [1]
						["n"] = 1,
					},
					["GUID"] = "TMW:group:1TQuFk14Ix42",
				}, -- [4]
				{
					["Point"] = {
						["y"] = -0.00042724609375,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Scale"] = 0.4,
					["TextureName"] = "Details Flat",
					["Locked"] = true,
					["OnlyInCombat"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1X=ERE5iZ8VU", -- [1]
								"TMW:icon:1Z9jhZwz5hvH", -- [2]
								"TMW:icon:1Z679nrqAgG4", -- [3]
								"TMW:icon:1Z7R_6NwuWuK", -- [4]
								"TMW:icon:1YO55KEUKaW4", -- [5]
								"TMW:icon:1YP2Xjgjriiu", -- [6]
								"TMW:icon:1TYYu4EDbfSz", -- [7]
								"TMW:icon:1TQv_LtTwAae", -- [8]
								"TMW:icon:1TU=hLnlwyeY", -- [9]
								"TMW:icon:1TZvNvflXM0_", -- [10]
								"TMW:icon:1ZQcfScLCzCQ", -- [11]
								"TMW:icon:1TWYMfcUzmi6", -- [12]
								"TMW:icon:1Z9CIRRFbqSA", -- [13]
								"TMW:icon:1YWHZ7T27TKe", -- [14]
								"TMW:icon:1TQv_Ltf40Wl", -- [15]
								"TMW:icon:1Z7PEaK_TNq3", -- [16]
								"TMW:icon:1Xrn34GriOqy", -- [17]
								"TMW:icon:1TWZdpV26rm5", -- [18]
								"TMW:icon:1Z55tRwA_pKn", -- [19]
								"TMW:icon:1YEqZQbYmmFD", -- [20]
								"TMW:icon:1XzwOSGxkHLD", -- [21]
								"TMW:icon:1Xwc=6KNp27d", -- [22]
								"TMW:icon:1Z55tRw3mJGc", -- [23]
								"TMW:icon:1ZG=mGUq7AKQ", -- [24]
							},
							["Enabled"] = true,
							["Name"] = "Rend",
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
									["Type"] = "BUFFDUR",
									["Unit"] = "target",
									["Name"] = "Divine Shield",
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Unit"] = "target",
									["Name"] = "Arcane Bubble",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["Unit"] = "target",
									["Name"] = "Ice Block",
								}, -- [7]
								{
									["Type"] = "LUA",
									["Name"] = "return not UnitInVehicle(\"player\")",
								}, -- [8]
								["n"] = 8,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0)]",
									},
								},
							},
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
						{
							["Sort"] = -1,
							["Type"] = "buff",
							["Enabled"] = true,
							["Name"] = "Battle Shout",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 10,
								}, -- [1]
								["n"] = 1,
							},
							["DurationMinEnabled"] = true,
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
								[100] = {
									["Alpha"] = 1,
								},
							},
							["DurationMin"] = 15,
						}, -- [2]
					},
					["SortPriorities"] = {
						{
							["Order"] = -1,
						}, -- [1]
					},
					["LayoutDirection"] = 2,
					["Name"] = "ROTATION TOPLEFT",
					["SettingsPerView"] = {
						["icon"] = {
							["BorderInset"] = false,
						},
					},
					["GUID"] = "TMW:group:1YWsxTHpfSuR",
				}, -- [5]
				{
					["Point"] = {
						["x"] = 30,
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
								"TMW:icon:1ZPI5_kvU7St", -- [1]
								"TMW:icon:1TQv_Lti1RyX", -- [2]
								"TMW:icon:1Y2=7t59vfSn", -- [3]
								"TMW:icon:1Z7PEaKwPKnX", -- [4]
								"TMW:icon:1Z55tRw68qC=", -- [5]
								"TMW:icon:1ZGdp_HEzv8p", -- [6]
							},
							["Enabled"] = true,
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
									["Type"] = "BUFFDUR",
									["Unit"] = "target",
									["Name"] = "Divine Shield",
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Unit"] = "target",
									["Name"] = "Arcane Bubble",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["Unit"] = "target",
									["Name"] = "Ice Block",
								}, -- [7]
								{
									["Type"] = "LUA",
									["Name"] = "return not UnitInVehicle(\"player\")",
								}, -- [8]
								["n"] = 8,
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
					},
					["Name"] = "ROTATION QUEUE",
					["GUID"] = "TMW:group:1ZHnkWuhaAG=",
				}, -- [6]
				{
					["GUID"] = "TMW:group:1ZM=EKbLryuK",
					["Scale"] = 0.4,
					["Locked"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
					},
					["Name"] = "DEBUG",
					["Point"] = {
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
					},
				}, -- [7]
			},
			["Locked"] = true,
		},
		["ROGUE"] = {
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
									["Type"] = "COMBO",
									["Level"] = 4,
									["Operator"] = "<",
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
							["GUID"] = "TMW:icon:1ZTh8w04p6iT",
							["Type"] = "cooldown",
							["Name"] = "Pick Pocket",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
							["States"] = {
								[3] = {
									["Alpha"] = 0,
								},
							},
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
					["Scale"] = 1.5,
					["Point"] = {
						["y"] = -20.00000522536274,
						["x"] = -229.9999934656047,
					},
					["Name"] = "Other",
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
								"TMW:icon:1ZBi1G1LSN04", -- [1]
								"TMW:icon:1ZBi1G1Ik=8q", -- [2]
								"TMW:icon:1TeVAjjavXC6", -- [3]
								"TMW:icon:1TeVAjjXQ0WB", -- [4]
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
								"TMW:icon:1ZBi1G1LSN04", -- [1]
								"TMW:icon:1ZBi1G1Ik=8q", -- [2]
								"TMW:icon:1TeVAjjavXC6", -- [3]
								"TMW:icon:1TeVAjjXQ0WB", -- [4]
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
				{
					["GUID"] = "TMW:group:1ZThAKUg1Y0w",
					["Columns"] = 1,
					["Point"] = {
						["y"] = -9.187387125994171e-05,
						["x"] = 30,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Scale"] = 0.4,
					["Name"] = "Rotation OFFGCD",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZTh8w04p6iT", -- [1]
							},
						}, -- [1]
					},
					["Locked"] = true,
				}, -- [5]
			},
		},
		["MAGE"] = {
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TQvxnAfbGyU",
					["Name"] = "Spells",
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TQv_LtTwAae",
							["OnlyMine"] = true,
							["ShowTimerText"] = true,
							["Enabled"] = true,
							["Name"] = "Dampen Magic",
							["Type"] = "buff",
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1TQv_Ltf40Wl",
							["Type"] = "buff",
							["Name"] = "Mana Shield",
							["Enabled"] = true,
							["ShowTimerText"] = true,
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
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
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
							["Unit"] = "target",
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
					["Locked"] = true,
					["Columns"] = 20,
					["Alpha"] = 0,
					["Scale"] = 1,
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
							["Name"] = "Renew",
							["Enabled"] = true,
							["ShowTimerText"] = true,
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
					["Point"] = {
						["y"] = -40,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Name"] = "BuffTrack",
					["Point"] = {
						["y"] = -29.2003912925716,
						["x"] = -209.401206970214,
					},
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
			["Version"] = 92500,
			["NumGroups"] = 3,
			["TextureName"] = "Glamour2",
		},
		["PRIEST"] = {
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TQvxnAfbGyU",
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Scale"] = 1,
					["Rows"] = 2,
					["Alpha"] = 0,
					["Name"] = "SPELLS",
					["Locked"] = true,
					["Columns"] = 20,
					["Icons"] = {
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [2]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [3]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [4]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [5]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [6]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [7]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [8]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [9]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [10]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [11]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [12]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [13]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [14]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [15]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [16]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [17]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [18]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [19]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [20]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [21]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [22]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [23]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [24]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [25]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [26]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [27]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [28]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [29]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [30]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [31]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [32]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [33]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [34]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [35]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [36]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [37]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [38]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [39]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [40]
					},
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYSTcQ410f",
					["Point"] = {
						["y"] = -65,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Scale"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Weakened Soul",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1YXC4srUja8k",
								},
							},
							["BuffOrDebuff"] = "HARMFUL",
							["GUID"] = "TMW:icon:1ZSIuL1IDfKc",
							["CustomTex"] = "6788",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [2]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [3]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [4]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [5]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [6]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [7]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [8]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [9]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [10]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [11]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [12]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [13]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [14]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [15]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [16]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [17]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [18]
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905",
							["OnlyInBags"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 40,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "28491",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [19]
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["OnlyInBags"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 65,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "5720",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [20]
					},
					["TextureName"] = "Details Flat",
					["Name"] = "GENERAL",
					["Locked"] = true,
					["Columns"] = 20,
					["Alpha"] = 0,
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Columns"] = 1,
					["Point"] = {
						["y"] = -24.39078281325337,
						["x"] = -225.6130916101359,
					},
					["Scale"] = 1.5,
					["Name"] = "OTHER PORTRAIT",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZSIuL1IDfKc", -- [1]
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TWYSTcSCl0z", -- [1]
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
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
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Sort"] = -1,
							["Name"] = "Battle Shout",
							["DurationMin"] = 15,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
								}, -- [1]
								["n"] = 1,
							},
							["DurationMinEnabled"] = true,
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
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
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Sort"] = -1,
							["Name"] = "Battle Shout",
							["DurationMin"] = 15,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
								}, -- [1]
								["n"] = 1,
							},
							["DurationMinEnabled"] = true,
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
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
						["x"] = 30,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Name"] = "ROTATION QUEUE",
					["Scale"] = 0.4,
					["Locked"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
					},
					["OnlyInCombat"] = true,
				}, -- [6]
				{
					["GUID"] = "TMW:group:1ZM=EKbLryuK",
					["Columns"] = 1,
					["Locked"] = true,
					["Scale"] = 0.4,
					["Name"] = "DEBUG",
					["Icons"] = {
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
					},
					["Point"] = {
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
					},
				}, -- [7]
			},
			["Locked"] = true,
			["Version"] = 100500,
			["NumGroups"] = 7,
			["TextureName"] = "Glamour2",
		},
		["WARLOCK"] = {
			["Locked"] = true,
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
					["Point"] = {
						["y"] = -40,
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
					["Locked"] = true,
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
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
									["Unit"] = "target",
									["Level"] = 30,
									["Type"] = "LIBRANGECHECK",
									["Operator"] = "<=",
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
									["Unit"] = "target",
									["Level"] = 30,
									["Type"] = "LIBRANGECHECK",
									["Operator"] = "<=",
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
									["Unit"] = "target",
									["Level"] = 30,
									["Type"] = "LIBRANGECHECK",
									["Operator"] = "<=",
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
					["Scale"] = 1,
					["Columns"] = 20,
					["Alpha"] = 0,
					["Name"] = "Warlock Spells",
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
			["NumGroups"] = 5,
			["Version"] = 91200,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blood Tap",
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
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
							["OnlyMine"] = true,
							["Name"] = "Icebound Fortitude",
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 50,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Horn of Winter",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Horn of Winter",
									["Type"] = "BUFFDUR",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1V6lsULwY3_Y",
							["States"] = {
								{
								}, -- [1]
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
							["Enabled"] = true,
							["Type"] = "reactive",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Rune Strike",
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1V6noP8ARoel",
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
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
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
									["Level"] = 1,
									["Type"] = "REACT",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1ZGiKdRg6oif",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [5]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [6]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [7]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [8]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [9]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [10]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [11]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [12]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [13]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [14]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [15]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [16]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [17]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [18]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [19]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [20]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Plague Strike",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Blood Plague",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1YYs1I2bCNGy",
							["States"] = {
								{
								}, -- [1]
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
						}, -- [21]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Icy Touch",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Frost Fever",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "ISPLAYER",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1YYs1I2c_Meo",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [22]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Heart Strike",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Frost Fever",
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Blood Plague",
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1YYv3MYeNeSM",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [23]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Death Coil",
							["ManaCheck"] = true,
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
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [24]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Death Strike",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Frost Fever",
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Blood Plague",
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1YaXVCdLMBa8",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [25]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blood Strike",
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1YbFYj2F1X0v",
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [26]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Rune Tap",
							["ManaCheck"] = true,
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
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [27]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blood Boil",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "if xAOE(10) > 4 then\n    return true\nelse\n    return false\nend",
									["Operator"] = "~=",
								}, -- [1]
								{
									["BitFlags"] = 2552,
									["Type"] = "INSTANCE2",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1Z3Dak8Afvm1",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [28]
						{
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
									["Name"] = "Frost Fever",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Blood Plague",
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Frost Fever",
									["PrtsBefore"] = 1,
									["Level"] = 5,
									["Unit"] = "target",
									["Operator"] = "<=",
								}, -- [4]
								{
									["AndOr"] = "OR",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Blood Plague",
									["Unit"] = "target",
									["Level"] = 5,
									["PrtsAfter"] = 2,
									["Operator"] = "<=",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1Z4FFfpv6jKF",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [29]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Chains of Ice",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Chains of Ice",
									["Unit"] = "target",
								}, -- [1]
								{
									["Unit"] = "target",
									["Type"] = "ISPLAYER",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1ZMyzzwKlj0c",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [30]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [31]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [32]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [33]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [34]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [35]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [36]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [37]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [38]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [39]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [40]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [41]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [42]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [43]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [44]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [45]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [46]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [47]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [48]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [49]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [50]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [51]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [52]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [53]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [54]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [55]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [56]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [57]
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "Battlemaster's Resolve",
							["GUID"] = "TMW:icon:1ZNzu1N3nE0K",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 55,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["OnlyEquipped"] = true,
							["OnlyInBags"] = true,
						}, -- [58]
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["OnlyInBags"] = true,
							["GUID"] = "TMW:icon:1ZGiKdd7WnyK",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 65,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "5720",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [59]
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905",
							["OnlyInBags"] = true,
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
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [60]
					},
					["Name"] = "DK Spells",
					["Locked"] = true,
					["Alpha"] = 0,
					["Columns"] = 20,
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
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
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
					["Scale"] = 1.5,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
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
							["Icons"] = {
								"TMW:icon:1ZGiKdd7WnyK", -- [1]
								"TMW:icon:1ZGiKddAIuOA", -- [2]
								"TMW:icon:1TeVAjjavXC6", -- [3]
								"TMW:icon:1V6lsULwY3_Y", -- [4]
								"TMW:icon:1ZMyzzwKlj0c", -- [5]
								"TMW:icon:1YYs1I2c_Meo", -- [6]
								"TMW:icon:1Z4FFfpv6jKF", -- [7]
								"TMW:icon:1YYs1I2bCNGy", -- [8]
								"TMW:icon:1YZamy7DqjiW", -- [9]
								"TMW:icon:1YaXVCdLMBa8", -- [10]
								"TMW:icon:1YYv3MYeNeSM", -- [11]
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
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
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [2]
					},
					["Name"] = "Rotation CENTER",
					["Locked"] = true,
					["Conditions"] = {
						{
							["Level"] = 1,
							["Type"] = "MOUNTED",
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
							["Icons"] = {
								"TMW:icon:1ZGiKdd7WnyK", -- [1]
								"TMW:icon:1ZGiKddAIuOA", -- [2]
								"TMW:icon:1TeVAjjavXC6", -- [3]
								"TMW:icon:1V6lsULwY3_Y", -- [4]
								"TMW:icon:1Z4FFfpv6jKF", -- [5]
								"TMW:icon:1ZMyzzwKlj0c", -- [6]
								"TMW:icon:1YYs1I2c_Meo", -- [7]
								"TMW:icon:1YYs1I2bCNGy", -- [8]
								"TMW:icon:1YZamy7DqjiW", -- [9]
								"TMW:icon:1YaXVCdLMBa8", -- [10]
								"TMW:icon:1YYv3MYeNeSM", -- [11]
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["Type"] = "meta",
						}, -- [2]
					},
					["Name"] = "Rotation TOPLEFT",
					["Locked"] = true,
					["Conditions"] = {
						{
							["Level"] = 1,
							["Type"] = "MOUNTED",
						}, -- [1]
						["n"] = 1,
					},
					["Columns"] = 1,
					["OnlyInCombat"] = true,
				}, -- [4]
				{
					["GUID"] = "TMW:group:1ZI3EjwMFimH",
					["Name"] = "ROTATION QUEUE",
					["Point"] = {
						["x"] = 30,
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
							["Conditions"] = {
								{
									["Name"] = "return not IsAltKeyDown()",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [2]
								{
									["Unit"] = "target",
									["Type"] = "ALIVE",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Level"] = 1,
									["Type"] = "MOUNTED",
								}, -- [5]
								["n"] = 5,
							},
							["Icons"] = {
								"TMW:icon:1ZNzu1N3nE0K", -- [1]
								"TMW:icon:1V6noP8ARoel", -- [2]
								"TMW:icon:1TeVAjjXQ0WB", -- [3]
								"TMW:icon:1YbGRIr4FVqp", -- [4]
								"TMW:icon:1ZGiKdRg6oif", -- [5]
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
					},
					["OnlyInCombat"] = true,
				}, -- [5]
			},
			["Version"] = 100500,
			["NumGroups"] = 5,
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
		["DRUID"] = {
			["Locked"] = true,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Maul",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 2,
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
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
								}, -- [5]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Maul",
									["Level"] = 1,
								}, -- [6]
								["n"] = 6,
							},
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["States"] = {
								{
								}, -- [1]
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
									["Unit"] = "target",
									["Level"] = 8,
									["Type"] = "LIBRANGECHECK",
									["Operator"] = "<=",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["States"] = {
								{
								}, -- [1]
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Swipe (Bear)",
							["GUID"] = "TMW:icon:1V6lsULwY3_Y",
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
								{
								}, -- [1]
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
								{
								}, -- [1]
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
							["Name"] = "Mangle (Cat)",
							["ManaCheck"] = true,
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
									["Unit"] = "target",
									["Level"] = 10,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
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
									["Operator"] = "<=",
									["Level"] = 10,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [5]
								{
									["PrtsBefore"] = 1,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Trauma",
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Trauma",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["Level"] = 5,
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
								}, -- [7]
								["n"] = 7,
							},
							["GUID"] = "TMW:icon:1Z69muUIlNiY",
							["States"] = {
								{
								}, -- [1]
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Survival Instincts",
							["GUID"] = "TMW:icon:1Z69muUKqqKC",
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
								{
								}, -- [1]
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mangle (Bear)",
							["ManaCheck"] = true,
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
									["Operator"] = "<=",
									["Level"] = 10,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
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
									["Operator"] = "<=",
									["Level"] = 10,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Trauma",
									["PrtsBefore"] = 1,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["AndOr"] = "OR",
									["Name"] = "Berserk",
									["Operator"] = "~=",
								}, -- [7]
								{
									["Type"] = "RAGE",
									["AndOr"] = "OR",
									["Level"] = 70,
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
								}, -- [8]
								["n"] = 8,
							},
							["GUID"] = "TMW:icon:1Z6o5cxM6Qma",
							["States"] = {
								{
								}, -- [1]
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Berserk",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "return IsShiftKeyDown();",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Name"] = "Tiger's Fury",
									["Type"] = "BUFFDUR",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1ZM_VlmD27Ka",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [8]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [9]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [10]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [11]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [12]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [13]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [14]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [15]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [16]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [17]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [18]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [19]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [20]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Claw",
							["GUID"] = "TMW:icon:1YYs1I2bCNGy",
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
									["Name"] = "-- not behind target\nlocal red, green, blue, alpha = RotationFrame4:GetBackdropColor()\n\nif xRound(red,2) == 1 and xRound(green,2) == 1 and xRound(blue,2) == 1 then\n    return true\nend",
									["Type"] = "LUA",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["PrtsBefore"] = 1,
									["Operator"] = "~=",
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Operator"] = "~=",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [5]
								["n"] = 5,
							},
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
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
						}, -- [21]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Lacerate",
							["GUID"] = "TMW:icon:1ZJNiKMfEYOM",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Bear Form; Dire Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Operator"] = "<",
									["PrtsBefore"] = 1,
									["Level"] = 5,
									["Name"] = "Lacerate",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "RAGE",
									["AndOr"] = "OR",
									["Level"] = 70,
									["Operator"] = ">=",
								}, -- [3]
								{
									["Unit"] = "target",
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Lacerate",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 1,
									["Operator"] = ">",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Lacerate",
									["Level"] = 5,
									["PrtsAfter"] = 2,
									["Operator"] = "<=",
								}, -- [5]
								{
									["Name"] = "if xAOE(10) > 1 then\n    return false\nelse\n    return true\nend",
									["Type"] = "LUA",
								}, -- [6]
								["n"] = 6,
							},
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [22]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shred",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Name"] = "-- behind target\nlocal red, green, blue, alpha = RotationFrame4:GetBackdropColor()\nif xRound(red,2) == 0 and xRound(green,2) == 0 and xRound(blue,2) == 1 then\n    return true\nend",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["PrtsBefore"] = 1,
									["Operator"] = "~=",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Operator"] = "~=",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
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
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [23]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Rake",
							["GUID"] = "TMW:icon:1YZamy7DqjiW",
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
									["Operator"] = "~=",
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Operator"] = "~=",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "HEALTH_ABS",
									["Operator"] = ">=",
									["Unit"] = "target",
								}, -- [6]
								["n"] = 6,
							},
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [24]
						{
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
									["Operator"] = ">",
									["Level"] = 10000,
									["Type"] = "HEALTH_ABS",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["PrtsBefore"] = 1,
									["Operator"] = "~=",
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["AndOr"] = "OR",
									["Operator"] = "~=",
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Trauma",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [6]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Rip",
									["Unit"] = "target",
								}, -- [7]
								["n"] = 7,
							},
							["GUID"] = "TMW:icon:1YaXVCdLMBa8",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [25]
						{
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
									["Level"] = 10000,
									["Operator"] = "<=",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Name"] = "Rip",
									["Operator"] = "~=",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Rip",
									["Level"] = 10,
									["PrtsAfter"] = 2,
									["Operator"] = ">=",
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
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [26]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Nature's Grasp",
							["ManaCheck"] = true,
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
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [27]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Pounce",
							["ManaCheck"] = true,
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
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [28]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Tiger's Fury",
							["GUID"] = "TMW:icon:1Z4qW_DgW_ek",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Rake",
									["Operator"] = "~=",
								}, -- [2]
								{
									["Name"] = "Berserk",
									["Type"] = "BUFFDUR",
								}, -- [3]
								["n"] = 3,
							},
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [29]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [30]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [31]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [32]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [33]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [34]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [35]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [36]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [37]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [38]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [39]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [40]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Mark of the Wild",
							["Conditions"] = {
								{
									["Name"] = "None",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1YXd9eWHzTSH",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [41]
						{
							["Enabled"] = true,
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
							["GUID"] = "TMW:icon:1YXd9eWMwI0j",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [42]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Faerie Fire (Feral)",
							["ManaCheck"] = true,
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
									["Unit"] = "target",
									["Level"] = 5,
									["Type"] = "LIBRANGECHECK",
									["Operator"] = "<=",
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
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [43]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Cower",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Operator"] = ">=",
									["Level"] = 85,
									["Type"] = "THREATSCALED",
									["Unit"] = "target",
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
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [44]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [45]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [46]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [47]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [48]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [49]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [50]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [51]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [52]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [53]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [54]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [55]
						{
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
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [56]
						{
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
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [57]
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
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
						}, -- [58]
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
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
						}, -- [59]
						{
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
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [60]
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
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [2]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [3]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [4]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [5]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [6]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [7]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [8]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [9]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [10]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [11]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [12]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [13]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [14]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [15]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [16]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [17]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [18]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [19]
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [20]
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
							["Icons"] = {
								"TMW:icon:1ZM_VlmD27Ka", -- [1]
								"TMW:icon:1ZB9ydEakN46", -- [2]
								"TMW:icon:1ZBi1G1Ik=8q", -- [3]
								"TMW:icon:1ZBi1G1LSN04", -- [4]
								"TMW:icon:1V6noP8ARoel", -- [5]
								"TMW:icon:1Z69muUKqqKC", -- [6]
								"TMW:icon:1YatF3BT0RKW", -- [7]
								"TMW:icon:1TeVAjjavXC6", -- [8]
								"TMW:icon:1YbFYj2F1X0v", -- [9]
								"TMW:icon:1YaXVCdLMBa8", -- [10]
								"TMW:icon:1Z6o5cxM6Qma", -- [11]
								"TMW:icon:1Z69muUIlNiY", -- [12]
								"TMW:icon:1ZJNiKMfEYOM", -- [13]
								"TMW:icon:1Z4qW_DgW_ek", -- [14]
								"TMW:icon:1YZamy7DqjiW", -- [15]
								"TMW:icon:1V6lsULwY3_Y", -- [16]
								"TMW:icon:1YYs1I2bCNGy", -- [17]
								"TMW:icon:1YYv3MYeNeSM", -- [18]
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
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
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
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
							["Icons"] = {
								"TMW:icon:1ZM_VlmD27Ka", -- [1]
								"TMW:icon:1ZB9ydEakN46", -- [2]
								"TMW:icon:1ZBi1G1Ik=8q", -- [3]
								"TMW:icon:1ZBi1G1LSN04", -- [4]
								"TMW:icon:1V6noP8ARoel", -- [5]
								"TMW:icon:1Z69muUKqqKC", -- [6]
								"TMW:icon:1YatF3BT0RKW", -- [7]
								"TMW:icon:1TeVAjjavXC6", -- [8]
								"TMW:icon:1YbFYj2F1X0v", -- [9]
								"TMW:icon:1YaXVCdLMBa8", -- [10]
								"TMW:icon:1Z6o5cxM6Qma", -- [11]
								"TMW:icon:1Z69muUIlNiY", -- [12]
								"TMW:icon:1ZJNiKMfEYOM", -- [13]
								"TMW:icon:1Z4qW_DgW_ek", -- [14]
								"TMW:icon:1YZamy7DqjiW", -- [15]
								"TMW:icon:1V6lsULwY3_Y", -- [16]
								"TMW:icon:1YYs1I2bCNGy", -- [17]
								"TMW:icon:1YYv3MYeNeSM", -- [18]
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
						{
							["Type"] = "meta",
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
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
						["x"] = 30,
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
							["Icons"] = {
								"TMW:icon:1TeVAjjXQ0WB", -- [1]
								"TMW:icon:1ZJOZ6wmptif", -- [2]
							},
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
					},
					["OnlyInCombat"] = true,
				}, -- [5]
				{
					["Icons"] = {
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
					},
				}, -- [6]
				{
					["Icons"] = {
						{
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [1]
					},
				}, -- [7]
			},
			["NumGroups"] = 5,
			["Version"] = 100500,
		},
		["PALADIN"] = {
			["Locked"] = true,
			["NumGroups"] = 4,
			["Version"] = 92500,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Scale"] = 1,
					["Rows"] = 3,
					["Alpha"] = 0,
					["Name"] = "Paladin Spells",
					["Locked"] = true,
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Icons"] = {
						[46] = {
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Lay on Hands",
							["ManaCheck"] = true,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Divine Protection",
							["ManaCheck"] = true,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Seal of Command",
							["ManaCheck"] = true,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blessing of Might",
							["ManaCheck"] = true,
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
							["GUID"] = "TMW:icon:1YatF3BT0RKW",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Consecration",
							["ManaCheck"] = true,
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
							["GUID"] = "TMW:icon:1Z6uOhVZgoW8",
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
						[42] = {
							["GUID"] = "TMW:icon:1YXd9eWMwI0j",
							["Type"] = "cooldown",
							["Name"] = "Judgement of Wisdom",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Wisdom",
									["Operator"] = "<=",
									["Level"] = 2,
									["AndOr"] = "OR",
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
							["GUID"] = "TMW:icon:1YawP4LcafCX",
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
		},
		["Handrmandr - Golemagg"] = {
			["Version"] = 100500,
		},
	},
}
