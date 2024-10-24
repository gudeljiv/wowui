
TellMeWhenDB = {
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
	["Version"] = 101600,
	["profileKeys"] = {
		["Mxzq - Golemagg"] = "HUNTER",
		["Vermina - Golemagg"] = "PALADIN",
		["Mxyz - Golemagg"] = "PRIEST",
		["Dopesick - Stitches"] = "WARRIOR",
		["Battlearm - Golemagg"] = "DEATHKNIGHT",
		["Handrmandr - Golemagg"] = "WARRIOR",
		["Battitude - Golemagg"] = "ROGUE",
		["Dopede - Stitches"] = "SHAMAN",
		["Battledog - Gehennas"] = "WARRIOR",
		["Kaonac - Jin'do"] = "PRIEST",
		["Wells - Jin'do"] = "DRUID",
		["Dopecure - Stitches"] = "PRIEST",
		["Moolatz - Golemagg"] = "DRUID",
		["Tandaram - Jin'do"] = "WARRIOR",
		["Provokator - Jin'do"] = "HUNTER",
		["Poklopac - Dreadnaught"] = "HUNTER",
		["Dopesnare - Stitches"] = "HUNTER",
		["Tudum - Ashbringer"] = "WARRIOR",
		["Tudum - Jin'do"] = "WARRIOR",
		["Battlearm - Gehennas"] = "WARRIOR",
		["Augustin - Golemagg"] = "MAGE",
		["Pitchwise - Ashbringer"] = "SHAMAN",
		["Mxyzptlk - Golemagg"] = "WARLOCK",
		["Vermin - Golemagg"] = "WARRIOR",
		["Lonac - Stitches"] = "WARRIOR",
		["Poklopac - Mirage Raceway"] = "HUNTER",
		["Miqa - Golemagg"] = "PRIEST",
		["Dopeah - Stitches"] = "SHAMAN",
		["Dopeclaw - Stitches"] = "DRUID",
		["Tadibey - Golemagg"] = "SHAMAN",
		["Moolatz - Dreadnaught"] = "DRUID",
	},
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
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Serpent Sting",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Serpent Sting",
									["Level"] = 1,
								}, -- [1]
								{
									["Level"] = 1,
									["Type"] = "CREATURETYPE",
									["Name"] = "Elemental",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["PrtsBefore"] = 1,
									["Name"] = "Serpent Sting",
									["Unit"] = "target",
								}, -- [3]
								{
									["Unit"] = "target",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Serpent Sting",
									["AndOr"] = "OR",
									["Level"] = 0.2,
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
								}, -- [4]
								{
									["Name"] = "Viper Sting",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "Misdirection",
								}, -- [6]
								{
									["Type"] = "CASTING",
									["Name"] = "Mend Pet",
									["Level"] = 2,
								}, -- [7]
								{
									["Name"] = "xTTD == -1 or xTTD > 12",
									["Type"] = "LUA",
								}, -- [8]
								["n"] = 8,
							},
							["ManaCheck"] = true,
							["States"] = {
								{
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
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
							["Name"] = "Arcane Shot",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Level"] = 50,
									["Type"] = "MANA",
									["Name"] = "Explosive Shot",
									["Operator"] = ">=",
								}, -- [1]
								{
									["Type"] = "CASTING",
									["Name"] = "Mend Pet",
									["Level"] = 2,
								}, -- [2]
								["n"] = 2,
							},
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
						}, -- [2]
						{
							["GUID"] = "TMW:icon:1YS2u64Alj4P",
							["Type"] = "cooldown",
							["Name"] = "Multi-Shot",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEED",
								}, -- [1]
								{
									["Name"] = "xBehindTarget()",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Type"] = "MANA",
									["Level"] = 50,
									["Operator"] = ">=",
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
							["Type"] = "cooldown",
							["Name"] = "Explosive Trap",
							["Conditions"] = {
								{
									["Name"] = "Explosive Trap",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
								}, -- [1]
								{
									["Name"] = "xInRange(0,\"target\",\"min\") -- and xBehindTarget()",
									["Type"] = "LUA",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1ZlhdlmrsoGF",
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
						}, -- [19]
						{
							["GUID"] = "TMW:icon:1X=OmHlbqz67",
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
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Operator"] = "<=",
									["Level"] = 60,
									["Type"] = "HEALTH",
									["Unit"] = "pet",
								}, -- [1]
								{
									["Name"] = "Mend Pet",
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Unit"] = "pet",
								}, -- [2]
								{
									["Unit"] = "pet",
									["Type"] = "EXISTS",
								}, -- [3]
								{
									["Unit"] = "pet",
									["Type"] = "ALIVE",
								}, -- [4]
								{
									["Type"] = "SPEED",
								}, -- [5]
								["n"] = 5,
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
						}, -- [20]
						{
							["ManaCheck"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "EITHER",
							["Unit"] = "target",
							["Name"] = "Enraged",
							["GUID"] = "TMW:icon:1ZuahEVFckqw",
							["Enabled"] = true,
							["RangeCheck"] = true,
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Aimed Shot",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "PTSINTAL",
									["Name"] = "Chimera Shot",
									["AndOr"] = "OR",
								}, -- [1]
								{
									["Type"] = "PTSINTAL",
									["Name"] = "Chimera Shot",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Operator"] = ">",
								}, -- [2]
								{
									["Name"] = "Chimera Shot",
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 2,
									["Operator"] = "~=",
								}, -- [3]
								{
									["Level"] = 1,
									["Type"] = "SPELLCD",
									["Name"] = "Aimed Shot",
									["Operator"] = "<=",
								}, -- [4]
								{
									["Name"] = "not xBehindTarget()",
									["Type"] = "LUA",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1ZDQ16jnm6W=",
							["States"] = {
								{
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [22]
						{
							["GUID"] = "TMW:icon:1ZDRwPNU7Z0Z",
							["Type"] = "cooldown",
							["Name"] = "Concussive Shot",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Level"] = 99,
									["Type"] = "THREATSCALED",
									["Operator"] = ">=",
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Deterrence",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 20,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "CASTING",
									["Name"] = "Mend Pet",
									["Level"] = 2,
								}, -- [2]
								["n"] = 2,
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
							["GUID"] = "TMW:icon:1ZEKCuryiveD",
							["Type"] = "cooldown",
							["Name"] = "Wing Clip",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Wing Clip",
									["Unit"] = "target",
								}, -- [1]
								{
									["Name"] = "xInRange(5,\"target\",\"max\")",
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
						}, -- [39]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Raptor Strike",
							["GUID"] = "TMW:icon:1ayCWLUPE1CN",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Level"] = 1,
									["Type"] = "CURRENTSPELL",
									["Name"] = "Raptor Strike",
									["Unit"] = "target",
								}, -- [1]
								{
									["Name"] = "xInRange(5,\"target\",\"max\")",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Type"] = "MANA",
									["Level"] = 50,
									["Operator"] = ">=",
								}, -- [3]
								["n"] = 3,
							},
							["Enabled"] = true,
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
						}, -- [40]
						{
							["GUID"] = "TMW:icon:1a_1UgKk_YW1",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
							["CLEUEvents"] = {
								[""] = true,
							},
							["BarDisplay_BarGCD"] = true,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "xThreat() > 80",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
							["Name"] = "Feign Death",
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
							["GUID"] = "TMW:icon:1b7_I0LR89Wq",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
							["CLEUEvents"] = {
								[""] = true,
							},
							["BarDisplay_BarGCD"] = true,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "xThreat() > 60 and xInRange(5,\"target\",\"max\")",
									["Type"] = "LUA",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "GROUP2",
									["Checked"] = true,
									["BitFlags"] = 1,
								}, -- [2]
								{
									["PrtsBefore"] = 1,
									["Type"] = "GROUP2",
									["AndOr"] = "OR",
									["BitFlags"] = 1,
								}, -- [3]
								{
									["Type"] = "EXISTS",
									["PrtsAfter"] = 2,
									["Unit"] = "pet",
								}, -- [4]
								["n"] = 4,
							},
							["Name"] = "Disengage",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Auto Shot",
							["GUID"] = "TMW:icon:1b0R_gF9ykyh",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEED",
								}, -- [1]
								{
									["Name"] = "-- select min range, 2 is max range\n-- select(1, xGetRange(\"target\")) >= 8\nInCombatLockdown() and not IsCurrentSpell(75)",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Type"] = "CASTING",
									["Name"] = "Mend Pet",
									["Level"] = 2,
								}, -- [3]
								["n"] = 3,
							},
							["CustomTex"] = "6660",
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
							["GUID"] = "TMW:icon:1b9KipSFhwqo",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["Name"] = "Frenzy Effect",
							["Enabled"] = true,
							["Unit"] = "pet",
						}, -- [57]
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
									["Unit"] = "pet",
									["Type"] = "EXISTS",
								}, -- [2]
								{
									["Unit"] = "pet",
									["Type"] = "ALIVE",
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
						}, -- [59]
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
							["CustomTex"] = "29203",
							["OnlyInBags"] = true,
						}, -- [60]
					},
					["Columns"] = 20,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["OnlyInCombat"] = true,
					["Name"] = "OTHER",
					["Point"] = {
						["y"] = -34.58063797670778,
						["x"] = -246.7119056651909,
					},
					["Scale"] = 1.4,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1a_1UgKk_YW1", -- [1]
								"TMW:icon:1b7_I0LR89Wq", -- [2]
								"TMW:icon:1b9KipSFhwqo", -- [3]
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
					["TextureName"] = "Details Flat",
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TeVDtajUwqa",
					["Name"] = "ROTATION CENTER",
					["Point"] = {
						["y"] = -130,
						["x"] = -5.450076092640056e-05,
					},
					["Locked"] = true,
					["Scale"] = 1.5,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Conditions"] = {
								{
									["Level"] = 1,
									["Type"] = "MOUNTED",
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
									["Name"] = "Feign Death",
									["Type"] = "BUFFDUR",
								}, -- [5]
								{
									["Name"] = "not IsAltKeyDown() and not UnitInVehicle(\"player\")",
									["Type"] = "LUA",
								}, -- [6]
								{
									["Name"] = "Food",
									["Type"] = "BUFFDUR",
								}, -- [7]
								{
									["Name"] = "Drink",
									["Type"] = "BUFFDUR",
								}, -- [8]
								["n"] = 8,
							},
							["Icons"] = {
								"TMW:icon:1ZFP_8OauieW", -- [1]
								"TMW:icon:1ZFP_8OYz7Gr", -- [2]
								"TMW:icon:1b0R_gF9ykyh", -- [3]
								"TMW:icon:1b7_I0LR89Wq", -- [4]
								"TMW:icon:1ZDRwPNU7Z0Z", -- [5]
								"TMW:icon:1X=OmHlbqz67", -- [6]
								"TMW:icon:1ZEKCuryiveD", -- [7]
								"TMW:icon:1ayCWLUPE1CN", -- [8]
								"TMW:icon:1ZuahEVFckqw", -- [9]
								"TMW:icon:1TeVAjjXQ0WB", -- [10]
								"TMW:icon:1ZDQ16jnm6W=", -- [11]
								"TMW:icon:1YS2u64Alj4P", -- [12]
								"TMW:icon:1V6lsULwY3_Y", -- [13]
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
					["Name"] = "ROTATION TOPLEFT",
					["Point"] = {
						["y"] = -0.00067138671875,
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
									["Level"] = 1,
									["Type"] = "MOUNTED",
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
									["Name"] = "Feign Death",
									["Type"] = "BUFFDUR",
								}, -- [5]
								{
									["Name"] = "not IsAltKeyDown() and not UnitInVehicle(\"player\")",
									["Type"] = "LUA",
								}, -- [6]
								{
									["Name"] = "Food",
									["Type"] = "BUFFDUR",
								}, -- [7]
								{
									["Name"] = "Drink",
									["Type"] = "BUFFDUR",
								}, -- [8]
								["n"] = 8,
							},
							["Icons"] = {
								"TMW:icon:1ZFP_8OauieW", -- [1]
								"TMW:icon:1ZFP_8OYz7Gr", -- [2]
								"TMW:icon:1b0R_gF9ykyh", -- [3]
								"TMW:icon:1b7_I0LR89Wq", -- [4]
								"TMW:icon:1ZDRwPNU7Z0Z", -- [5]
								"TMW:icon:1X=OmHlbqz67", -- [6]
								"TMW:icon:1ZEKCuryiveD", -- [7]
								"TMW:icon:1ayCWLUPE1CN", -- [8]
								"TMW:icon:1ZuahEVFckqw", -- [9]
								"TMW:icon:1TeVAjjXQ0WB", -- [10]
								"TMW:icon:1ZDQ16jnm6W=", -- [11]
								"TMW:icon:1YS2u64Alj4P", -- [12]
								"TMW:icon:1V6lsULwY3_Y", -- [13]
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
					["Name"] = "OFFGCD",
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
							["Icons"] = {
								"TMW:icon:1a_1UgKk_YW1", -- [1]
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
			["Version"] = 101600,
			["NumGroups"] = 5,
			["TextureName"] = "xVerminClean",
		},
		["WARRIOR"] = {
			["Version"] = 101600,
			["Locked"] = true,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TQvxnAfbGyU",
					["Columns"] = 20,
					["Scale"] = 1,
					["Rows"] = 3,
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TQv_Lti1RyX",
							["Type"] = "reactive",
							["Name"] = "Heroic Strike",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Heroic Strike",
									["Level"] = 1,
								}, -- [1]
								{
									["Name"] = "xAOE(8) == 1",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 65,
									["Operator"] = ">=",
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
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1Y2=7t59vfSn",
							["Type"] = "reactive",
							["Name"] = "Cleave",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Cleave",
									["Level"] = 1,
								}, -- [1]
								{
									["Name"] = "xAOE(8) > 1",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 25,
									["Operator"] = ">=",
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
						}, -- [2]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Battle Shout",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
								},
							},
							["GUID"] = "TMW:icon:1TQv_Ltf40Wl",
							["Conditions"] = {
								{
									["Name"] = "Battle Shout",
									["Type"] = "BUFFDUR",
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
									["Name"] = "Blessing of Might",
									["Type"] = "BUFFDUR",
								}, -- [4]
								["n"] = 4,
							},
							["Enabled"] = true,
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
						}, -- [3]
						{
							["GUID"] = "TMW:icon:1TWZdpV26rm5",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Demoralizing Shout",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "Defensive Stance; Berserker Stance; Battle Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Demoralizing Shout",
									["Unit"] = "target",
								}, -- [2]
								{
									["Name"] = "xInRange(2) and xTTD > 6 and xAOE(8) > 1",
									["Type"] = "LUA",
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
						}, -- [4]
						{
							["GUID"] = "TMW:icon:1TU=hLnlwyeY",
							["Type"] = "cooldown",
							["Name"] = "Overpower",
							["ShowTimerText"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "REACTIVE",
									["Checked"] = true,
									["Name"] = "Overpower",
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["GUID"] = "TMW:icon:1TYYu4EDbfSz",
							["Enabled"] = true,
							["Name"] = "Sunder Armor",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks:Hide(0)]", -- [2]
									},
								},
							},
							["RangeCheck"] = true,
							["HideIfNoUnits"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFSTACKS",
									["Name"] = "Sunder Armor",
									["PrtsBefore"] = 1,
									["Level"] = 5,
									["Operator"] = "<=",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sunder Armor",
									["AndOr"] = "OR",
									["Unit"] = "target",
									["Level"] = 3.8,
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
								}, -- [2]
								{
									["Type"] = "LEVEL",
									["PrtsBefore"] = 1,
									["Level"] = 1,
									["Operator"] = ">",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "LEVEL",
									["AndOr"] = "OR",
									["Level"] = -1,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Expose Armor",
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "LUA",
									["Name"] = "xTTD > 10",
									["Level"] = 60,
									["Operator"] = ">",
									["Unit"] = "target",
								}, -- [6]
								["n"] = 6,
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
						}, -- [6]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Whirlwind",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "Berserker Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Name"] = "xInRange(2)",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Level"] = 1.5,
									["Type"] = "SPELLCD",
									["Name"] = "Whirlwind",
									["Operator"] = "<=",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1Xwc=6KNp27d",
							["States"] = {
								{
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 1,
								}, -- [4]
							},
						}, -- [7]
						{
							["Enabled"] = true,
							["Type"] = "reactive",
							["Name"] = "Execute",
							["RangeCheck"] = true,
							["IgnoreNomana"] = true,
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
						}, -- [8]
						{
							["GUID"] = "TMW:icon:1XzwOSGxkHLD",
							["Type"] = "cooldown",
							["Name"] = "Mortal Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "LUA",
									["Name"] = "xAOE(5) == 1",
								}, -- [1]
								{
									["AndOr"] = "OR",
									["Type"] = "STANCE",
									["PrtsAfter"] = 1,
									["Name"] = "Battle Stance; Berserker Stance",
								}, -- [2]
								{
									["Level"] = 1,
									["Type"] = "SPEC",
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
						}, -- [9]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Slam",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["AndOr"] = "OR",
									["Name"] = "Slam!",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Type"] = "SPEC",
									["Name"] = "DPS",
									["Level"] = 2,
								}, -- [2]
								{
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">",
									["Unit"] = "target",
								}, -- [3]
								["n"] = 3,
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
							["Name"] = "Sweeping Strikes",
							["Conditions"] = {
								{
									["Name"] = "Battle Stance; Berserker Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Name"] = "xAOE(10) > 1",
									["Type"] = "LUA",
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
							["GUID"] = "TMW:icon:1YWHZ7T27TKe",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Thunder Clap",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "STANCE",
									["Name"] = "Battle Stance",
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
									["Name"] = "xAOE(10) > 2",
									["Type"] = "LUA",
								}, -- [4]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "xInRange(5)",
								}, -- [5]
								{
									["PrtsBefore"] = 1,
									["Type"] = "LUA",
									["Name"] = "xAOE(10) > 3",
									["AndOr"] = "OR",
								}, -- [6]
								{
									["Type"] = "STANCE",
									["PrtsAfter"] = 1,
									["Name"] = "Battle Stance",
								}, -- [7]
								["n"] = 7,
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
						}, -- [19]
						{
							["GUID"] = "TMW:icon:1TWYMfcUzmi6",
							["Type"] = "cooldown",
							["Name"] = "Hamstring",
							["Enabled"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Conditions"] = {
								{
									["Type"] = "ISPLAYER",
									["Level"] = 1,
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
								["n"] = 3,
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
						}, -- [20]
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
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [22]
						{
							["GUID"] = "TMW:icon:1Z55tRw8OaCM",
							["Type"] = "cooldown",
							["Name"] = "Shield Block",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Name"] = "IsEquippedItemType(\"Shields\")",
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
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [23]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shield Slam",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "IsEquippedItemType(\"Shields\")",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
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
						}, -- [24]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Concussion Blow",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 5,
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
								}, -- [1]
								{
									["Name"] = "Shield Bash",
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [2]
								{
									["PrtsBefore"] = 1,
									["Type"] = "STANCE",
									["Name"] = "Berserker Stance",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Name"] = "Pummel",
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [4]
								{
									["PrtsBefore"] = 1,
									["Type"] = "STANCE",
									["Name"] = "Battle Stance",
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Name"] = "IsEquippedItemType(\"Shields\")",
									["Type"] = "LUA",
								}, -- [6]
								{
									["Name"] = "Shield Bash",
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 2,
									["Operator"] = "~=",
								}, -- [7]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "xUnitCasting(\"target\")",
								}, -- [8]
								{
									["PrtsBefore"] = 1,
									["Type"] = "ISPLAYER",
									["AndOr"] = "OR",
									["Unit"] = "target",
								}, -- [9]
								{
									["Level"] = 1,
									["Type"] = "REACT",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [10]
								{
									["Type"] = "BUFFDUR",
									["PrtsAfter"] = 1,
									["Name"] = "Spell Reflection",
								}, -- [11]
								{
									["AndOr"] = "OR",
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "xUnitCastingNonInteruptable(\"target\")",
								}, -- [12]
								{
									["Level"] = 1,
									["Type"] = "SPEC",
								}, -- [13]
								["n"] = 13,
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
						}, -- [25]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shield Wall",
							["Enabled"] = true,
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
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Bloodthirst",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Level"] = 1,
									["Type"] = "SPELLCD",
									["Name"] = "Bloodthirst",
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1YEqZQbYmmFD",
							["States"] = {
								{
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Disarm",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "PVPFLAG",
								}, -- [1]
								{
									["Type"] = "CLASS2",
									["BitFlags"] = 43,
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "STANCE",
									["PrtsAfter"] = 1,
									["Name"] = "Defensive Stance",
								}, -- [3]
								{
									["AndOr"] = "OR",
									["Type"] = "NAME",
									["Name"] = "Lord Crispin Ference",
									["Unit"] = "target",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1Z9CIRRFbqSA",
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
						}, -- [31]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Recklessness",
							["Conditions"] = {
								{
									["Name"] = "Berserker Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "BUFFDUR",
									["Name"] = "Bloodlust",
									["Operator"] = "~=",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sated",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [3]
								{
									["Type"] = "LEVEL",
									["Level"] = -1,
									["Unit"] = "target",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1ZYr3kQJ=Fa1",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [32]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Death Wish",
							["Conditions"] = {
								{
									["Name"] = "Berserker Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "BUFFDUR",
									["Name"] = "Bloodlust",
									["Operator"] = "~=",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sated",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [3]
								{
									["Type"] = "LEVEL",
									["Level"] = -1,
									["Unit"] = "target",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1ZYr3kQXDQKM",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blood Fury",
							["Conditions"] = {
								{
									["Level"] = 2,
									["Type"] = "SPEC",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "BUFFDUR",
									["Name"] = "Bloodlust",
									["Operator"] = "~=",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sated",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1ZYr3kQhGs06",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Bloodrage",
							["Conditions"] = {
								{
									["Type"] = "RAGE",
									["Level"] = 70,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "select(2,UnitPowerType(\"target\")) ~= \"MANA\"",
									["Level"] = 10,
									["Unit"] = "target",
									["Operator"] = ">",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1ZsiQTrMcI1p",
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
							["ManaCheck"] = true,
							["Type"] = "buff",
							["Name"] = "Feared; Sap; Incapacitated; Bellowing Roar; Frightening Shout",
							["GUID"] = "TMW:icon:1Z7R_6NwuWuK",
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
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
							["GUID"] = "TMW:icon:1TQv_LtTwAae",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Rend",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["AndOr"] = "OR",
									["Name"] = "Rend",
									["Unit"] = "target",
								}, -- [1]
								{
									["Name"] = "Defensive Stance; Battle Stance",
									["Type"] = "STANCE",
								}, -- [2]
								{
									["Type"] = "LUA",
									["Name"] = "xTTD > 20",
									["Level"] = 150,
									["Operator"] = ">",
									["Unit"] = "target",
								}, -- [3]
								["n"] = 3,
							},
							["ManaCheck"] = true,
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
						}, -- [61]
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
						}, -- [62]
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
						}, -- [63]
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
						}, -- [64]
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
						}, -- [65]
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
						}, -- [66]
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
						}, -- [67]
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
						}, -- [68]
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
						}, -- [69]
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
						}, -- [70]
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
						}, -- [71]
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
						}, -- [72]
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
						}, -- [73]
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
						}, -- [74]
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
						}, -- [75]
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
						}, -- [76]
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
						}, -- [77]
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
						}, -- [78]
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
						}, -- [79]
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
						}, -- [80]
					},
					["Name"] = "SPELLS",
					["Locked"] = true,
					["Alpha"] = 0,
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["OnlyInCombat"] = true,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYSTcQ410f",
					["Columns"] = 20,
					["Scale"] = 1,
					["Alpha"] = 0,
					["TextureName"] = "Details Flat",
					["Name"] = "GENERAL",
					["Locked"] = true,
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TWYSTcSCl0z",
							["Type"] = "buff",
							["Name"] = "Blood Fury",
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
							["ShowTimerText"] = true,
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
							["GUID"] = "TMW:icon:1TZvNvgAkfmq",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1TZve345g=GK",
								},
							},
							["Enabled"] = true,
							["Name"] = "Enrage",
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
							["GUID"] = "TMW:icon:1Xx3hMFQR0cV",
							["Type"] = "buff",
							["Name"] = "Recently Bandaged",
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
							["ShowTimerText"] = true,
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
							["GUID"] = "TMW:icon:1ZmKyPVeTnOI",
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
									["Level"] = 30,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "29203",
							["OnlyInBags"] = true,
						}, -- [19]
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["GUID"] = "TMW:icon:1X=ERE5iZ8VU",
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
									["Level"] = 50,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "5720",
							["OnlyInBags"] = true,
						}, -- [20]
					},
					["Point"] = {
						["y"] = -95,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["OnlyInCombat"] = true,
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Point"] = {
						["y"] = -74,
						["x"] = -290,
					},
					["Scale"] = 1.2,
					["Alpha"] = 0,
					["TextureName"] = "Details Flat",
					["Name"] = "OTHER PORTRAIT",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TZvNvgAkfmq", -- [1]
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
					["Columns"] = 1,
					["OnlyInCombat"] = true,
				}, -- [3]
				{
					["GUID"] = "TMW:group:1TQuFk14Ix42",
					["Point"] = {
						["y"] = -95,
						["x"] = -5.450076092640056e-05,
					},
					["Scale"] = 1.5,
					["Alpha"] = 0,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["BuffOrDebuff"] = "HARMFUL",
							["Icons"] = {
								"TMW:icon:1X=ERE5iZ8VU", -- [1]
								"TMW:icon:1ZmKyPVeTnOI", -- [2]
								"TMW:icon:1Z7R_6NwuWuK", -- [3]
								"TMW:icon:1TU=hLnlwyeY", -- [4]
								"TMW:icon:1TWYMfcUzmi6", -- [5]
								"TMW:icon:1TQv_Ltf40Wl", -- [6]
								"TMW:icon:1TWZdpV26rm5", -- [7]
								"TMW:icon:1TQv_LtTwAae", -- [8]
								"TMW:icon:1YO55KEUKaW4", -- [9]
								"TMW:icon:1TYYu4EDbfSz", -- [10]
								"TMW:icon:1Z55tRwA_pKn", -- [11]
								"TMW:icon:1Xwc=6KNp27d", -- [12]
								"TMW:icon:1YEqZQbYmmFD", -- [13]
								"TMW:icon:1YWHZ7T27TKe", -- [14]
								"TMW:icon:1Xrn34GriOqy", -- [15]
								"TMW:icon:1XzwOSGxkHLD", -- [16]
								"TMW:icon:1TZvNvflXM0_", -- [17]
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
									["Level"] = 1,
									["Type"] = "MOUNTED",
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
								["n"] = 4,
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
							["Enabled"] = true,
							["Type"] = "buff",
							["Sort"] = -1,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
								}, -- [1]
								["n"] = 1,
							},
							["Name"] = "Battle Shout",
							["DurationMin"] = 15,
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
							["BorderColor"] = "00000000",
							["BorderInset"] = false,
						},
					},
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
								"TMW:icon:1ZmKyPVeTnOI", -- [2]
								"TMW:icon:1Z7R_6NwuWuK", -- [3]
								"TMW:icon:1TU=hLnlwyeY", -- [4]
								"TMW:icon:1TWYMfcUzmi6", -- [5]
								"TMW:icon:1TQv_Ltf40Wl", -- [6]
								"TMW:icon:1TWZdpV26rm5", -- [7]
								"TMW:icon:1TQv_LtTwAae", -- [8]
								"TMW:icon:1YO55KEUKaW4", -- [9]
								"TMW:icon:1TYYu4EDbfSz", -- [10]
								"TMW:icon:1Z55tRwA_pKn", -- [11]
								"TMW:icon:1Xwc=6KNp27d", -- [12]
								"TMW:icon:1YEqZQbYmmFD", -- [13]
								"TMW:icon:1YWHZ7T27TKe", -- [14]
								"TMW:icon:1Xrn34GriOqy", -- [15]
								"TMW:icon:1XzwOSGxkHLD", -- [16]
								"TMW:icon:1TZvNvflXM0_", -- [17]
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
									["Level"] = 1,
									["Type"] = "MOUNTED",
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
								["n"] = 4,
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
							["Enabled"] = true,
							["Type"] = "buff",
							["Sort"] = -1,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
								}, -- [1]
								["n"] = 1,
							},
							["Name"] = "Battle Shout",
							["DurationMin"] = 15,
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
									["Level"] = 1,
									["Type"] = "MOUNTED",
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
								["n"] = 4,
							},
							["Icons"] = {
								"TMW:icon:1TQv_Lti1RyX", -- [1]
								"TMW:icon:1Y2=7t59vfSn", -- [2]
								"TMW:icon:1ZYr3kQhGs06", -- [3]
								"TMW:icon:1Z7PEaKwPKnX", -- [4]
								"TMW:icon:1Z55tRw68qC=", -- [5]
								"TMW:icon:1ZsiQTrMcI1p", -- [6]
								"TMW:icon:1Z55tRw8OaCM", -- [7]
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
				}, -- [6]
				{
					["GUID"] = "TMW:group:1ZM=EKbLryuK",
					["Columns"] = 1,
					["Point"] = {
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
					},
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
					["Locked"] = true,
				}, -- [7]
			},
			["NumGroups"] = 7,
			["TextureName"] = "xVerminClean",
		},
		["PALADIN"] = {
			["Locked"] = true,
			["Version"] = 100900,
			["NumGroups"] = 5,
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
							["Name"] = "Righteous Fury",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "Righteous Fury",
								}, -- [1]
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1ZmhO7mqKue=",
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
							["Type"] = "cooldown",
							["Name"] = "Beacon of Light",
							["GUID"] = "TMW:icon:1Ztb9RIdmLi9",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEC",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "focus",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Beacon of Light",
									["Unit"] = "focus",
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
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Holy Light",
							["Conditions"] = {
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "mouseover",
								}, -- [2]
								{
									["Operator"] = "<",
									["Level"] = 90,
									["Type"] = "HEALTH",
									["Unit"] = "mouseover",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 2,
									["Unit"] = "mouseover",
								}, -- [4]
								{
									["Type"] = "SPEED",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1Z_AGSGa0teP",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Divine Plea",
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Level"] = 60,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Divine Shield",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 30,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Name"] = "Forbearance",
									["Type"] = "DEBUFFDUR",
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
						}, -- [21]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Hammer of the Righteous",
							["GUID"] = "TMW:icon:1ZkmyyWS_emA",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEC",
									["Level"] = 2,
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
						}, -- [22]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shield of Righteousness",
							["GUID"] = "TMW:icon:1ZkmyyWUmDSs",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEC",
									["Level"] = 2,
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
						}, -- [23]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Avenger's Shield",
							["GUID"] = "TMW:icon:1ZkmyyWWPpGC",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "mouseover",
								}, -- [2]
								{
									["Name"] = "xInRange(30,\"mouseover\")",
									["Type"] = "LUA",
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
						}, -- [24]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Holy Wrath",
							["GUID"] = "TMW:icon:1ZkmyyWX_u4d",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [1]
								{
									["Type"] = "MANA",
									["Level"] = 45,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Name"] = "xInRange(2)",
									["Type"] = "LUA",
								}, -- [3]
								{
									["Type"] = "CREATURETYPE",
									["Name"] = "Demon; Undead",
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
						}, -- [25]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Hammer of Wrath",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [1]
								{
									["Operator"] = "<=",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "MANA",
									["Level"] = 15,
									["Operator"] = ">=",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1ZkmyyWZapS_",
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
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "mouseover",
							["Name"] = "Poison; Disease; Magic",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["GUID"] = "TMW:icon:1ZwdlWxY789W",
							["Conditions"] = {
								{
									["Type"] = "REACT",
									["Level"] = 2,
									["Unit"] = "mouseover",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "4987",
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
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Holy Shield",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [1]
								{
									["Name"] = "Holy Shield",
									["Type"] = "BUFFDUR",
								}, -- [2]
								{
									["Type"] = "MANA",
									["Level"] = 15,
									["Operator"] = ">=",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1YXd9eWHzTSH",
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
						}, -- [41]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Judgement of Wisdom",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1YXd9eWMwI0j",
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
						}, -- [42]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Divine Storm",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Wisdom",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [2]
								["n"] = 2,
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
							["Name"] = "Crusader Strike",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Wisdom",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [2]
								["n"] = 2,
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
							["GUID"] = "TMW:icon:1Z6tL7hXaSCZ",
							["Type"] = "cooldown",
							["Name"] = "Exorcism",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEC",
									["Level"] = 2,
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
						}, -- [45]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Lay on Hands",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 15,
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
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [46]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["ManaCheck"] = true,
							["Name"] = "Poison; Disease; Magic",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1Z6tL7hbgPqi",
							["Conditions"] = {
								{
									["Name"] = "xBehindTarget()",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "4987",
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
						}, -- [47]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Divine Protection",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 55,
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
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [48]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Consecration",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "xAOE(10) > 0 and xInRange(2)",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [2]
								{
									["Type"] = "MANA",
									["Level"] = 15,
									["Operator"] = ">=",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1Z6tL7hfkyqu",
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
						}, -- [49]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Seal of Command",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Level"] = 5,
									["Name"] = "Seal of Command",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [2]
								{
									["Name"] = "xAOE(10) > 1",
									["Type"] = "LUA",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1Z6uOhVXfBCq",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [50]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Seal of Righteousness",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Level"] = 5,
									["Name"] = "Seal of Righteousness",
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZknB6Qckg8U",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [51]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Seal of Vengeance",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Level"] = 5,
									["Name"] = "Seal of Vengeance",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [2]
								{
									["PrtsBefore"] = 1,
									["Type"] = "LEVEL",
									["Level"] = -1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "LEVEL",
									["AndOr"] = "OR",
									["Level"] = 83,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1ZkmyynlJgaL",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
									["Alpha"] = 0,
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
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["OnlyInBags"] = true,
							["GUID"] = "TMW:icon:1ZmhsoGZsuaJ",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 50,
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
							["GUID"] = "TMW:icon:1ZmhsoDa4SWt",
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
						}, -- [60]
					},
					["Name"] = "PALADIN SPELLS",
					["Locked"] = true,
					["Columns"] = 20,
					["Alpha"] = 0,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Name"] = "OTHER",
					["Point"] = {
						["y"] = -20.00000522536274,
						["x"] = -229.9999934656047,
					},
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
					},
					["Scale"] = 1.5,
					["Columns"] = 1,
					["Alpha"] = 0,
					["TextureName"] = "Details Flat",
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TeVDtajUwqa",
					["Point"] = {
						["y"] = -140,
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
								["n"] = 6,
							},
							["Icons"] = {
								"TMW:icon:1ZmhsoGZsuaJ", -- [1]
								"TMW:icon:1ZmhsoDa4SWt", -- [2]
								"TMW:icon:1ZmhO7mqKue=", -- [3]
								"TMW:icon:1Z6tL7hZeq4n", -- [4]
								"TMW:icon:1Z_AGSGa0teP", -- [5]
								"TMW:icon:1ZwdlWxY789W", -- [6]
								"TMW:icon:1Z6tL7hbgPqi", -- [7]
								"TMW:icon:1ZkmyyWWPpGC", -- [8]
								"TMW:icon:1ZkmyyWZapS_", -- [9]
								"TMW:icon:1YXd9eWMwI0j", -- [10]
								"TMW:icon:1Z6tL7hfkyqu", -- [11]
								"TMW:icon:1ZkmyyWX_u4d", -- [12]
								"TMW:icon:1YXd9eWHzTSH", -- [13]
								"TMW:icon:1ZkmyyWS_emA", -- [14]
								"TMW:icon:1ZkmyyWUmDSs", -- [15]
								"TMW:icon:1Ztb9RIdmLi9", -- [16]
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
					["Point"] = {
						["y"] = 6.103515625e-05,
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
									["PrtsBefore"] = 1,
									["Type"] = "LUA",
									["Name"] = "return not IsAltKeyDown();",
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
									["PrtsAfter"] = 1,
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "SPEC",
									["Level"] = 1,
									["AndOr"] = "OR",
								}, -- [6]
								["n"] = 6,
							},
							["Icons"] = {
								"TMW:icon:1ZmhsoGZsuaJ", -- [1]
								"TMW:icon:1ZmhsoDa4SWt", -- [2]
								"TMW:icon:1ZmhO7mqKue=", -- [3]
								"TMW:icon:1Z6tL7hZeq4n", -- [4]
								"TMW:icon:1Z_AGSGa0teP", -- [5]
								"TMW:icon:1ZwdlWxY789W", -- [6]
								"TMW:icon:1Z6tL7hbgPqi", -- [7]
								"TMW:icon:1ZkmyyWWPpGC", -- [8]
								"TMW:icon:1ZkmyyWZapS_", -- [9]
								"TMW:icon:1YXd9eWMwI0j", -- [10]
								"TMW:icon:1Z6tL7hfkyqu", -- [11]
								"TMW:icon:1ZkmyyWX_u4d", -- [12]
								"TMW:icon:1YXd9eWHzTSH", -- [13]
								"TMW:icon:1ZkmyyWS_emA", -- [14]
								"TMW:icon:1ZkmyyWUmDSs", -- [15]
								"TMW:icon:1Ztb9RIdmLi9", -- [16]
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
					["OnlyInCombat"] = true,
				}, -- [4]
				{
					["GUID"] = "TMW:group:1Zmhq7u_10aD",
					["Columns"] = 1,
					["Locked"] = true,
					["Scale"] = 0.4,
					["Name"] = "ROTATION QUEUE",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Conditions"] = {
								{
									["Type"] = "COMBAT",
								}, -- [1]
								["n"] = 1,
							},
							["Icons"] = {
								"TMW:icon:1Z6tL7hdj2mo", -- [1]
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
					},
					["Point"] = {
						["y"] = -9.187387125994171e-05,
						["x"] = 30,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
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
		},
		["Dopesick - Stitches"] = {
			["Version"] = 101600,
		},
		["Dopede - Stitches"] = {
			["Version"] = 101600,
		},
		["Dopecure - Stitches"] = {
			["Version"] = 101600,
		},
		["DRUID"] = {
			["Groups"] = {
				{
					["Scale"] = 1,
					["Rows"] = 3,
					["Locked"] = true,
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Alpha"] = 0,
					["Name"] = "Druid Spells",
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Icons"] = {
						{
							["Type"] = "cooldown",
							["Name"] = "Maul",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Bear Form; Dire Bear Form",
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "InCombatLockdown() and not IsCurrentSpell(6603)",
								}, -- [2]
								["n"] = 2,
							},
							["Enabled"] = true,
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
							["GUID"] = "TMW:icon:1b4RXOJ1Gw40",
						}, -- [1]
						{
							["Type"] = "cooldown",
							["Name"] = "Maul",
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["ManaCheck"] = true,
							["Enabled"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Bear Form; Dire Bear Form",
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "xAOE(10) == 1",
									["PrtsBefore"] = 2,
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
									["Level"] = 40,
									["AndOr"] = "OR",
								}, -- [4]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Maul",
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
							},
						}, -- [2]
						{
							["Type"] = "cooldown",
							["Name"] = "Swipe",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1V6lsULwY3_Y",
							["Enabled"] = true,
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
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Bear Form; Dire Bear Form",
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "xAOE(10) > 1",
									["PrtsBefore"] = 1,
								}, -- [2]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Maul",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 2,
									["Operator"] = ">=",
									["Level"] = 30,
								}, -- [4]
								["n"] = 4,
							},
						}, -- [3]
						{
							["OnlyMine"] = true,
							["Type"] = "cooldown",
							["Name"] = "Demoralizing Roar",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Bear Form; Dire Bear Form",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Unit"] = "target",
									["Name"] = "Demoralizing Roar",
								}, -- [2]
								{
									["Type"] = "LUA",
									["Unit"] = "target",
									["Operator"] = "<=",
									["Name"] = "xInRange(8) and xAOE(10) > 1",
									["Level"] = 8,
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
							["RangeCheck"] = true,
							["Enabled"] = true,
						}, -- [4]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Type"] = "cooldown",
							["Name"] = "Barkskin",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Name"] = "Bear Form; Cat Form",
									["Level"] = 60,
								}, -- [1]
								["n"] = 1,
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
							["GUID"] = "TMW:icon:1V6noP8ARoel",
							["Enabled"] = true,
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
							["Type"] = "cooldown",
							["Name"] = "Claw",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1YYs1I2bCNGy",
							["Enabled"] = true,
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
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Operator"] = "<",
									["PrtsBefore"] = 1,
									["Level"] = 5,
								}, -- [2]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "xTTD <= 7",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "LUA",
									["Name"] = "not xBehindTarget()",
								}, -- [4]
								["n"] = 4,
							},
						}, -- [21]
						{
							["Type"] = "cooldown",
							["Name"] = "Rake",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Rake",
								}, -- [2]
								{
									["Type"] = "LUA",
									["Name"] = "xTTD > 3",
								}, -- [3]
								["n"] = 3,
							},
							["Enabled"] = true,
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
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1YZamy7DqjiW",
						}, -- [22]
						{
							["Type"] = "cooldown",
							["Name"] = "Shred",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1YYv3MYeNeSM",
							["Enabled"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "xBehindTarget()",
								}, -- [2]
								{
									["Type"] = "COMBO",
									["Operator"] = "<",
									["Level"] = 5,
								}, -- [3]
								["n"] = 3,
							},
						}, -- [23]
						{
							["Type"] = "cooldown",
							["Name"] = "Rip",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Operator"] = ">=",
									["Level"] = 4,
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Rip",
								}, -- [3]
								{
									["Type"] = "LUA",
									["Operator"] = ">",
									["Unit"] = "target",
									["Name"] = "xTTD > 7",
									["Level"] = 10000,
								}, -- [4]
								["n"] = 4,
							},
							["Enabled"] = true,
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
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1YaXVCdLMBa8",
						}, -- [24]
						{
							["Type"] = "cooldown",
							["Name"] = "Ferocious Bite",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Operator"] = ">=",
									["Level"] = 4,
								}, -- [2]
								["n"] = 2,
							},
							["Enabled"] = true,
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
							["GUID"] = "TMW:icon:1YbFYj2F1X0v",
						}, -- [25]
						{
							["Type"] = "cooldown",
							["Name"] = "Tiger's Fury",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1Z4qW_DgW_ek",
							["Enabled"] = true,
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
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Rake",
								}, -- [2]
								["n"] = 2,
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
							["Type"] = "cooldown",
							["Name"] = "Shred",
							["GUID"] = "TMW:icon:1ZeQiVw1QEaz",
							["ManaCheck"] = true,
							["Enabled"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "xBehindTarget()",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Operator"] = "~=",
									["Name"] = "Clearcasting",
								}, -- [3]
								["n"] = 3,
							},
						}, -- [30]
						{
							["Type"] = "cooldown",
							["Name"] = "Ferocious Bite",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Operator"] = ">",
									["Level"] = 3,
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Operator"] = ">",
									["Name"] = "Rip",
									["Level"] = 16,
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Operator"] = "~=",
									["Name"] = "Savage Roar",
								}, -- [4]
								["n"] = 4,
							},
							["Enabled"] = true,
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
							["GUID"] = "TMW:icon:1ZrL8pFVd_Ki",
						}, -- [31]
						{
							["Type"] = "cooldown",
							["Name"] = "Ferocious Bite",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Operator"] = ">",
									["Level"] = 2,
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Operator"] = ">",
									["Name"] = "Rip",
									["Level"] = 12,
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Operator"] = "~=",
									["Name"] = "Savage Roar",
								}, -- [4]
								["n"] = 4,
							},
							["Enabled"] = true,
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
							["GUID"] = "TMW:icon:1ZrL8pFXlKGx",
						}, -- [32]
						{
							["Type"] = "cooldown",
							["Name"] = "Ferocious Bite",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Operator"] = ">",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Operator"] = ">",
									["Name"] = "Rip",
									["Level"] = 8,
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Operator"] = "~=",
									["Name"] = "Savage Roar",
								}, -- [4]
								["n"] = 4,
							},
							["Enabled"] = true,
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
							["GUID"] = "TMW:icon:1ZrL8pFaHSqU",
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
							["Type"] = "cooldown",
							["Name"] = "Pounce",
							["GUID"] = "TMW:icon:1Z3Dak8Afvm1",
							["ManaCheck"] = true,
							["Enabled"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
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
									["Operator"] = "~=",
									["Name"] = "Prowl",
								}, -- [5]
								["n"] = 5,
							},
						}, -- [39]
						{
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
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
							},
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
							["GUID"] = "TMW:icon:1ZJOZ6wmptif",
							["Enabled"] = true,
						}, -- [40]
						{
							["Type"] = "buff",
							["Name"] = "Mark of the Wild",
							["GUID"] = "TMW:icon:1YXd9eWHzTSH",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "None",
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
						}, -- [41]
						{
							["Type"] = "cooldown",
							["Name"] = "Thorns",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Tree of Life",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "focus",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "focus",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Unit"] = "focus",
									["Level"] = 2,
								}, -- [4]
								{
									["Type"] = "BUFFDUR",
									["Unit"] = "focus",
									["Name"] = "Thorns",
								}, -- [5]
								{
									["Type"] = "LUA",
									["Name"] = "xInRange(30,\"focus\")",
								}, -- [6]
								["n"] = 6,
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
							["GUID"] = "TMW:icon:1YXd9eWMwI0j",
							["Enabled"] = true,
						}, -- [42]
						{
							["Type"] = "cooldown",
							["Name"] = "Faerie Fire (Feral)",
							["GUID"] = "TMW:icon:1YatF3BT0RKW",
							["ManaCheck"] = true,
							["Enabled"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Bear Form; Cat Form; Dire Bear Form",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Unit"] = "target",
									["Name"] = "Faerie Fire (Feral)",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Prowl",
								}, -- [3]
								{
									["Type"] = "LIBRANGECHECK",
									["Unit"] = "target",
									["Operator"] = "<=",
									["Level"] = 5,
								}, -- [4]
								["n"] = 4,
							},
						}, -- [43]
						{
							["Type"] = "cooldown",
							["Name"] = "Cower",
							["GUID"] = "TMW:icon:1YawP4LcafCX",
							["ManaCheck"] = true,
							["Enabled"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
								}, -- [1]
								{
									["Type"] = "THREATSCALED",
									["Operator"] = ">=",
									["Unit"] = "target",
									["Level"] = 85,
								}, -- [2]
								{
									["Type"] = "GROUP2",
									["Checked"] = true,
									["BitFlags"] = 1,
								}, -- [3]
								["n"] = 3,
							},
						}, -- [44]
						{
							["Type"] = "cooldown",
							["Name"] = "Lifebloom",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Tree of Life",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "focus",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "focus",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Unit"] = "focus",
									["Level"] = 2,
								}, -- [4]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Unit"] = "focus",
									["Name"] = "Lifebloom",
								}, -- [5]
								{
									["Type"] = "LUA",
									["Name"] = "xInRange(40,\"focus\")",
								}, -- [6]
								["n"] = 6,
							},
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
							["GUID"] = "TMW:icon:1Zh6oeWTckKb",
							["Enabled"] = true,
						}, -- [45]
						{
							["Type"] = "cooldown",
							["Name"] = "Rejuvenation",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Tree of Life",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "focus",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "focus",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Unit"] = "focus",
									["Level"] = 2,
								}, -- [4]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Unit"] = "focus",
									["Name"] = "Rejuvenation",
								}, -- [5]
								{
									["Type"] = "LUA",
									["Name"] = "xInRange(40,\"focus\")",
								}, -- [6]
								["n"] = 6,
							},
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
							["GUID"] = "TMW:icon:1Zh6oeWXDH04",
							["Enabled"] = true,
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
							["OnlyEquipped"] = true,
							["Type"] = "item",
							["OnlyInBags"] = true,
							["Name"] = "Battlemaster's Resolve",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 60,
								}, -- [1]
								["n"] = 1,
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
							["GUID"] = "TMW:icon:1ZZXHb53AraE",
							["Enabled"] = true,
						}, -- [55]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Type"] = "buff",
							["Name"] = "Curse",
							["GUID"] = "TMW:icon:1ZKevCddhaS_",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1YXC4srUja8k",
									["Texts"] = {
										[2] = "[Stacks:Hide(0)]",
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
							["Enabled"] = true,
						}, -- [56]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Type"] = "buff",
							["Name"] = "Poison",
							["GUID"] = "TMW:icon:1ZKevCdgnbud",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1YXC4srUja8k",
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
						}, -- [57]
						{
							["Type"] = "item",
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 35,
								}, -- [1]
								{
									["Type"] = "STANCE",
									["Name"] = "None",
								}, -- [2]
								["n"] = 2,
							},
							["OnlyInBags"] = true,
							["CustomTex"] = "29203",
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
							["GUID"] = "TMW:icon:1ZBi1G1Ik=8q",
						}, -- [58]
						{
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 60,
								}, -- [1]
								["n"] = 1,
							},
							["OnlyInBags"] = true,
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
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1ZBi1G1LSN04",
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
						}, -- [61]
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
						}, -- [62]
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
						}, -- [63]
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
						}, -- [64]
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
						}, -- [65]
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
						}, -- [66]
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
						}, -- [67]
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
						}, -- [68]
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
						}, -- [69]
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
						}, -- [70]
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
						}, -- [71]
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
						}, -- [72]
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
						}, -- [73]
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
						}, -- [74]
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
						}, -- [75]
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
						}, -- [76]
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
						}, -- [77]
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
						}, -- [78]
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
						}, -- [79]
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
						}, -- [80]
					},
				}, -- [1]
				{
					["Point"] = {
						["y"] = -22.2248075248809,
						["x"] = -241.4639853189352,
					},
					["Scale"] = 1.477512240409851,
					["TextureName"] = "Details Flat",
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Columns"] = 1,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1Z3Dak8Afvm1", -- [1]
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
					["Name"] = "Other",
					["Alpha"] = 0,
				}, -- [2]
				{
					["Point"] = {
						["y"] = -140,
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
								"TMW:icon:1ZBi1G1Ik=8q", -- [1]
								"TMW:icon:1ZBi1G1LSN04", -- [2]
								"TMW:icon:1V6noP8ARoel", -- [3]
								"TMW:icon:1YatF3BT0RKW", -- [4]
								"TMW:icon:1TeVAjjavXC6", -- [5]
								"TMW:icon:1YaXVCdLMBa8", -- [6]
								"TMW:icon:1YZamy7DqjiW", -- [7]
								"TMW:icon:1YYv3MYeNeSM", -- [8]
								"TMW:icon:1YYs1I2bCNGy", -- [9]
							},
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "not IsAltKeyDown();",
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
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "STANCE",
									["Name"] = "Tree of Life",
									["AndOr"] = "OR",
								}, -- [6]
								["n"] = 6,
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
								"TMW:icon:1YXd9eWHzTSH", -- [1]
								"TMW:icon:1YXd9eWMwI0j", -- [2]
								"TMW:icon:1V6noP8ARoel", -- [3]
								"TMW:icon:1V6lsULwY3_Y", -- [4]
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
					["Name"] = "Rotation CENTER",
					["GUID"] = "TMW:group:1TeVDtajUwqa",
				}, -- [3]
				{
					["Scale"] = 0.4,
					["Locked"] = true,
					["OnlyInCombat"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZBi1G1Ik=8q", -- [1]
								"TMW:icon:1ZBi1G1LSN04", -- [2]
								"TMW:icon:1V6noP8ARoel", -- [3]
								"TMW:icon:1YatF3BT0RKW", -- [4]
								"TMW:icon:1TeVAjjavXC6", -- [5]
								"TMW:icon:1YaXVCdLMBa8", -- [6]
								"TMW:icon:1YZamy7DqjiW", -- [7]
								"TMW:icon:1YYv3MYeNeSM", -- [8]
								"TMW:icon:1YYs1I2bCNGy", -- [9]
							},
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "not IsAltKeyDown();",
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
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "STANCE",
									["Name"] = "Tree of Life",
									["AndOr"] = "OR",
								}, -- [6]
								["n"] = 6,
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
					["GUID"] = "TMW:group:1YWtClNC=L8S",
					["Point"] = {
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
				}, -- [4]
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
								"TMW:icon:1b4RXOJ1Gw40", -- [1]
								"TMW:icon:1TeVAjjXQ0WB", -- [2]
								"TMW:icon:1V6lsULwY3_Y", -- [3]
							},
							["Conditions"] = {
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "return not IsAltKeyDown();",
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
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
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
					},
					["Name"] = "ROTATION QUEUE",
					["GUID"] = "TMW:group:1ZI1LEibEVeR",
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
			["Version"] = 101600,
			["Locked"] = true,
		},
		["DEATHKNIGHT"] = {
			["NumGroups"] = 5,
			["Version"] = 101600,
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
							["Conditions"] = {
								{
									["Name"] = "local blood, frost, unholy, death = xRuneCount()\nif blood+death==0 then return true end\nreturn false",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["PrtsBefore"] = 1,
									["Level"] = 3,
									["Name"] = "Frost Fever",
									["Operator"] = "<",
								}, -- [2]
								{
									["Unit"] = "target",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Blood Plague",
									["Level"] = 3,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "<",
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
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["OnlyMine"] = true,
							["Name"] = "Icebound Fortitude",
							["Type"] = "cooldown",
							["Enabled"] = true,
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Horn of Winter",
							["GCDAsUnusable"] = true,
							["GUID"] = "TMW:icon:1V6lsULwY3_Y",
							["Conditions"] = {
								{
									["Name"] = "Horn of Winter",
									["Type"] = "BUFFDUR",
								}, -- [1]
								{
									["Name"] = "Strength of Earth",
									["Type"] = "BUFFDUR",
								}, -- [2]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Obliterate",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 3,
									["Operator"] = ">",
								}, -- [3]
								{
									["Level"] = 50,
									["Type"] = "RUNIC_POWER_ABS",
									["PrtsAfter"] = 1,
									["Operator"] = "<",
								}, -- [4]
								["n"] = 4,
							},
							["Enabled"] = true,
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
							["Type"] = "reactive",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Rune Strike",
							["Enabled"] = true,
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
						}, -- [4]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Anti-Magic Shell",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "xAOE(10,true) > 0 or xUnitCastingNonInteruptable(\"target\")",
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Death and Decay",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "xAOE(10) >= 4",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZXaz0p3YpOm",
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
						}, -- [6]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Unbreakable Armor",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Bloodlust",
									["Operator"] = "~=",
								}, -- [1]
								{
									["AndOr"] = "OR",
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sated",
									["Operator"] = "~=",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1ZYXYoMjwNSI",
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
						}, -- [7]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Empower Rune Weapon",
							["Conditions"] = {
								{
									["BitFlags"] = 62,
									["Type"] = "RUNES2",
								}, -- [1]
								{
									["Type"] = "LEVEL",
									["PrtsBefore"] = 1,
									["Level"] = 82,
									["Unit"] = "target",
									["Operator"] = ">",
								}, -- [2]
								{
									["Type"] = "LEVEL",
									["Level"] = -1,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["PrtsBefore"] = 1,
									["Type"] = "BUFFDUR",
									["Name"] = "Bloodlust",
									["Operator"] = "~=",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sated",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1ZYXYoMn068Y",
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Obliterate",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Level"] = 2,
									["Type"] = "SPEC",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "Blood Plague",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "Frost Fever",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "HEALTH",
									["Level"] = 40,
									["Operator"] = ">",
								}, -- [4]
								{
									["PrtsBefore"] = 1,
									["Type"] = "LUA",
									["Name"] = "local blood, frost, unholy, death = xRuneCount()\n\nif frost>0 and unholy>0 then return true end\nif frost>0 and death>0 and blood+death>1 then return true end\nif unholy>0 and death>0 and blood+death>1 then return true end\n\nreturn false",
								}, -- [5]
								{
									["Operator"] = ">",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["AndOr"] = "OR",
									["PrtsBefore"] = 1,
									["Level"] = 7.5,
									["Name"] = "Frost Fever",
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = ">",
									["Name"] = "Blood Plague",
									["Level"] = 7.5,
									["PrtsAfter"] = 2,
									["Unit"] = "target",
								}, -- [7]
								{
									["Level"] = 1.5,
									["Type"] = "SPELLCD",
									["Name"] = "Obliterate",
									["Operator"] = "<",
								}, -- [8]
								{
									["PrtsBefore"] = 1,
									["Type"] = "LUA",
									["Name"] = "xAOE(10) < 3",
								}, -- [9]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Howling Blast",
									["AndOr"] = "OR",
									["Level"] = 2,
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [10]
								["n"] = 10,
							},
							["GUID"] = "TMW:icon:1ZYXYoMoeHKG",
							["States"] = {
								{
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								{
								}, -- [3]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 1,
								}, -- [4]
							},
						}, -- [9]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Frost Strike",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "LUA",
									["Name"] = "xAOE(10) < 3",
								}, -- [1]
								{
									["Type"] = "RUNIC_POWER_ABS",
									["Level"] = 95,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [2]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Obliterate",
									["PrtsBefore"] = 1,
									["Level"] = 1.5,
									["Operator"] = ">",
								}, -- [3]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Howling Blast",
									["AndOr"] = "OR",
									["Level"] = 1.5,
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1ZYXYoMqCvyD",
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
						}, -- [10]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Howling Blast",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Level"] = 2,
									["Type"] = "SPEC",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "BUFFDUR",
									["Name"] = "Freezing Fog",
									["Operator"] = "~=",
								}, -- [2]
								{
									["PrtsBefore"] = 1,
									["Type"] = "LUA",
									["Name"] = "xAOE(10) >= 3",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "HEALTH",
									["Level"] = 40,
									["Operator"] = ">",
								}, -- [4]
								{
									["Type"] = "LUA",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "local blood, frost, unholy, death = xRuneCount()\n\nif frost>0 and unholy>0 then return true end\nif frost>0 and death>0 and blood+death>1 then return true end\nif unholy>0 and death>0 and blood+death>1 then return true end\n\nreturn false",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [5]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Howling Blast",
									["Level"] = 1.5,
									["PrtsAfter"] = 1,
									["Operator"] = "<",
								}, -- [6]
								["n"] = 6,
							},
							["GUID"] = "TMW:icon:1ZYXYoMroYer",
							["States"] = {
								{
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								{
								}, -- [3]
								{
									["Color"] = "ffffffff",
									["Alpha"] = 1,
								}, -- [4]
							},
						}, -- [11]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Raise Dead",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Bloodlust",
									["Operator"] = "~=",
								}, -- [1]
								{
									["AndOr"] = "OR",
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sated",
									["Operator"] = "~=",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1Zsi3BcdqHDl",
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Plague Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Blood Plague",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Anti-Magic Shield",
									["Unit"] = "target",
								}, -- [2]
								["n"] = 2,
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Icy Touch",
							["Enabled"] = true,
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
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Anti-Magic Shield",
									["Unit"] = "target",
								}, -- [3]
								["n"] = 3,
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Heart Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Frost Fever",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Blood Plague",
									["Operator"] = "~=",
								}, -- [2]
								{
									["Level"] = 1,
									["Type"] = "SPEC",
								}, -- [3]
								{
									["Name"] = "xAOE(5) <= 2",
									["Type"] = "LUA",
								}, -- [4]
								{
									["Type"] = "RUNES2",
									["BitFlags"] = 57,
									["PrtsBefore"] = 1,
									["Level"] = 1,
									["Operator"] = ">",
								}, -- [5]
								{
									["Type"] = "HEALTH",
									["AndOr"] = "OR",
									["Level"] = 75,
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
								}, -- [6]
								["n"] = 6,
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
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [23]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Death Coil",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Level"] = 1,
									["Type"] = "SPEC",
								}, -- [1]
								{
									["Type"] = "DEFAULT_ABS",
									["Level"] = 60,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Rune Strike",
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Death Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["PrtsBefore"] = 1,
									["Unit"] = "target",
									["Name"] = "Frost Fever",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Blood Plague",
									["Operator"] = "~=",
								}, -- [2]
								{
									["Type"] = "SPEC",
									["PrtsAfter"] = 1,
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "HEALTH",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 40,
									["Operator"] = "<=",
								}, -- [4]
								{
									["Type"] = "SPEC",
									["PrtsAfter"] = 1,
									["Level"] = 2,
								}, -- [5]
								["n"] = 5,
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
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [25]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blood Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Level"] = 2,
									["Type"] = "SPEC",
								}, -- [1]
								{
									["Type"] = "RUNES2",
									["BitFlags"] = 1,
									["Operator"] = ">",
								}, -- [2]
								["n"] = 2,
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blood Boil",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "xAOE(10) > 2",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Level"] = 1,
									["Type"] = "SPEC",
								}, -- [2]
								{
									["Type"] = "RUNES2",
									["Name"] = "Death Strike",
									["BitFlags"] = 57,
									["PrtsBefore"] = 1,
									["Level"] = 1,
									["Operator"] = ">",
								}, -- [3]
								{
									["Type"] = "HEALTH",
									["AndOr"] = "OR",
									["Level"] = 75,
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [4]
								["n"] = 4,
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
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<=",
									["PrtsBefore"] = 2,
									["Level"] = 7.5,
									["Name"] = "Frost Fever",
									["Unit"] = "target",
								}, -- [1]
								{
									["Operator"] = "<=",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Blood Plague",
									["AndOr"] = "OR",
									["Level"] = 7.5,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "Frost Fever",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "Blood Plague",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "LUA",
									["Name"] = "xPestilenceAOE()",
									["AndOr"] = "OR",
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Chains of Ice",
							["Enabled"] = true,
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mark of Blood",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 60,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1Za8YRwFhvat",
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
						}, -- [31]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Vampiric Blood",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 40,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Level"] = 1,
									["Type"] = "SPEC",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1ZsFvYGT2kWU",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Pestilence",
							["Conditions"] = {
								{
									["Name"] = "xPestilenceAOE()\n\nor \n\nxPestilenceSS()",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1a2UsJB=W54o",
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Frost Strike",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Level"] = 1,
									["Type"] = "SPELLCD",
									["Name"] = "Obliterate",
									["Operator"] = ">",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "LUA",
									["Name"] = "xAOE(10) >= 3",
									["AndOr"] = "OR",
								}, -- [2]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Howling Blast",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [3]
								{
									["Level"] = 90,
									["Type"] = "RUNIC_POWER_ABS",
									["AndOr"] = "OR",
									["Operator"] = ">",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1a1Aq1Tw_3ih",
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
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["GUID"] = "TMW:icon:1ZNzu1N3nE0K",
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
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
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
							["OnlyInBags"] = true,
						}, -- [59]
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
						}, -- [60]
					},
					["Name"] = "DK Spells",
					["Locked"] = true,
					["Alpha"] = 0,
					["Columns"] = 20,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Point"] = {
						["y"] = -20.00000522536274,
						["x"] = -229.9999934656047,
					},
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
					["Scale"] = 1.5,
					["Columns"] = 1,
					["Alpha"] = 0,
					["TextureName"] = "Details Flat",
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TeVDtajUwqa",
					["Columns"] = 1,
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
									["PrtsBefore"] = 1,
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [4]
								{
									["AndOr"] = "OR",
									["Type"] = "INSTANCE2",
									["PrtsAfter"] = 1,
									["BitFlags"] = 504,
								}, -- [5]
								{
									["Name"] = "return not IsAltKeyDown()",
									["Type"] = "LUA",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Ice Block",
									["Unit"] = "target",
								}, -- [7]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Divine Shield",
									["Unit"] = "target",
								}, -- [8]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Anti-Magic Shell",
									["Unit"] = "target",
								}, -- [9]
								["n"] = 9,
							},
							["Icons"] = {
								"TMW:icon:1ZGiKdd7WnyK", -- [1]
								"TMW:icon:1ZGiKddAIuOA", -- [2]
								"TMW:icon:1Zsi3BcdqHDl", -- [3]
								"TMW:icon:1Z4FFfpv6jKF", -- [4]
								"TMW:icon:1V6lsULwY3_Y", -- [5]
								"TMW:icon:1ZMyzzwKlj0c", -- [6]
								"TMW:icon:1ZYXYoMjwNSI", -- [7]
								"TMW:icon:1YYs1I2bCNGy", -- [8]
								"TMW:icon:1YYs1I2c_Meo", -- [9]
								"TMW:icon:1ZYXYoMroYer", -- [10]
								"TMW:icon:1a1Aq1Tw_3ih", -- [11]
								"TMW:icon:1ZYXYoMoeHKG", -- [12]
								"TMW:icon:1YbFYj2F1X0v", -- [13]
								"TMW:icon:1YZamy7DqjiW", -- [14]
								"TMW:icon:1YaXVCdLMBa8", -- [15]
								"TMW:icon:1YYv3MYeNeSM", -- [16]
								"TMW:icon:1Z3Dak8Afvm1", -- [17]
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
					["Point"] = {
						["y"] = -140,
						["x"] = -5.450076092640056e-05,
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
									["PrtsBefore"] = 1,
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [4]
								{
									["AndOr"] = "OR",
									["Type"] = "INSTANCE2",
									["PrtsAfter"] = 1,
									["BitFlags"] = 504,
								}, -- [5]
								{
									["Name"] = "return not IsAltKeyDown()",
									["Type"] = "LUA",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Divine Shield",
									["Unit"] = "target",
								}, -- [7]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Ice Block",
									["Unit"] = "target",
								}, -- [8]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Anti-Magic Shell",
									["Unit"] = "target",
								}, -- [9]
								["n"] = 9,
							},
							["Icons"] = {
								"TMW:icon:1ZGiKdd7WnyK", -- [1]
								"TMW:icon:1ZGiKddAIuOA", -- [2]
								"TMW:icon:1Zsi3BcdqHDl", -- [3]
								"TMW:icon:1Z4FFfpv6jKF", -- [4]
								"TMW:icon:1V6lsULwY3_Y", -- [5]
								"TMW:icon:1ZMyzzwKlj0c", -- [6]
								"TMW:icon:1ZYXYoMjwNSI", -- [7]
								"TMW:icon:1YYs1I2bCNGy", -- [8]
								"TMW:icon:1YYs1I2c_Meo", -- [9]
								"TMW:icon:1ZYXYoMroYer", -- [10]
								"TMW:icon:1a1Aq1Tw_3ih", -- [11]
								"TMW:icon:1ZYXYoMoeHKG", -- [12]
								"TMW:icon:1YbFYj2F1X0v", -- [13]
								"TMW:icon:1YZamy7DqjiW", -- [14]
								"TMW:icon:1YaXVCdLMBa8", -- [15]
								"TMW:icon:1YYv3MYeNeSM", -- [16]
								"TMW:icon:1Z3Dak8Afvm1", -- [17]
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
									["PrtsBefore"] = 1,
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [5]
								{
									["AndOr"] = "OR",
									["Type"] = "INSTANCE2",
									["PrtsAfter"] = 1,
									["BitFlags"] = 504,
								}, -- [6]
								["n"] = 6,
							},
							["Icons"] = {
								"TMW:icon:1ZNzu1N3nE0K", -- [1]
								"TMW:icon:1ZsFvYGT2kWU", -- [2]
								"TMW:icon:1TeVAjjavXC6", -- [3]
								"TMW:icon:1V6noP8ARoel", -- [4]
								"TMW:icon:1TeVAjjXQ0WB", -- [5]
								"TMW:icon:1YbGRIr4FVqp", -- [6]
								"TMW:icon:1ZYXYoMn068Y", -- [7]
								"TMW:icon:1ZGiKdRg6oif", -- [8]
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
					},
				}, -- [7]
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
				}, -- [8]
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
				}, -- [9]
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
					},
				}, -- [10]
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
					},
				}, -- [11]
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
				}, -- [12]
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
					},
				}, -- [13]
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
				}, -- [14]
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
					},
				}, -- [15]
			},
		},
		["Dopesnare - Stitches"] = {
			["Version"] = 101600,
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
					["Rows"] = 3,
					["Alpha"] = 0,
					["Name"] = "SPELLS",
					["Locked"] = true,
					["Columns"] = 20,
					["Icons"] = {
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Power Word: Shield",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "Weakened Soul",
									["Type"] = "DEBUFFDUR",
								}, -- [1]
								{
									["Name"] = "Power Word: Shield",
									["Type"] = "BUFFDUR",
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["Level"] = 90,
									["Operator"] = "<",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1a7jsucSi0aE",
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
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1a7jsvYEKX8C",
							["Type"] = "cooldown",
							["Name"] = "Heal",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Operator"] = "<",
									["Level"] = 75,
									["Type"] = "HEALTH",
									["Unit"] = "mouseover",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "mouseover",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "mouseover",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 2,
									["Unit"] = "mouseover",
								}, -- [4]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Heal",
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
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
							["GUID"] = "TMW:icon:1a7l2flZcXmn",
							["Type"] = "cooldown",
							["Name"] = "Renew",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "Renew",
									["Type"] = "BUFFDUR",
								}, -- [1]
								{
									["Type"] = "HEALTH",
									["Level"] = 90,
									["Operator"] = "<",
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
						}, -- [3]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Renew",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Renew",
									["Unit"] = "mouseover",
								}, -- [1]
								{
									["Unit"] = "mouseover",
									["Level"] = 90,
									["Type"] = "HEALTH",
									["Operator"] = "<",
								}, -- [2]
								{
									["Type"] = "EXISTS",
									["Unit"] = "mouseover",
								}, -- [3]
								{
									["Type"] = "ALIVE",
									["Unit"] = "mouseover",
								}, -- [4]
								{
									["Type"] = "REACT",
									["Level"] = 2,
									["Unit"] = "mouseover",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1a9jdXHzXsKe",
							["States"] = {
								{
									["Alpha"] = 0,
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
							["ManaCheck"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "mouseover",
							["Name"] = "Magic",
							["GUID"] = "TMW:icon:1a9ihU2QC18O",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Name"] = "magi",
									["Unit"] = "mouseover",
								}, -- [1]
								{
									["Type"] = "ALIVE",
									["Unit"] = "mouseover",
									["Operator"] = "<",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 2,
									["Unit"] = "mouseover",
								}, -- [3]
								["n"] = 3,
							},
							["CustomTex"] = "527",
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
						}, -- [20]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shoot",
							["GUID"] = "TMW:icon:1a7jsvYu6Fu1",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [1]
								{
									["Name"] = "InCombatLockdown() and not IsCurrentSpell(5019)",
									["Type"] = "LUA",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "6660",
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
						}, -- [21]
						{
							["GUID"] = "TMW:icon:1a7jsvYwXc4j",
							["Type"] = "cooldown",
							["Name"] = "Shadow Word: Pain",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Shadow Word: Pain",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "CREATURETYPE",
									["Level"] = 1,
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Name"] = "xTTD > 6",
									["Type"] = "LUA",
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
						}, -- [22]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Devouring Plague",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Devouring Plague",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "CREATURETYPE",
									["Level"] = 1,
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1a9kNk57eWOn",
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
							["GUID"] = "TMW:icon:1a9kPVhaMuWr",
							["Type"] = "cooldown",
							["Name"] = "Mind Flay",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Level"] = 50,
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "SPEED",
								}, -- [2]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Mind Flay",
									["Level"] = 1,
								}, -- [3]
								{
									["Unit"] = "target",
									["Type"] = "DEBUFFDUR",
									["Name"] = "Shadow Word: Pain",
									["Operator"] = "~=",
								}, -- [4]
								{
									["Type"] = "REACT",
									["Level"] = 1,
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
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [24]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mind Blast",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Level"] = 50,
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "SPEED",
								}, -- [2]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Mind Blast",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Name"] = "xTTD > 6",
									["Type"] = "LUA",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1a7l2fmgZwCv",
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
							["GUID"] = "TMW:icon:1a7l2fmj178S",
							["Type"] = "cooldown",
							["Name"] = "Smite",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Level"] = 50,
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [2]
								["n"] = 2,
							},
							["ManaCheck"] = true,
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
						{
							["GUID"] = "TMW:icon:1a7lUEjXAASn",
							["Type"] = "cooldown",
							["Name"] = "Inner Fire",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "Inner Fire",
									["Type"] = "BUFFDUR",
								}, -- [1]
								["n"] = 1,
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
						}, -- [41]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Power Word: Fortitude",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "Power Word: Fortitude",
									["Type"] = "BUFFDUR",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1a8KSxK3rF0S",
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
						}, -- [42]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shadow Word: Pain",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Shadow Word: Pain",
									["Unit"] = "mouseover",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "mouseover",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "mouseover",
								}, -- [3]
								{
									["Type"] = "ALIVE",
									["Unit"] = "mouseover",
								}, -- [4]
								{
									["Name"] = "xInRange(30,\"mouseover\")",
									["Type"] = "LUA",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1a7lUEjf6xOH",
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
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905",
							["OnlyInBags"] = true,
							["GUID"] = "TMW:icon:1a7lUElf_=Se",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 40,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "29203",
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
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["OnlyInBags"] = true,
							["GUID"] = "TMW:icon:1a7lUElnNLeF",
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
						}, -- [60]
					},
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Point"] = {
						["y"] = -23.75588384615364,
						["x"] = -234.5020463616204,
					},
					["Name"] = "OTHER PORTRAIT",
					["Scale"] = 1.5,
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
					["GUID"] = "TMW:group:1TQuFk14Ix42",
					["Point"] = {
						["y"] = -120,
						["x"] = -5.450076092640056e-05,
					},
					["Scale"] = 1.5,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1a7lUElf_=Se", -- [1]
								"TMW:icon:1a7lUElnNLeF", -- [2]
								"TMW:icon:1a9ihU2QC18O", -- [3]
								"TMW:icon:1a7l2flZcXmn", -- [4]
								"TMW:icon:1a9jdXHzXsKe", -- [5]
								"TMW:icon:1a7jsucSi0aE", -- [6]
								"TMW:icon:1a7jsvYEKX8C", -- [7]
								"TMW:icon:1a8KSxK3rF0S", -- [8]
								"TMW:icon:1a7lUEjXAASn", -- [9]
								"TMW:icon:1a7l2fmgZwCv", -- [10]
								"TMW:icon:1a7jsvYwXc4j", -- [11]
								"TMW:icon:1a9kNk57eWOn", -- [12]
								"TMW:icon:1a7lUEjf6xOH", -- [13]
								"TMW:icon:1a9kPVhaMuWr", -- [14]
								"TMW:icon:1a7jsvYu6Fu1", -- [15]
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
				}, -- [3]
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
							["Icons"] = {
								"TMW:icon:1a7lUElf_=Se", -- [1]
								"TMW:icon:1a7lUElnNLeF", -- [2]
								"TMW:icon:1a9ihU2QC18O", -- [3]
								"TMW:icon:1a7l2flZcXmn", -- [4]
								"TMW:icon:1a9jdXHzXsKe", -- [5]
								"TMW:icon:1a7jsucSi0aE", -- [6]
								"TMW:icon:1a7jsvYEKX8C", -- [7]
								"TMW:icon:1a8KSxK3rF0S", -- [8]
								"TMW:icon:1a7lUEjXAASn", -- [9]
								"TMW:icon:1a7l2fmgZwCv", -- [10]
								"TMW:icon:1a7jsvYwXc4j", -- [11]
								"TMW:icon:1a9kNk57eWOn", -- [12]
								"TMW:icon:1a7lUEjf6xOH", -- [13]
								"TMW:icon:1a9kPVhaMuWr", -- [14]
								"TMW:icon:1a7jsvYu6Fu1", -- [15]
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
				}, -- [4]
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
				}, -- [5]
				{
					["GUID"] = "TMW:group:1ZM=EKbLryuK",
					["Columns"] = 1,
					["Scale"] = 0.4,
					["Locked"] = true,
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
			["Locked"] = true,
			["Version"] = 101600,
			["NumGroups"] = 6,
			["TextureName"] = "xVerminClean",
		},
		["SHAMAN test"] = {
			["Locked"] = true,
			["NumGroups"] = 5,
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Lightning Bolt",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEED",
								}, -- [1]
								{
									["Name"] = "xInRange(30)",
									["Type"] = "LUA",
								}, -- [2]
								["n"] = 2,
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Flame Shock",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Flame Shock",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1Zi_P9LYFYqt",
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Earth Shock",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 4,
									["Name"] = "Flame Shock",
									["Operator"] = ">",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1a3BehKNMJeZ",
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Fire Nova",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "xInRange(2) and xAOE() > 1",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "TOTEM1",
									["Operator"] = "~=",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1a3BehLSsHyB",
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
							["Type"] = "cooldown",
							["Name"] = "Rockbiter Weapon",
							["Conditions"] = {
								{
									["Type"] = "MAINHAND",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1az3vfr0teCJ",
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
							["Type"] = "cooldown",
							["Name"] = "Flametongue Weapon",
							["Conditions"] = {
								{
									["Type"] = "MAINHAND",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1Zi_P9NDuquZ",
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
							["Name"] = "Lightning Shield",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										[2] = "[Stacks:Hide(0)]",
									},
								},
							},
							["Conditions"] = {
								{
									["Name"] = "Lightning Shield",
									["Type"] = "BUFFDUR",
								}, -- [1]
								{
									["Name"] = "Water Shield",
									["Type"] = "BUFFDUR",
								}, -- [2]
								{
									["Type"] = "MANA",
									["Level"] = 50,
									["Operator"] = ">",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1Zi=Lf3qDCmn",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Water Shield",
							["Conditions"] = {
								{
									["Name"] = "Lightning Shield",
									["Type"] = "BUFFDUR",
								}, -- [1]
								{
									["Name"] = "Water Shield",
									["Type"] = "BUFFDUR",
								}, -- [2]
								{
									["Type"] = "MANA",
									["Level"] = 50,
									["Operator"] = "<=",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1a3v7YGRBZRQ",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Strength of Earth Totem",
							["Conditions"] = {
								{
									["Name"] = "Strength of Earth",
									["Type"] = "BUFFDUR",
								}, -- [1]
								{
									["Name"] = "-- call of the elements\nnot IsSpellKnown(66842) and xInRange(2)",
									["Type"] = "LUA",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1a3BehLXSU4P",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [39]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Searing Totem",
							["Conditions"] = {
								{
									["Name"] = "Searing Totem",
									["Type"] = "TOTEM1",
								}, -- [1]
								{
									["Name"] = "-- call of the elements\nnot IsSpellKnown(66842) and xInRange(2) and xAOE() > 1",
									["Type"] = "LUA",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1a3BehLVCfO3",
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
							["Type"] = "cooldown",
							["Name"] = "Healing Wave",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 50,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "SPEED",
								}, -- [2]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Healing Wave",
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1Zhjpe9Lw_WF",
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
							["GUID"] = "TMW:icon:1a3BehMeWjaB",
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "mouseover",
							["Name"] = "Poison; Disease",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Unit"] = "mouseover",
								}, -- [1]
								{
									["Type"] = "REACT",
									["Level"] = 2,
									["Unit"] = "mouseover",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "526",
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
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["OnlyInBags"] = true,
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
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838",
							["OnlyInBags"] = true,
							["GUID"] = "TMW:icon:1ZhjptZBAxKW",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 35,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "29203",
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
					["Name"] = "SHAMAN SPELLS",
					["Locked"] = true,
					["Alpha"] = 0,
					["Columns"] = 20,
					["OnlyInCombat"] = true,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Point"] = {
						["y"] = -20.00000522536274,
						["x"] = -229.9999934656047,
					},
					["Columns"] = 1,
					["Alpha"] = 0,
					["Scale"] = 1.5,
					["Name"] = "Other",
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
					},
					["TextureName"] = "Details Flat",
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TeVDtajUwqa",
					["Columns"] = 1,
					["Point"] = {
						["y"] = -140,
						["x"] = -5.450076092640056e-05,
					},
					["Name"] = "Rotation CENTER",
					["Scale"] = 1.5,
					["Locked"] = true,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1ZhjptZBAxKW", -- [1]
								"TMW:icon:1ZBi1G1LSN04", -- [2]
								"TMW:icon:1a3BehMeWjaB", -- [3]
								"TMW:icon:1Zhjpe9Lw_WF", -- [4]
								"TMW:icon:1a3v7YGRBZRQ", -- [5]
								"TMW:icon:1Zi=Lf3qDCmn", -- [6]
								"TMW:icon:1az3vfr0teCJ", -- [7]
								"TMW:icon:1a3BehKNMJeZ", -- [8]
								"TMW:icon:1Zi_P9LYFYqt", -- [9]
								"TMW:icon:1a3BehLSsHyB", -- [10]
								"TMW:icon:1TeVAjjXQ0WB", -- [11]
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
					["Point"] = {
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Name"] = "Rotation TOPLEFT",
					["Scale"] = 0.4,
					["Locked"] = true,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Conditions"] = {
								{
									["Name"] = "not IsAltKeyDown();",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
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
								"TMW:icon:1ZhjptZBAxKW", -- [1]
								"TMW:icon:1ZBi1G1LSN04", -- [2]
								"TMW:icon:1a3BehMeWjaB", -- [3]
								"TMW:icon:1Zhjpe9Lw_WF", -- [4]
								"TMW:icon:1a3v7YGRBZRQ", -- [5]
								"TMW:icon:1Zi=Lf3qDCmn", -- [6]
								"TMW:icon:1az3vfr0teCJ", -- [7]
								"TMW:icon:1a3BehKNMJeZ", -- [8]
								"TMW:icon:1Zi_P9LYFYqt", -- [9]
								"TMW:icon:1a3BehLSsHyB", -- [10]
								"TMW:icon:1TeVAjjXQ0WB", -- [11]
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
				}, -- [4]
				{
					["GUID"] = "TMW:group:1ZI1LEibEVeR",
					["Columns"] = 1,
					["Point"] = {
						["x"] = 30,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Name"] = "ROTATION QUEUE",
					["Scale"] = 0.4,
					["Locked"] = true,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1a3BehLVCfO3", -- [1]
								"TMW:icon:1a3BehLXSU4P", -- [2]
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
			["Version"] = 101600,
		},
		["Lonac - Stitches"] = {
			["Version"] = 101600,
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
							["Enabled"] = true,
							["Name"] = "Blood Fury",
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
							["GUID"] = "TMW:icon:1TZvNvgAkfmq",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1TZve345g=GK",
								},
							},
							["Enabled"] = true,
							["Name"] = "Enrage",
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
								"TMW:icon:1V6ky7UreCKN", -- [1]
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
								"TMW:icon:1V6ky7Uy=NmE", -- [1]
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
					["LayoutDirection"] = 2,
					["Name"] = "Rotation TOPLEFT",
					["Locked"] = true,
					["Columns"] = 1,
					["OnlyInCombat"] = true,
				}, -- [3]
				{
					["GUID"] = "TMW:group:1V6ky7Uf4nZ5",
					["Scale"] = 1,
					["Name"] = "Warlock Spells",
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
								{
								}, -- [3]
								{
								}, -- [4]
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
								{
								}, -- [3]
								{
								}, -- [4]
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
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shadow Bolt",
							["ManaCheck"] = true,
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
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "healh",
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
					["Locked"] = true,
					["Columns"] = 20,
					["Alpha"] = 0,
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
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
								"TMW:icon:1V6ky7UreCKN", -- [1]
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
								"TMW:icon:1V6ky7Uy=NmE", -- [1]
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
					["LayoutDirection"] = 2,
					["Name"] = "Rotation CENTER",
					["Locked"] = true,
					["Point"] = {
						["y"] = -120,
						["x"] = -5.450076092640056e-05,
					},
					["OnlyInCombat"] = true,
				}, -- [5]
			},
			["NumGroups"] = 5,
			["Version"] = 100900,
		},
		["ROGUE"] = {
			["Locked"] = true,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Sinister Strike",
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
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
							["Name"] = "Pick Pocket",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [1]
								{
									["Level"] = 1,
									["Type"] = "COMBAT",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1ZTh8w04p6iT",
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
						}, -- [60]
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
							["Icons"] = {
								"TMW:icon:1ZBi1G1LSN04", -- [1]
								"TMW:icon:1ZBi1G1Ik=8q", -- [2]
								"TMW:icon:1TeVAjjavXC6", -- [3]
								"TMW:icon:1TeVAjjXQ0WB", -- [4]
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
							["Icons"] = {
								"TMW:icon:1ZBi1G1LSN04", -- [1]
								"TMW:icon:1ZBi1G1Ik=8q", -- [2]
								"TMW:icon:1TeVAjjavXC6", -- [3]
								"TMW:icon:1TeVAjjXQ0WB", -- [4]
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
					["Locked"] = true,
				}, -- [5]
			},
			["NumGroups"] = 5,
			["Version"] = 100800,
		},
		["Dopeah - Stitches"] = {
			["Version"] = 101600,
		},
		["Dopeclaw - Stitches"] = {
			["Version"] = 101600,
		},
		["MAGE"] = {
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TQvxnAfbGyU",
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Name"] = "Spells",
					["Icons"] = {
						{
							["Enabled"] = true,
							["OnlyMine"] = true,
							["Name"] = "Dampen Magic",
							["GUID"] = "TMW:icon:1TQv_LtTwAae",
							["ShowTimerText"] = true,
							["Type"] = "buff",
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
							["GUID"] = "TMW:icon:1TQv_Ltf40Wl",
							["Type"] = "buff",
							["Name"] = "Mana Shield",
							["Enabled"] = true,
							["ShowTimerText"] = true,
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
							["GUID"] = "TMW:icon:1TQv_Lti1RyX",
							["Type"] = "cooldown",
							["ShowTimerText"] = true,
							["Enabled"] = true,
							["Name"] = "Frost Nova",
							["CooldownCheck"] = true,
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
								{
								}, -- [3]
								{
								}, -- [4]
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
								{
								}, -- [3]
								{
								}, -- [4]
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
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
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
							["BuffOrDebuff"] = "HARMFUL",
							["GUID"] = "TMW:icon:1TWYMfcUzmi6",
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
					["Scale"] = 1,
					["Columns"] = 20,
					["Alpha"] = 0,
					["Locked"] = true,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYSTcQ410f",
					["Point"] = {
						["y"] = -40,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Scale"] = 1,
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TWYSTcSCl0z",
							["Type"] = "buff",
							["Name"] = "Renew",
							["Enabled"] = true,
							["ShowTimerText"] = true,
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
							["GUID"] = "TMW:icon:1TZvNvgAkfmq",
							["Type"] = "buff",
							["Name"] = "Enrage",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1TZve345g=GK",
								},
							},
							["Enabled"] = true,
							["ShowTimerText"] = true,
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
					["Name"] = "General Buffs/Debbufs",
					["Locked"] = true,
					["Alpha"] = 0,
					["Columns"] = 20,
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Name"] = "BuffTrack",
					["Point"] = {
						["y"] = 29.72017875204246,
						["x"] = -207.369429939947,
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
								"TMW:icon:1TQv_Ltf40Wl", -- [1]
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
								"TMW:icon:1TQv_Lti1RyX", -- [1]
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
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TU=hLnlwyeY", -- [1]
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
						}, -- [6]
					},
					["TextureName"] = "Details Flat",
				}, -- [3]
			},
			["Locked"] = true,
			["Version"] = 100800,
			["NumGroups"] = 3,
			["TextureName"] = "xVerminClean",
		},
		["SHAMAN"] = {
			["Locked"] = true,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Scale"] = 1,
					["Rows"] = 3,
					["Icons"] = {
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Lightning Bolt",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEED",
								}, -- [1]
								{
									["Name"] = "xInRange(30)",
									["Type"] = "LUA",
								}, -- [2]
								["n"] = 2,
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
							["GUID"] = "TMW:icon:1Zi_P9LYFYqt",
							["Type"] = "cooldown",
							["Name"] = "Flame Shock",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Flame Shock",
									["Unit"] = "target",
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Earth Shock",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 4,
									["Name"] = "Flame Shock",
									["Operator"] = ">",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1a3BehKNMJeZ",
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Fire Nova",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "xInRange(2) and xAOE() > 1",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "TOTEM1",
									["Operator"] = "~=",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1a3BehLSsHyB",
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
							["GUID"] = "TMW:icon:1az3vfr0teCJ",
							["Type"] = "cooldown",
							["Name"] = "Rockbiter Weapon",
							["Conditions"] = {
								{
									["Type"] = "MAINHAND",
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
						}, -- [19]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Flametongue Weapon",
							["Conditions"] = {
								{
									["Type"] = "MAINHAND",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1Zi_P9NDuquZ",
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
							["Name"] = "Lightning Shield",
							["Conditions"] = {
								{
									["Name"] = "Lightning Shield",
									["Type"] = "BUFFDUR",
								}, -- [1]
								{
									["Name"] = "Water Shield",
									["Type"] = "BUFFDUR",
								}, -- [2]
								{
									["Type"] = "MANA",
									["Level"] = 50,
									["Operator"] = ">",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1Zi=Lf3qDCmn",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Water Shield",
							["Conditions"] = {
								{
									["Name"] = "Lightning Shield",
									["Type"] = "BUFFDUR",
								}, -- [1]
								{
									["Name"] = "Water Shield",
									["Type"] = "BUFFDUR",
								}, -- [2]
								{
									["Type"] = "MANA",
									["Level"] = 50,
									["Operator"] = "<=",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1a3v7YGRBZRQ",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Strength of Earth Totem",
							["Conditions"] = {
								{
									["Name"] = "Strength of Earth",
									["Type"] = "BUFFDUR",
								}, -- [1]
								{
									["Name"] = "-- call of the elements\nnot IsSpellKnown(66842) and xInRange(2)",
									["Type"] = "LUA",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1a3BehLXSU4P",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [39]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Searing Totem",
							["Conditions"] = {
								{
									["Name"] = "Searing Totem",
									["Type"] = "TOTEM1",
								}, -- [1]
								{
									["Name"] = "-- call of the elements\nnot IsSpellKnown(66842) and xInRange(2) and xAOE() > 1",
									["Type"] = "LUA",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1a3BehLVCfO3",
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
							["Type"] = "cooldown",
							["Name"] = "Healing Wave",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 50,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "SPEED",
								}, -- [2]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Healing Wave",
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1Zhjpe9Lw_WF",
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
							["GUID"] = "TMW:icon:1a3BehMeWjaB",
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "mouseover",
							["Name"] = "Poison; Disease",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Unit"] = "mouseover",
								}, -- [1]
								{
									["Type"] = "REACT",
									["Level"] = 2,
									["Unit"] = "mouseover",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "526",
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
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["OnlyInBags"] = true,
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
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838",
							["OnlyInBags"] = true,
							["GUID"] = "TMW:icon:1ZhjptZBAxKW",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 35,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "29203",
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
					["Name"] = "SHAMAN SPELLS",
					["Locked"] = true,
					["Alpha"] = 0,
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["OnlyInCombat"] = true,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Name"] = "Other",
					["Point"] = {
						["y"] = -20.00000522536274,
						["x"] = -229.9999934656047,
					},
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
					},
					["Scale"] = 1.5,
					["Columns"] = 1,
					["Alpha"] = 0,
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
									["Name"] = "not IsAltKeyDown();",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
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
								"TMW:icon:1ZhjptZBAxKW", -- [1]
								"TMW:icon:1ZBi1G1LSN04", -- [2]
								"TMW:icon:1a3BehMeWjaB", -- [3]
								"TMW:icon:1Zhjpe9Lw_WF", -- [4]
								"TMW:icon:1a3v7YGRBZRQ", -- [5]
								"TMW:icon:1Zi=Lf3qDCmn", -- [6]
								"TMW:icon:1az3vfr0teCJ", -- [7]
								"TMW:icon:1a3BehKNMJeZ", -- [8]
								"TMW:icon:1Zi_P9LYFYqt", -- [9]
								"TMW:icon:1a3BehLSsHyB", -- [10]
								"TMW:icon:1TeVAjjXQ0WB", -- [11]
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
					["Point"] = {
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
							["Conditions"] = {
								{
									["Name"] = "not IsAltKeyDown();",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
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
								"TMW:icon:1ZhjptZBAxKW", -- [1]
								"TMW:icon:1ZBi1G1LSN04", -- [2]
								"TMW:icon:1a3BehMeWjaB", -- [3]
								"TMW:icon:1Zhjpe9Lw_WF", -- [4]
								"TMW:icon:1a3v7YGRBZRQ", -- [5]
								"TMW:icon:1Zi=Lf3qDCmn", -- [6]
								"TMW:icon:1az3vfr0teCJ", -- [7]
								"TMW:icon:1a3BehKNMJeZ", -- [8]
								"TMW:icon:1Zi_P9LYFYqt", -- [9]
								"TMW:icon:1a3BehLSsHyB", -- [10]
								"TMW:icon:1TeVAjjXQ0WB", -- [11]
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
							["Icons"] = {
								"TMW:icon:1a3BehLVCfO3", -- [1]
								"TMW:icon:1a3BehLXSU4P", -- [2]
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
			["Version"] = 101600,
			["NumGroups"] = 5,
		},
	},
}
