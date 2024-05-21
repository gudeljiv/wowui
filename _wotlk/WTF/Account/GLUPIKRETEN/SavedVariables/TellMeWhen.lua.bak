
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
	["Version"] = 102601,
	["profileKeys"] = {
		["Mxzq - Golemagg"] = "HUNTER",
		["Vermina - Golemagg"] = "PALADIN",
		["Mxyz - Golemagg"] = "PRIEST",
		["Battlearm - Golemagg"] = "DEATHKNIGHT",
		["Battitude - Golemagg"] = "ROGUE",
		["Kaonac - Jin'do"] = "PRIEST",
		["Battledog - Gehennas"] = "WARRIOR",
		["Tandaram - Jin'do"] = "WARRIOR",
		["Wells - Jin'do"] = "DRUID",
		["Poklopac - Dreadnaught"] = "HUNTER",
		["Tudum - Jin'do"] = "WARRIOR",
		["Vermin - Golemagg"] = "WARRIOR",
		["Asjrdfsad - Golemagg"] = "PRIEST",
		["Battlearm - Gehennas"] = "WARRIOR",
		["Augustin - Golemagg"] = "MAGE",
		["Moolatz - Golemagg"] = "DRUID",
		["Provokator - Jin'do"] = "HUNTER",
		["Mxyzptlk - Golemagg"] = "WARLOCK",
		["Pitchwise - Ashbringer"] = "SHAMAN",
		["Poklopac - Mirage Raceway"] = "HUNTER",
		["Miqa - Golemagg"] = "PRIEST",
		["Tudum - Ashbringer"] = "WARRIOR",
		["Handrmandr - Golemagg"] = "PALADIN",
		["Tadibey - Golemagg"] = "SHAMAN",
		["Moolatz - Dreadnaught"] = "DRUID",
	},
	["profiles"] = {
		["HUNTER"] = {
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Point"] = {
						["y"] = -4.996173281900221,
						["x"] = -0.0002605930177353105,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Locked"] = true,
					["Scale"] = 1.0008,
					["Rows"] = 3,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Serpent Sting",
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Serpent Sting",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "CREATURETYPE",
									["Level"] = 1,
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
									["Operator"] = "<=",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Serpent Sting",
									["AndOr"] = "OR",
									["Level"] = 2.5,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Viper Sting",
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "Misdirection",
								}, -- [6]
								{
									["Name"] = "not xBehindTarget()",
									["Type"] = "LUA",
								}, -- [7]
								["n"] = 7,
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
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["ManaCheck"] = true,
							["Name"] = "Hunter's Mark",
							["ShowTimerText"] = true,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Hunter's Mark",
									["Unit"] = "target",
								}, -- [1]
								{
									["Unit"] = "target",
									["Level"] = 300000,
									["Type"] = "HEALTH_ABS",
									["Operator"] = ">=",
								}, -- [2]
								["n"] = 2,
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
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "FOCUS",
									["Level"] = 70,
									["Name"] = "Explosive Shot",
									["Operator"] = ">=",
								}, -- [1]
								{
									["Name"] = "not xBehindTarget()",
									["Type"] = "LUA",
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
							["Enabled"] = true,
							["Type"] = "reactive",
							["RangeCheck"] = true,
							["CooldownCheck"] = true,
							["Name"] = "Kill Shot",
							["GUID"] = "TMW:icon:1ZNfjO2NI8Ga",
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Level"] = 1,
									["Name"] = "Kill Shot",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "HEALTH",
									["Name"] = "Kill Shot",
									["Level"] = 20,
									["Operator"] = "<=",
									["Unit"] = "target",
								}, -- [2]
								["n"] = 2,
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
						}, -- [5]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Multi-Shot",
							["GUID"] = "TMW:icon:1YS2u64Alj4P",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "xBehindTarget()",
									["Type"] = "LUA",
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
							["Name"] = "Steady Shot",
							["GUID"] = "TMW:icon:1YS2u64Csf0H",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Steady Shot",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "SPEED",
								}, -- [2]
								["n"] = 2,
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
						}, -- [7]
						{
							["Enabled"] = true,
							["Type"] = "reactive",
							["RangeCheck"] = true,
							["CooldownCheck"] = true,
							["Name"] = "Kill Command",
							["GUID"] = "TMW:icon:1YYUluwZXp0V",
							["Conditions"] = {
								{
									["Unit"] = "pet",
									["Type"] = "EXISTS",
								}, -- [1]
								{
									["Unit"] = "pet",
									["Type"] = "ALIVE",
								}, -- [2]
								{
									["Name"] = "Steady Shot",
									["Type"] = "CURRENTSPELL",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Black Arrow",
							["GUID"] = "TMW:icon:1ZdATsSrLd8x",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Name"] = "Black Arrow",
									["Level"] = 1,
									["Unit"] = "target",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Name"] = "true\n-- not xBehindTarget()",
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
						}, -- [10]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Explosive Trap",
							["Conditions"] = {
								{
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Explosive Trap",
									["Unit"] = "target",
								}, -- [1]
								{
									["Name"] = "-- xInRange(0,\"target\",\"min\") -- and xBehindTarget()",
									["Type"] = "LUA",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1ZlhdlmrsoGF",
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
						}, -- [11]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Explosive Shot",
							["GUID"] = "TMW:icon:1ZdATsSuWeuC",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "not xBehindTarget()",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["AndOr"] = "OR",
									["Name"] = "Lock and Load",
									["Operator"] = "~=",
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
						}, -- [12]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Aspect of the Hawk",
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
								{
									["Name"] = "-- https://www.wowhead.com/wotlk/spell=61846/aspect-of-the-dragonhawk\nnot (IsSpellKnown(61846) or IsSpellKnown(61847))",
									["Type"] = "LUA",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1ZdATsSw3pms",
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
						}, -- [13]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Viper Sting",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Viper Sting",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "CREATURETYPE",
									["Level"] = 1,
									["Name"] = "Elemental",
									["Unit"] = "target",
								}, -- [2]
								{
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Viper Sting",
									["Unit"] = "target",
								}, -- [3]
								{
									["Unit"] = "target",
									["Level"] = 5000,
									["Type"] = "MANA_MAX",
									["Operator"] = ">=",
								}, -- [4]
								{
									["Type"] = "MANA",
									["Level"] = 20,
									["Operator"] = "<=",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1ZlO8O7PRIiL",
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
									["Unit"] = "pet",
									["Level"] = 90,
									["Type"] = "HEALTH",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Checked"] = true,
									["Type"] = "BUFFDUR",
									["Name"] = "Mend Pet",
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
						}, -- [20]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "EITHER",
							["Unit"] = "target",
							["Name"] = "Enraged",
							["RangeCheck"] = true,
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1ZuahEVFckqw",
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
							["GUID"] = "TMW:icon:1ZDQ16jlvSmQ",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Serpent Sting",
									["Operator"] = "~=",
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
							["Name"] = "Aimed Shot",
							["ManaCheck"] = true,
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
									["PrtsAfter"] = 2,
									["Type"] = "SPELLCD",
									["Name"] = "Chimera Shot",
									["Operator"] = "~=",
								}, -- [3]
								{
									["Type"] = "SPELLCD",
									["Level"] = 1,
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
							["GUID"] = "TMW:icon:1ZDRwPNRMoWc",
							["Conditions"] = {
								{
									["Unit"] = "focus",
									["Type"] = "EXISTS",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["AndOr"] = "OR",
									["Unit"] = "pet",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Concussive Shot",
							["GUID"] = "TMW:icon:1ZDRwPNU7Z0Z",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "THREATSCALED",
									["Level"] = 100,
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
						}, -- [27]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Wing Clip",
							["GUID"] = "TMW:icon:1ZEKCuryiveD",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Wing Clip",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
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
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["OnlyInBags"] = true,
							["GUID"] = "TMW:icon:1ZFP_8OYz7Gr",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 60,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "6262",
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
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905",
							["OnlyInBags"] = true,
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
							["Enabled"] = true,
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
							["GUID"] = "TMW:icon:1ZB9QFehlUaz",
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
								"TMW:icon:1X=OmHlbqz67", -- [1]
								"TMW:icon:1ZuahEVFckqw", -- [2]
								"TMW:icon:1ZEKCuryiveD", -- [3]
								"TMW:icon:1ZDRwPNU7Z0Z", -- [4]
								"TMW:icon:1ZFP_8OYz7Gr", -- [5]
								"TMW:icon:1ZFP_8OauieW", -- [6]
								"TMW:icon:1ZB9QFehlUaz", -- [7]
								"TMW:icon:1ZB9QFefrfi_", -- [8]
								"TMW:icon:1ZDRwPNRMoWc", -- [9]
								"TMW:icon:1ZDQ16jrgNie", -- [10]
								"TMW:icon:1TeVAjjavXC6", -- [11]
								"TMW:icon:1ZNfjO2NI8Ga", -- [12]
								"TMW:icon:1TeVAjjXQ0WB", -- [13]
								"TMW:icon:1ZdATsSrLd8x", -- [14]
								"TMW:icon:1ZdATsSuWeuC", -- [15]
								"TMW:icon:1YS2u64Alj4P", -- [16]
								"TMW:icon:1V6lsULwY3_Y", -- [17]
								"TMW:icon:1YS2u64Csf0H", -- [18]
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
								"TMW:icon:1X=OmHlbqz67", -- [1]
								"TMW:icon:1ZEKCuryiveD", -- [2]
								"TMW:icon:1ZuahEVFckqw", -- [3]
								"TMW:icon:1ZDRwPNU7Z0Z", -- [4]
								"TMW:icon:1ZFP_8OYz7Gr", -- [5]
								"TMW:icon:1ZFP_8OauieW", -- [6]
								"TMW:icon:1ZB9QFehlUaz", -- [7]
								"TMW:icon:1ZB9QFefrfi_", -- [8]
								"TMW:icon:1ZDRwPNRMoWc", -- [9]
								"TMW:icon:1ZDQ16jrgNie", -- [10]
								"TMW:icon:1TeVAjjavXC6", -- [11]
								"TMW:icon:1ZNfjO2NI8Ga", -- [12]
								"TMW:icon:1TeVAjjXQ0WB", -- [13]
								"TMW:icon:1ZdATsSrLd8x", -- [14]
								"TMW:icon:1ZdATsSuWeuC", -- [15]
								"TMW:icon:1YS2u64Alj4P", -- [16]
								"TMW:icon:1V6lsULwY3_Y", -- [17]
								"TMW:icon:1YS2u64Csf0H", -- [18]
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
			["Version"] = 102601,
			["NumGroups"] = 5,
			["TextureName"] = "xVerminClean",
		},
		["WARRIOR"] = {
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
					["Icons"] = {
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
							["GUID"] = "TMW:icon:1TQv_Ltf40Wl",
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
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Demoralizing Shout",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Demoralizing Shout",
									["Unit"] = "target",
								}, -- [2]
								{
									["Name"] = "xInRange(5)",
									["Type"] = "LUA",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1TWZdpV26rm5",
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
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Name"] = "Commanding Shout",
									["Operator"] = "~=",
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "Commanding Shout",
									["Level"] = 10,
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
								}, -- [4]
								["n"] = 4,
							},
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
						}, -- [3]
						{
							["GUID"] = "TMW:icon:1TU=hLnlwyeY",
							["Type"] = "cooldown",
							["ShowTimerText"] = true,
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Battle Stance; Berserker Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Taste for Blood",
									["Operator"] = "~=",
								}, -- [2]
								{
									["Type"] = "RAGE",
									["Level"] = 40,
									["Operator"] = "<=",
								}, -- [3]
								["n"] = 3,
							},
							["Name"] = "Overpower",
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
							["Name"] = "Revenge",
							["ManaCheck"] = true,
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
							["GUID"] = "TMW:icon:1Xrn34GriOqy",
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
						}, -- [6]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Heroic Strike",
							["GUID"] = "TMW:icon:1TQv_Lti1RyX",
							["Conditions"] = {
								{
									["Name"] = "xAOE(8) == 1",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 40,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["Level"] = 20,
									["Operator"] = ">",
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
						}, -- [7]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Cleave",
							["GUID"] = "TMW:icon:1Y2=7t59vfSn",
							["Conditions"] = {
								{
									["PrtsBefore"] = 2,
									["Type"] = "LUA",
									["Name"] = "xAOE(8) > 1",
								}, -- [1]
								{
									["Level"] = 40,
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
								}, -- [2]
								{
									["PrtsBefore"] = 1,
									["Type"] = "LUA",
									["Name"] = "xAOE(8) > 2",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Name"] = "Defensive Stance",
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 2,
									["Operator"] = ">=",
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
						}, -- [8]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Whirlwind",
							["ManaCheck"] = true,
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
									["Level"] = 0.6,
									["Type"] = "SPELLCD",
									["Name"] = "Whirlwind",
									["Operator"] = "<=",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1Xwc=6KNp27d",
							["States"] = {
								{
									["Alpha"] = 0,
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
							["Enabled"] = true,
							["Type"] = "reactive",
							["Name"] = "Victory Rush",
							["RangeCheck"] = true,
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
									["Name"] = "xAOE(10,true) > 0 or xUnitCastingNonInteruptable(\"target\")",
									["Type"] = "LUA",
								}, -- [3]
								{
									["AndOr"] = "OR",
									["Type"] = "NAME",
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
									["Level"] = 1,
									["Type"] = "REACT",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [6]
								["n"] = 6,
							},
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
						}, -- [12]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mortal Strike",
							["RangeCheck"] = true,
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1XzwOSGxkHLD",
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
								{
								}, -- [1]
								nil, -- [2]
								{
									["Alpha"] = 0,
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [14]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Slam",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEC",
									["Name"] = "DPS",
									["Level"] = 2,
								}, -- [1]
								{
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">",
								}, -- [2]
								{
									["Type"] = "RAGE",
									["Level"] = 40,
									["Operator"] = ">=",
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
						}, -- [15]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Bloodthirst",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Level"] = 0.6,
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
									["Color"] = "ffffffff",
									["Alpha"] = 1,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [16]
						{
							["Enabled"] = true,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Thunder Clap",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Thunder Clap",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "LUA",
									["AndOr"] = "OR",
									["Name"] = "xRend()",
									["PrtsAfter"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1YWHZ7T27TKe",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Name"] = "Hamstring",
							["RangeCheck"] = true,
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1Z55tRw3mJGc",
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
						}, -- [20]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Last Stand",
							["ManaCheck"] = true,
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
						}, -- [21]
						{
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shield Slam",
							["GUID"] = "TMW:icon:1Z55tRwA_pKn",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "IsEquippedItemType(\"Shields\")",
									["Type"] = "LUA",
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
							["Name"] = "Shield Block",
							["GUID"] = "TMW:icon:1Z55tRw8OaCM",
							["Conditions"] = {
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
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
									["Type"] = "LUA",
									["AndOr"] = "OR",
									["Name"] = "xUnitCastingNonInteruptable(\"target\")",
									["PrtsAfter"] = 1,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Rend",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Rend",
									["Level"] = 4,
									["Unit"] = "target",
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1cGTQ9CmyiK1",
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
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Feared; Sap; Incapacitated; Bellowing Roar; Frightening Shout",
							["ManaCheck"] = true,
							["BuffOrDebuff"] = "HARMFUL",
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
						}, -- [28]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shattering Throw",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEED",
								}, -- [1]
								{
									["Name"] = "Battle Stance",
									["Type"] = "STANCE",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Bloodlust",
									["Operator"] = "~=",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1ZXnmmtJyt4u",
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
						}, -- [31]
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
						}, -- [32]
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
						}, -- [33]
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
								["n"] = 1,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Vigilance",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Unit"] = "focus",
									["Type"] = "EXISTS",
								}, -- [1]
								{
									["Unit"] = "focus",
									["Type"] = "ALIVE",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 2,
									["Unit"] = "focus",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1Z7AzkxDmWSh",
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
							["Enabled"] = true,
							["Type"] = "item",
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
							["Name"] = "10",
							["CustomTex"] = "52766",
							["GUID"] = "TMW:icon:1ZsuoueneRaY",
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "BUFFDUR",
									["Name"] = "Bloodlust",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sated",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [2]
								{
									["Type"] = "LEVEL",
									["Level"] = -1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Level"] = 2,
									["Type"] = "SPEC",
								}, -- [4]
								["n"] = 4,
							},
							["OnlyEquipped"] = true,
							["OnlyInBags"] = true,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Devastate",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEC",
									["Name"] = "IsEquippedItemType(\"Shields\")",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1cImVBIcAY4d",
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
							["Name"] = "Shockwave",
							["GUID"] = "TMW:icon:1cInmKqRcgiv",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEC",
									["Name"] = "IsEquippedItemType(\"Shields\")",
									["Level"] = 1,
								}, -- [1]
								{
									["Name"] = "--xBehindTarget()\nxAOE(8) > 1",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Berserker Rage",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 56,
									["Operator"] = "<",
								}, -- [1]
								{
									["Name"] = "Enraged Regeneration",
									["Type"] = "SPELLCD",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1ZtDewhXS=4x",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Sunder Armor",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFSTACKS",
									["Name"] = "Sunder Armor",
									["PrtsBefore"] = 1,
									["Level"] = 5,
									["Unit"] = "target",
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sunder Armor",
									["Operator"] = "<",
									["Level"] = 7.5,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "LUA",
									["Name"] = "xTTD > 20",
									["Unit"] = "target",
								}, -- [3]
								{
									["Unit"] = "target",
									["Level"] = 82,
									["Type"] = "LEVEL",
									["Operator"] = ">=",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1ZvWsLUW_Q0D",
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
						}, -- [53]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Disarm",
							["GUID"] = "TMW:icon:1Z9CIRRFbqSA",
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
					},
					["Name"] = "SPELLS",
					["Locked"] = true,
					["Alpha"] = 0,
					["Columns"] = 20,
					["OnlyInCombat"] = true,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYSTcQ410f",
					["Point"] = {
						["y"] = -95,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
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
							["GUID"] = "TMW:icon:1YXBo4F3g7mS",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1TZve345g=GK",
								},
							},
							["Enabled"] = true,
							["Name"] = "Sweeping Strikes",
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
							["GUID"] = "TMW:icon:1ZmKyPVeTnOI",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 15,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "28491",
							["OnlyInBags"] = true,
						}, -- [17]
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
							["GUID"] = "TMW:icon:1X=ERE5iZ8VU",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 50,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "6262",
							["OnlyInBags"] = true,
						}, -- [18]
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
							["GUID"] = "TMW:icon:1ZPI5_kvU7St",
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
						}, -- [19]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Enraged Regeneration",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 55,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "xEnraged()",
									["Operator"] = "~=",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1ZsiUeXgH5da",
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
					["Columns"] = 20,
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
								"TMW:icon:1ZsuoueneRaY", -- [1]
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
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["BuffOrDebuff"] = "HARMFUL",
							["Icons"] = {
								"TMW:icon:1X=ERE5iZ8VU", -- [1]
								"TMW:icon:1ZmKyPVeTnOI", -- [2]
								"TMW:icon:1Z7R_6NwuWuK", -- [3]
								"TMW:icon:1ZtDewhXS=4x", -- [4]
								"TMW:icon:1ZsiUeXgH5da", -- [5]
								"TMW:icon:1Z679nrqAgG4", -- [6]
								"TMW:icon:1YO55KEUKaW4", -- [7]
								"TMW:icon:1YP2Xjgjriiu", -- [8]
								"TMW:icon:1cGTQ9CmyiK1", -- [9]
								"TMW:icon:1TQv_Ltf40Wl", -- [10]
								"TMW:icon:1Z7PEaK_TNq3", -- [11]
								"TMW:icon:1ZYr3kQXDQKM", -- [12]
								"TMW:icon:1cInmKqRcgiv", -- [13]
								"TMW:icon:1YWHZ7T27TKe", -- [14]
								"TMW:icon:1TU=hLnlwyeY", -- [15]
								"TMW:icon:1Z55tRwA_pKn", -- [16]
								"TMW:icon:1ZQcfScLCzCQ", -- [17]
								"TMW:icon:1Xwc=6KNp27d", -- [18]
								"TMW:icon:1YEqZQbYmmFD", -- [19]
								"TMW:icon:1Xrn34GriOqy", -- [20]
								"TMW:icon:1TWZdpV26rm5", -- [21]
								"TMW:icon:1XzwOSGxkHLD", -- [22]
								"TMW:icon:1cImVBIcAY4d", -- [23]
								"TMW:icon:1TZvNvflXM0_", -- [24]
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
								{
									["PrtsBefore"] = 1,
									["Type"] = "MOUNTED",
									["Name"] = "not UnitInVehicle(\"player\")",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "INSTANCE2",
									["Name"] = "Malygos",
									["BitFlags"] = 504,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [6]
								["n"] = 6,
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
								{
								}, -- [3]
								{
								}, -- [4]
								[100] = {
									["Alpha"] = 1,
								},
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
								"TMW:icon:1ZtDewhXS=4x", -- [4]
								"TMW:icon:1ZsiUeXgH5da", -- [5]
								"TMW:icon:1Z679nrqAgG4", -- [6]
								"TMW:icon:1YO55KEUKaW4", -- [7]
								"TMW:icon:1YP2Xjgjriiu", -- [8]
								"TMW:icon:1cGTQ9CmyiK1", -- [9]
								"TMW:icon:1TQv_Ltf40Wl", -- [10]
								"TMW:icon:1Z7PEaK_TNq3", -- [11]
								"TMW:icon:1ZYr3kQXDQKM", -- [12]
								"TMW:icon:1cInmKqRcgiv", -- [13]
								"TMW:icon:1YWHZ7T27TKe", -- [14]
								"TMW:icon:1TU=hLnlwyeY", -- [15]
								"TMW:icon:1Z55tRwA_pKn", -- [16]
								"TMW:icon:1ZQcfScLCzCQ", -- [17]
								"TMW:icon:1Xwc=6KNp27d", -- [18]
								"TMW:icon:1YEqZQbYmmFD", -- [19]
								"TMW:icon:1Xrn34GriOqy", -- [20]
								"TMW:icon:1TWZdpV26rm5", -- [21]
								"TMW:icon:1XzwOSGxkHLD", -- [22]
								"TMW:icon:1cImVBIcAY4d", -- [23]
								"TMW:icon:1TZvNvflXM0_", -- [24]
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
								{
									["PrtsBefore"] = 1,
									["Type"] = "MOUNTED",
									["Name"] = "not UnitInVehicle(\"player\")",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "INSTANCE2",
									["Name"] = "Malygos",
									["BitFlags"] = 504,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [6]
								["n"] = 6,
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
					["Locked"] = true,
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
								{
									["Name"] = "return not UnitInVehicle(\"player\")",
									["Type"] = "LUA",
								}, -- [8]
								["n"] = 8,
							},
							["Icons"] = {
								"TMW:icon:1ZPI5_kvU7St", -- [1]
								"TMW:icon:1TQv_Lti1RyX", -- [2]
								"TMW:icon:1Y2=7t59vfSn", -- [3]
								"TMW:icon:1ZYr3kQhGs06", -- [4]
								"TMW:icon:1Z7PEaKwPKnX", -- [5]
								"TMW:icon:1Z55tRw68qC=", -- [6]
								"TMW:icon:1ZGdp_HEzv8p", -- [7]
								"TMW:icon:1ZsiQTrMcI1p", -- [8]
								"TMW:icon:1ZsuoueneRaY", -- [9]
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
					["Scale"] = 0.4,
				}, -- [6]
				{
					["GUID"] = "TMW:group:1ZM=EKbLryuK",
					["Point"] = {
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
					},
					["Scale"] = 0.4,
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
					["Locked"] = true,
				}, -- [7]
			},
			["Locked"] = true,
			["Version"] = 102601,
			["NumGroups"] = 7,
			["TextureName"] = "xVerminClean",
		},
		["ROGUE"] = {
			["Locked"] = true,
			["NumGroups"] = 5,
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
							["Type"] = "cooldown",
							["RangeCheck"] = true,
							["OnlyMine"] = true,
							["Name"] = "Eviscerate",
							["Enabled"] = true,
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
							["GUID"] = "TMW:icon:1ZBi1G1Ik=8q",
							["Type"] = "item",
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838",
							["OnlyInBags"] = true,
							["Enabled"] = true,
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
						}, -- [58]
						{
							["GUID"] = "TMW:icon:1ZBi1G1LSN04",
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["OnlyInBags"] = true,
							["Enabled"] = true,
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
							["GUID"] = "TMW:icon:1ZTh8w04p6iT",
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
			["Version"] = 101600,
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
							["Enabled"] = true,
							["OnlyMine"] = true,
							["ShowTimerText"] = true,
							["GUID"] = "TMW:icon:1TQv_LtTwAae",
							["Name"] = "Dampen Magic",
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
							["ShowTimerText"] = true,
							["Enabled"] = true,
							["Name"] = "Mana Shield",
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
							["Name"] = "Blink",
							["Enabled"] = true,
							["ShowTimerText"] = true,
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
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
							["Name"] = "Sunder Armor",
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
					["Locked"] = true,
					["Columns"] = 20,
					["Alpha"] = 0,
					["Scale"] = 1,
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
							["ShowTimerText"] = true,
							["Enabled"] = true,
							["Name"] = "Renew",
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
			["Version"] = 102601,
			["NumGroups"] = 3,
			["TextureName"] = "xVerminClean",
		},
		["PRIEST"] = {
			["Groups"] = {
				{
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Scale"] = 1,
					["Rows"] = 3,
					["Locked"] = true,
					["GUID"] = "TMW:group:1TQvxnAfbGyU",
					["Columns"] = 20,
					["Alpha"] = 0,
					["Name"] = "SPELLS",
					["Icons"] = {
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Power Word: Shield",
							["GUID"] = "TMW:icon:1cI7GiRvWhaO",
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
									["Type"] = "DEBUFFDUR",
									["Name"] = "Weakened Soul",
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Power Word: Shield",
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["Operator"] = "<",
									["Level"] = 90,
								}, -- [3]
								["n"] = 3,
							},
						}, -- [1]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Power Word: Shield",
							["GUID"] = "TMW:icon:1cHVGCLT5o8x",
							["ManaCheck"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Unit"] = "mouseover",
									["Name"] = "Weakened Soul",
								}, -- [1]
								{
									["Type"] = "HEALTH",
									["Operator"] = "<",
									["Unit"] = "mouseover",
									["Level"] = 80,
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
									["Unit"] = "mouseover",
									["Level"] = 2,
								}, -- [5]
								["n"] = 5,
							},
						}, -- [2]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Renew",
							["GUID"] = "TMW:icon:1a7l2flZcXmn",
							["ManaCheck"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Renew",
								}, -- [1]
								{
									["Type"] = "HEALTH",
									["Operator"] = "<",
									["Level"] = 70,
								}, -- [2]
								["n"] = 2,
							},
						}, -- [3]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Renew",
							["ManaCheck"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Unit"] = "mouseover",
									["Name"] = "Renew",
								}, -- [1]
								{
									["Type"] = "HEALTH",
									["Operator"] = "<",
									["Unit"] = "mouseover",
									["Level"] = 80,
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
									["Unit"] = "mouseover",
									["Level"] = 2,
								}, -- [5]
								["n"] = 5,
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
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Shadow Word: Pain",
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
							["GUID"] = "TMW:icon:1a7jsvYwXc4j",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Operator"] = "<=",
									["Name"] = "Shadow Word: Pain",
									["Level"] = 1.4,
								}, -- [1]
								{
									["Type"] = "CREATURETYPE",
									["Unit"] = "target",
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "SPEC",
									["Level"] = 1,
								}, -- [4]
								["n"] = 4,
							},
						}, -- [7]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Devouring Plague",
							["GUID"] = "TMW:icon:1a9kNk57eWOn",
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
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Operator"] = "<=",
									["Name"] = "Devouring Plague",
									["Level"] = 1.4,
								}, -- [1]
								{
									["Type"] = "CREATURETYPE",
									["Unit"] = "target",
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "SPEC",
									["Level"] = 1,
								}, -- [4]
								["n"] = 4,
							},
						}, -- [8]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Vampiric Touch",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Operator"] = "<=",
									["Name"] = "Vampiric Touch",
									["Level"] = 1.4,
								}, -- [1]
								{
									["Type"] = "CREATURETYPE",
									["Unit"] = "target",
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "SPEC",
									["Level"] = 1,
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
							["RangeCheck"] = true,
						}, -- [9]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Mind Flay",
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
							["GUID"] = "TMW:icon:1a9kPVhaMuWr",
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "SPEED",
								}, -- [2]
								{
									["Type"] = "CASTING",
									["Name"] = "Mind Flay",
									["Level"] = 2,
								}, -- [3]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [4]
								{
									["Type"] = "CREATURETYPE",
									["Unit"] = "target",
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "SPEC",
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "SPELLCD",
									["Operator"] = "~=",
									["Name"] = "Mind Blast",
								}, -- [7]
								["n"] = 7,
							},
						}, -- [10]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Mind Blast",
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
							["RangeCheck"] = true,
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "MANA",
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
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [4]
								{
									["Type"] = "CREATURETYPE",
									["Unit"] = "target",
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "SPEC",
									["Level"] = 1,
								}, -- [6]
								["n"] = 6,
							},
						}, -- [11]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Shadow Word: Death",
							["GUID"] = "TMW:icon:1cI7Gl5Tx2q9",
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
									["Type"] = "HEALTH",
									["Checked"] = true,
									["Unit"] = "target",
									["Operator"] = "<=",
									["Name"] = "Shadow Word: Pain",
									["Level"] = 25,
								}, -- [1]
								{
									["Type"] = "CREATURETYPE",
									["Unit"] = "target",
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "SPEC",
									["Level"] = 1,
								}, -- [4]
								["n"] = 4,
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
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "mouseover",
							["Type"] = "buff",
							["Enabled"] = true,
							["Name"] = "Disease",
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Unit"] = "mouseover",
									["Name"] = "magi",
								}, -- [1]
								{
									["Type"] = "ALIVE",
									["Operator"] = "<",
									["Unit"] = "mouseover",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Unit"] = "mouseover",
									["Level"] = 2,
								}, -- [3]
								["n"] = 3,
							},
							["ManaCheck"] = true,
							["CustomTex"] = "528",
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
							["GUID"] = "TMW:icon:1cHVGCLeBnC9",
						}, -- [19]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "mouseover",
							["Type"] = "buff",
							["Name"] = "Magic",
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Unit"] = "mouseover",
									["Name"] = "magi",
								}, -- [1]
								{
									["Type"] = "ALIVE",
									["Operator"] = "<",
									["Unit"] = "mouseover",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Unit"] = "mouseover",
									["Level"] = 2,
								}, -- [3]
								["n"] = 3,
							},
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1a9ihU2QC18O",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks:Hide(0)]", -- [2]
									},
								},
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
							["Enabled"] = true,
						}, -- [20]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Shoot",
							["Conditions"] = {
								{
									["Type"] = "AUTOSPELL",
									["Name"] = "Shoot",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1a7jsvYu6Fu1",
							["CustomTex"] = "74178",
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
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Holy Nova",
							["GUID"] = "TMW:icon:1aA0rR5NF8ug",
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
									["Name"] = "xAOE(10)>1",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [26]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Smite",
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
							["GUID"] = "TMW:icon:1a7l2fmj178S",
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "LUA",
									["Name"] = "xBehindTarget()",
								}, -- [3]
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [4]
								{
									["Type"] = "CREATURETYPE",
									["Unit"] = "target",
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
							},
						}, -- [27]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Holy Fire",
							["GUID"] = "TMW:icon:1cHmgODPePq4",
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
									["Type"] = "MANA",
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "LUA",
									["Name"] = "xBehindTarget()",
								}, -- [3]
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [4]
								{
									["Type"] = "CREATURETYPE",
									["Unit"] = "target",
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
							},
						}, -- [28]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Archangel",
							["GUID"] = "TMW:icon:1cIUNzB8Z0C9",
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
									["Type"] = "BUFFSTACKS",
									["Name"] = "Evangelism",
									["Level"] = 5,
								}, -- [1]
								["n"] = 1,
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
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Inner Fire",
							["GUID"] = "TMW:icon:1a7lUEjXAASn",
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
									["Type"] = "BUFFDUR",
									["Name"] = "Inner Fire",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [41]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Power Word: Fortitude",
							["ManaCheck"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Power Word: Fortitude",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [42]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Shadow Word: Pain",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "mouseover",
									["Name"] = "Shadow Word: Pain",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "mouseover",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Unit"] = "mouseover",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "ALIVE",
									["Unit"] = "mouseover",
								}, -- [4]
								{
									["Type"] = "LUA",
									["Name"] = "xInRange(30,\"mouseover\")",
								}, -- [5]
								["n"] = 5,
							},
							["ManaCheck"] = true,
							["CustomTex"] = "47948",
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
							["GUID"] = "TMW:icon:1a7lUEjf6xOH",
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
							["Type"] = "item",
							["Enabled"] = true,
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905",
							["OnlyInBags"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 40,
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1a7lUElf_=Se",
							["CustomTex"] = "28491",
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
						}, -- [59]
						{
							["Type"] = "item",
							["Enabled"] = true,
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["OnlyInBags"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 65,
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1a7lUElnNLeF",
							["CustomTex"] = "6262",
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
					["Scale"] = 1.5,
					["TextureName"] = "Details Flat",
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
						{
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
					["Name"] = "OTHER PORTRAIT",
				}, -- [2]
				{
					["Point"] = {
						["y"] = -120,
						["x"] = -5.450076092640056e-05,
					},
					["Scale"] = 1.5,
					["TextureName"] = "Details Flat",
					["Locked"] = true,
					["OnlyInCombat"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1a7lUElf_=Se", -- [1]
								"TMW:icon:1a7lUElnNLeF", -- [2]
								"TMW:icon:1a9ihU2QC18O", -- [3]
								"TMW:icon:1cHVGCLeBnC9", -- [4]
								"TMW:icon:1a8KSxK3rF0S", -- [5]
								"TMW:icon:1a7lUEjXAASn", -- [6]
								"TMW:icon:1cI7GiRvWhaO", -- [7]
								"TMW:icon:1cIUNzB8Z0C9", -- [8]
								"TMW:icon:1cI7Gl5Tx2q9", -- [9]
								"TMW:icon:1a7jsvYwXc4j", -- [10]
								"TMW:icon:1a9kNk57eWOn", -- [11]
								"TMW:icon:1a7l2fmgZwCv", -- [12]
								"TMW:icon:1a9kPVhaMuWr", -- [13]
								"TMW:icon:1cHmgODPePq4", -- [14]
								"TMW:icon:1a7l2fmj178S", -- [15]
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
							["Sort"] = -1,
							["Type"] = "buff",
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
							["Enabled"] = true,
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
				}, -- [3]
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
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1a7lUElf_=Se", -- [1]
								"TMW:icon:1a7lUElnNLeF", -- [2]
								"TMW:icon:1a9ihU2QC18O", -- [3]
								"TMW:icon:1cHVGCLeBnC9", -- [4]
								"TMW:icon:1a8KSxK3rF0S", -- [5]
								"TMW:icon:1a7lUEjXAASn", -- [6]
								"TMW:icon:1cI7GiRvWhaO", -- [7]
								"TMW:icon:1cIUNzB8Z0C9", -- [8]
								"TMW:icon:1cI7Gl5Tx2q9", -- [9]
								"TMW:icon:1a7jsvYwXc4j", -- [10]
								"TMW:icon:1a9kNk57eWOn", -- [11]
								"TMW:icon:1a7l2fmgZwCv", -- [12]
								"TMW:icon:1a9kPVhaMuWr", -- [13]
								"TMW:icon:1cHmgODPePq4", -- [14]
								"TMW:icon:1a7l2fmj178S", -- [15]
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
							["Sort"] = -1,
							["Type"] = "buff",
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
							["Enabled"] = true,
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
				}, -- [5]
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
			["NumGroups"] = 6,
			["TextureName"] = "xVerminClean",
			["Version"] = 102601,
			["Locked"] = true,
		},
		["WARLOCK"] = {
			["Locked"] = true,
			["NumGroups"] = 5,
			["Version"] = 102000,
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
						{
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
						{
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
							["GUID"] = "TMW:icon:1bQrS=hFpnKL",
							["Type"] = "item",
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905",
							["OnlyInBags"] = true,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 20,
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
							["GUID"] = "TMW:icon:1bQr1e3qNBqn",
							["Type"] = "item",
							["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 30,
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
								"TMW:icon:1bQrS=hFpnKL", -- [1]
								"TMW:icon:1bQr1e3qNBqn", -- [2]
								"TMW:icon:1V6ky7UjmQN=", -- [3]
								"TMW:icon:1V6ky7UreCKN", -- [4]
								"TMW:icon:1V6ky7Uy=NmE", -- [5]
								"TMW:icon:1bQrNpYw7daN", -- [6]
								"TMW:icon:1bQrOzjColi_", -- [7]
								"TMW:icon:1YXBfKWFOMGr", -- [8]
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
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Name"] = "Warlock Spells",
					["Icons"] = {
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
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [2]
								{
									["Type"] = "SPEED",
								}, -- [3]
								["n"] = 3,
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
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1V6ky7UjmQN=",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Immolate",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 0.6,
									["Name"] = "Immolate",
									["Operator"] = "<=",
								}, -- [2]
								{
									["Type"] = "SPEED",
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
							["GUID"] = "TMW:icon:1V6ky7UreCKN",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Corruption",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 0.6,
									["Name"] = "Corruption",
									["Operator"] = "<=",
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
						}, -- [3]
						{
							["GUID"] = "TMW:icon:1bQrNpYw7daN",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Corruption",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Unit"] = "mouseover",
									["Type"] = "EXISTS",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "mouseover",
									["Level"] = 0.6,
									["Name"] = "Corruption",
									["Operator"] = "<=",
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
						}, -- [4]
						{
							["GUID"] = "TMW:icon:1V6ky7Uy=NmE",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Curse of Agony",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 0.6,
									["Name"] = "Curse of Agony",
									["Operator"] = "<=",
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
						}, -- [5]
						{
							["GUID"] = "TMW:icon:1bQrOzjColi_",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Curse of Agony",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "mouseover",
									["Level"] = 0.6,
									["Name"] = "Curse of Agony",
									["Operator"] = "<=",
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
					["Scale"] = 1,
					["Columns"] = 20,
					["Alpha"] = 0,
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
								"TMW:icon:1bQrS=hFpnKL", -- [1]
								"TMW:icon:1bQr1e3qNBqn", -- [2]
								"TMW:icon:1V6ky7UjmQN=", -- [3]
								"TMW:icon:1V6ky7UreCKN", -- [4]
								"TMW:icon:1V6ky7Uy=NmE", -- [5]
								"TMW:icon:1bQrNpYw7daN", -- [6]
								"TMW:icon:1bQrOzjColi_", -- [7]
								"TMW:icon:1YXBfKWFOMGr", -- [8]
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
		["Asjrdfsad - Golemagg"] = {
			["Version"] = 102601,
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
							["Conditions"] = {
								{
									["Name"] = "local blood, frost, unholy, death = xRuneCount()\nif blood+death==0 then return true end\nreturn false",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Frost Fever",
									["PrtsBefore"] = 1,
									["Level"] = 3,
									["Operator"] = "<",
									["Unit"] = "target",
								}, -- [2]
								{
									["Level"] = 3,
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Blood Plague",
									["Operator"] = "<",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
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
							["GCDAsUnusable"] = true,
							["Type"] = "cooldown",
							["Name"] = "Horn of Winter",
							["Enabled"] = true,
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
							["Type"] = "reactive",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Rune Strike",
							["RangeCheck"] = true,
							["Enabled"] = true,
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
							["Name"] = "Anti-Magic Shell",
							["GUID"] = "TMW:icon:1ZGiKdRg6oif",
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
						}, -- [5]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Death and Decay",
							["GUID"] = "TMW:icon:1ZXaz0p3YpOm",
							["Conditions"] = {
								{
									["Name"] = "xAOE(10) >= 4",
									["Type"] = "LUA",
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
						}, -- [6]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Unbreakable Armor",
							["GUID"] = "TMW:icon:1ZYXYoMjwNSI",
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
									["Operator"] = ">",
									["Unit"] = "target",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Obliterate",
							["GUID"] = "TMW:icon:1ZYXYoMoeHKG",
							["Conditions"] = {
								{
									["Level"] = 2,
									["Type"] = "SPEC",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Blood Plague",
									["Operator"] = "~=",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Frost Fever",
									["Operator"] = "~=",
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
									["Level"] = 7.5,
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Frost Fever",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Operator"] = ">",
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
									["Level"] = 2,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [10]
								["n"] = 10,
							},
							["ManaCheck"] = true,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Frost Strike",
							["GUID"] = "TMW:icon:1ZYXYoMqCvyD",
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
									["Level"] = 1.5,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [4]
								{
									["Level"] = 1,
									["Type"] = "SPEC",
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
						}, -- [10]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Howling Blast",
							["GUID"] = "TMW:icon:1ZYXYoMroYer",
							["Conditions"] = {
								{
									["Level"] = 1,
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
									["Operator"] = ">",
									["Name"] = "local blood, frost, unholy, death = xRuneCount()\n\nif frost>0 and unholy>0 then return true end\nif frost>0 and death>0 and blood+death>1 then return true end\nif unholy>0 and death>0 and blood+death>1 then return true end\n\nreturn false",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Howling Blast",
									["Level"] = 2,
									["PrtsAfter"] = 1,
									["Operator"] = "<",
								}, -- [6]
								["n"] = 6,
							},
							["ManaCheck"] = true,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Plague Strike",
							["GUID"] = "TMW:icon:1YYs1I2bCNGy",
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
							["Name"] = "Icy Touch",
							["GUID"] = "TMW:icon:1YYs1I2c_Meo",
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
							["Name"] = "Heart Strike",
							["GUID"] = "TMW:icon:1YYv3MYeNeSM",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Frost Fever",
									["Operator"] = "~=",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Blood Plague",
									["Operator"] = "~=",
									["Unit"] = "target",
								}, -- [2]
								{
									["Level"] = 2,
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
									["Level"] = 75,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
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
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [23]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Death Coil",
							["GUID"] = "TMW:icon:1YZamy7DqjiW",
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
							["Name"] = "Death Strike",
							["GUID"] = "TMW:icon:1YaXVCdLMBa8",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["PrtsBefore"] = 1,
									["Name"] = "Frost Fever",
									["Operator"] = "~=",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Blood Plague",
									["Operator"] = "~=",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "SPEC",
									["PrtsAfter"] = 1,
									["Level"] = 2,
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
									["Color"] = "ffffffff",
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [25]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blood Strike",
							["GUID"] = "TMW:icon:1YbFYj2F1X0v",
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
							["GUID"] = "TMW:icon:1YbGRIr4FVqp",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 65,
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
						}, -- [27]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blood Boil",
							["GUID"] = "TMW:icon:1Z3Dak8Afvm1",
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "xAOE(10) > 2",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Level"] = 2,
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
									["Level"] = 75,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = ">",
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
						}, -- [28]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Pestilence",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Frost Fever",
									["PrtsBefore"] = 2,
									["Level"] = 7.5,
									["Operator"] = "<=",
									["Unit"] = "target",
								}, -- [1]
								{
									["Level"] = 7.5,
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Blood Plague",
									["Operator"] = "<=",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Frost Fever",
									["Operator"] = "~=",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Blood Plague",
									["Operator"] = "~=",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Chains of Ice",
							["GUID"] = "TMW:icon:1ZMyzzwKlj0c",
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
						}, -- [30]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mark of Blood",
							["GUID"] = "TMW:icon:1Za8YRwFhvat",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 60,
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
									["Level"] = 2,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Frost Strike",
							["GUID"] = "TMW:icon:1a1Aq1Tw_3ih",
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Name"] = "Obliterate",
									["PrtsBefore"] = 1,
									["Level"] = 1,
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
									["Type"] = "RUNIC_POWER_ABS",
									["Level"] = 90,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [4]
								{
									["Level"] = 1,
									["Type"] = "SPEC",
								}, -- [5]
								["n"] = 5,
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
					},
					["Point"] = {
						["y"] = -20.00000522536274,
						["x"] = -229.9999934656047,
					},
					["Name"] = "Other",
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
								"TMW:icon:1YYs1I2bCNGy", -- [7]
								"TMW:icon:1YYs1I2c_Meo", -- [8]
								"TMW:icon:1ZYXYoMroYer", -- [9]
								"TMW:icon:1a1Aq1Tw_3ih", -- [10]
								"TMW:icon:1ZYXYoMoeHKG", -- [11]
								"TMW:icon:1YbFYj2F1X0v", -- [12]
								"TMW:icon:1YZamy7DqjiW", -- [13]
								"TMW:icon:1YaXVCdLMBa8", -- [14]
								"TMW:icon:1YYv3MYeNeSM", -- [15]
								"TMW:icon:1Z3Dak8Afvm1", -- [16]
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
								"TMW:icon:1YYs1I2bCNGy", -- [7]
								"TMW:icon:1YYs1I2c_Meo", -- [8]
								"TMW:icon:1ZYXYoMroYer", -- [9]
								"TMW:icon:1a1Aq1Tw_3ih", -- [10]
								"TMW:icon:1ZYXYoMoeHKG", -- [11]
								"TMW:icon:1YbFYj2F1X0v", -- [12]
								"TMW:icon:1YZamy7DqjiW", -- [13]
								"TMW:icon:1YaXVCdLMBa8", -- [14]
								"TMW:icon:1YYv3MYeNeSM", -- [15]
								"TMW:icon:1Z3Dak8Afvm1", -- [16]
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
								"TMW:icon:1ZYXYoMjwNSI", -- [9]
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
			["Version"] = 102601,
			["NumGroups"] = 5,
		},
		["DRUID"] = {
			["Locked"] = true,
			["Version"] = 102601,
			["NumGroups"] = 5,
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
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 2,
									["Type"] = "STANCE",
									["Name"] = "Bear Form; Dire Bear Form",
								}, -- [1]
								{
									["Name"] = "not (xAOE(10) > 1)",
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
									["Type"] = "LUA",
									["Name"] = "xInRange(8)",
									["Level"] = 8,
									["Unit"] = "target",
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
							["ManaCheck"] = true,
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
									["Name"] = "xAOE(10) > 1",
								}, -- [2]
								{
									["PrtsBefore"] = 1,
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "xAOE(10) > 2",
								}, -- [4]
								{
									["Type"] = "RAGE_ABS",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 40,
									["Operator"] = ">=",
								}, -- [5]
								{
									["Name"] = "Maul",
									["Type"] = "CURRENTSPELL",
								}, -- [6]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "xAOE(10) > 1",
								}, -- [7]
								["n"] = 7,
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
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Barkskin",
							["ManaCheck"] = true,
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
							["GUID"] = "TMW:icon:1Z69muUIlNiY",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["PrtsBefore"] = 1,
									["Level"] = 6,
									["Unit"] = "target",
									["Operator"] = "<=",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Operator"] = "<=",
									["Level"] = 6,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["PrtsBefore"] = 1,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Trauma",
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Trauma",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["Level"] = 5,
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
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
							["GUID"] = "TMW:icon:1Z6o5cxM6Qma",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Bear Form; Dire Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["PrtsBefore"] = 1,
									["Level"] = 6,
									["Operator"] = "<=",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["Operator"] = "<=",
									["Level"] = 6,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["PrtsBefore"] = 1,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Trauma",
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "BUFFDUR",
									["AndOr"] = "OR",
									["Name"] = "Berserk",
									["Operator"] = "~=",
								}, -- [5]
								{
									["Type"] = "RAGE",
									["AndOr"] = "OR",
									["Level"] = 50,
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [6]
								["n"] = 6,
							},
							["ManaCheck"] = true,
							["States"] = {
								{
									["Name"] = "Bear Form; Dire Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								nil, -- [2]
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
							["Type"] = "cooldown",
							["Name"] = "Berserk",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "STANCE",
									["Name"] = "Cat Form; Dire Bear Form; Bear Form",
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
									["PrtsAfter"] = 2,
									["Operator"] = "~=",
								}, -- [3]
								{
									["PrtsBefore"] = 1,
									["Type"] = "STANCE",
									["Name"] = "Bear Form; Dire Bear Form",
									["AndOr"] = "OR",
								}, -- [4]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "xAOE(10) > 2",
								}, -- [5]
								["n"] = 5,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Savage Roar",
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "COMBO",
									["Level"] = 1,
									["Operator"] = ">",
								}, -- [1]
								{
									["Name"] = "Savage Roar",
									["Type"] = "BUFFDUR",
								}, -- [2]
								{
									["Type"] = "HEALTH_ABS",
									["Operator"] = ">",
									["Level"] = 10000,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "COMBO",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 3,
									["Operator"] = ">=",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 12,
									["Name"] = "Rip",
									["Operator"] = ">",
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Level"] = 12,
									["Name"] = "Savage Roar",
									["Operator"] = "<",
								}, -- [6]
								{
									["Type"] = "HEALTH_ABS",
									["Unit"] = "target",
									["Level"] = 10000,
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [7]
								["n"] = 7,
							},
							["GUID"] = "TMW:icon:1ZamSC33bwu9",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Faerie Fire (Feral)",
							["GUID"] = "TMW:icon:1YatF3BT0RKW",
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
						}, -- [10]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Frenzied Regeneration",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 50,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1bRqDvw9Jzmr",
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
									["Name"] = "not xBehindTarget()",
									["Type"] = "LUA",
								}, -- [3]
								["n"] = 3,
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
							["Name"] = "Lacerate",
							["ManaCheck"] = true,
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
									["Name"] = "not (xAOE(10) > 1)",
									["Type"] = "LUA",
								}, -- [6]
								["n"] = 6,
							},
							["GUID"] = "TMW:icon:1ZJNiKMfEYOM",
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
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Name"] = "xBehindTarget()",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Type"] = "COMBO",
									["Level"] = 5,
									["Operator"] = "<",
								}, -- [3]
								{
									["PrtsBefore"] = 1,
									["Type"] = "COMBO",
									["Level"] = 5,
									["AndOr"] = "OR",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 5,
									["Name"] = "Rip",
									["Operator"] = ">",
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Savage Roar",
									["Level"] = 10,
									["PrtsAfter"] = 1,
									["Operator"] = ">",
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
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [23]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Rake",
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
									["Name"] = "xAOE(10) <= 4",
									["Type"] = "LUA",
								}, -- [4]
								["n"] = 4,
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
							["Name"] = "Rip",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Level"] = 5,
								}, -- [2]
								{
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Rip",
									["Unit"] = "target",
								}, -- [3]
								{
									["Operator"] = ">",
									["Level"] = 10000,
									["Type"] = "HEALTH_ABS",
									["Unit"] = "target",
								}, -- [4]
								["n"] = 4,
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
									["Unit"] = "target",
									["Level"] = 10000,
									["Type"] = "HEALTH_ABS",
									["Operator"] = "<=",
								}, -- [2]
								{
									["Type"] = "COMBO",
									["Level"] = 3,
									["Operator"] = ">",
								}, -- [3]
								["n"] = 3,
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
							["GUID"] = "TMW:icon:1Z3Dak8Afvm1",
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
						}, -- [28]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Tiger's Fury",
							["ManaCheck"] = true,
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
								{
									["Type"] = "ENERGY_ABS",
									["Level"] = 40,
									["Operator"] = "<",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1Z4qW_DgW_ek",
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
							["Name"] = "Shred",
							["GUID"] = "TMW:icon:1ZeQiVw1QEaz",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Name"] = "xBehindTarget()",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Clearcasting",
									["Operator"] = "~=",
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
						}, -- [30]
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
									["Type"] = "COMBO",
									["Level"] = 3,
									["Operator"] = ">",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 16,
									["Name"] = "Rip",
									["Operator"] = ">",
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Savage Roar",
									["Operator"] = "~=",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1ZrL8pFVd_Ki",
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
						}, -- [31]
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
									["Type"] = "COMBO",
									["Level"] = 2,
									["Operator"] = ">",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 12,
									["Name"] = "Rip",
									["Operator"] = ">",
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Savage Roar",
									["Operator"] = "~=",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1ZrL8pFXlKGx",
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
						}, -- [32]
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
									["Type"] = "COMBO",
									["Level"] = 1,
									["Operator"] = ">",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 8,
									["Name"] = "Rip",
									["Operator"] = ">",
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Savage Roar",
									["Operator"] = "~=",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1ZrL8pFaHSqU",
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
							["Name"] = "Cower",
							["GUID"] = "TMW:icon:1YawP4LcafCX",
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
									["Alpha"] = 0,
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
								{
									["Name"] = "None",
									["Type"] = "STANCE",
								}, -- [2]
								["n"] = 2,
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
									["Alpha"] = 0,
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
								["n"] = 2,
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
						{
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
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Name"] = "Other",
					["Point"] = {
						["y"] = -20.00000522536274,
						["x"] = -229.9999934656047,
					},
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1Z3Dak8Afvm1", -- [1]
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
								{
									["Type"] = "STANCE",
									["Name"] = "Tree of Life",
									["AndOr"] = "OR",
								}, -- [6]
								["n"] = 6,
							},
							["Icons"] = {
								"TMW:icon:1ZM_VlmD27Ka", -- [1]
								"TMW:icon:1ZB9ydEakN46", -- [2]
								"TMW:icon:1ZBi1G1Ik=8q", -- [3]
								"TMW:icon:1ZBi1G1LSN04", -- [4]
								"TMW:icon:1V6noP8ARoel", -- [5]
								"TMW:icon:1Z69muUKqqKC", -- [6]
								"TMW:icon:1bRqDvw9Jzmr", -- [7]
								"TMW:icon:1YatF3BT0RKW", -- [8]
								"TMW:icon:1ZeQiVw1QEaz", -- [9]
								"TMW:icon:1ZamSC33bwu9", -- [10]
								"TMW:icon:1YbFYj2F1X0v", -- [11]
								"TMW:icon:1ZrL8pFVd_Ki", -- [12]
								"TMW:icon:1ZrL8pFXlKGx", -- [13]
								"TMW:icon:1ZrL8pFaHSqU", -- [14]
								"TMW:icon:1YaXVCdLMBa8", -- [15]
								"TMW:icon:1Z6o5cxM6Qma", -- [16]
								"TMW:icon:1Z69muUIlNiY", -- [17]
								"TMW:icon:1ZJNiKMfEYOM", -- [18]
								"TMW:icon:1Z4qW_DgW_ek", -- [19]
								"TMW:icon:1YZamy7DqjiW", -- [20]
								"TMW:icon:1TeVAjjavXC6", -- [21]
								"TMW:icon:1V6lsULwY3_Y", -- [22]
								"TMW:icon:1YYs1I2bCNGy", -- [23]
								"TMW:icon:1YYv3MYeNeSM", -- [24]
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
									["Name"] = "not IsAltKeyDown();",
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
								{
									["Type"] = "STANCE",
									["Name"] = "Tree of Life",
									["AndOr"] = "OR",
								}, -- [6]
								["n"] = 6,
							},
							["Icons"] = {
								"TMW:icon:1ZM_VlmD27Ka", -- [1]
								"TMW:icon:1ZB9ydEakN46", -- [2]
								"TMW:icon:1ZBi1G1Ik=8q", -- [3]
								"TMW:icon:1ZBi1G1LSN04", -- [4]
								"TMW:icon:1V6noP8ARoel", -- [5]
								"TMW:icon:1Z69muUKqqKC", -- [6]
								"TMW:icon:1bRqDvw9Jzmr", -- [7]
								"TMW:icon:1YatF3BT0RKW", -- [8]
								"TMW:icon:1ZeQiVw1QEaz", -- [9]
								"TMW:icon:1ZamSC33bwu9", -- [10]
								"TMW:icon:1YbFYj2F1X0v", -- [11]
								"TMW:icon:1ZrL8pFVd_Ki", -- [12]
								"TMW:icon:1ZrL8pFXlKGx", -- [13]
								"TMW:icon:1ZrL8pFaHSqU", -- [14]
								"TMW:icon:1YaXVCdLMBa8", -- [15]
								"TMW:icon:1Z6o5cxM6Qma", -- [16]
								"TMW:icon:1Z69muUIlNiY", -- [17]
								"TMW:icon:1ZJNiKMfEYOM", -- [18]
								"TMW:icon:1Z4qW_DgW_ek", -- [19]
								"TMW:icon:1YZamy7DqjiW", -- [20]
								"TMW:icon:1TeVAjjavXC6", -- [21]
								"TMW:icon:1V6lsULwY3_Y", -- [22]
								"TMW:icon:1YYs1I2bCNGy", -- [23]
								"TMW:icon:1YYv3MYeNeSM", -- [24]
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
		},
		["SHAMAN"] = {
			["Locked"] = true,
			["Version"] = 102601,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Scale"] = 1,
					["Rows"] = 3,
					["Alpha"] = 0,
					["Name"] = "SHAMAN SPELLS",
					["Locked"] = true,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Lightning Bolt",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEED",
								}, -- [1]
								{
									["Name"] = "not xInRange(30)",
									["Type"] = "LUA",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
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
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Flame Shock",
							["ManaCheck"] = true,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Earth Shock",
							["GUID"] = "TMW:icon:1a3BehKNMJeZ",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Fire Nova",
							["ManaCheck"] = true,
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
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "mouseover",
							["Name"] = "Poison; Disease",
							["GUID"] = "TMW:icon:1a3BehMeWjaB",
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
							["GUID"] = "TMW:icon:1ZhjptZBAxKW",
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
					["Alpha"] = 0,
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
								"TMW:icon:1Zi_P9NDuquZ", -- [7]
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
								"TMW:icon:1Zi_P9NDuquZ", -- [7]
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
			["NumGroups"] = 5,
		},
		["PALADIN"] = {
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Righteous Fury",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "Righteous Fury",
								}, -- [1]
								["n"] = 1,
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
									["Alpha"] = 0,
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
									["Level"] = 90,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "Divine Plea",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1bMBP=Ir0TOf",
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
						}, -- [4]
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
								{
									["Name"] = "IsUsableSpell(48788)",
									["Type"] = "LUA",
								}, -- [3]
								["n"] = 3,
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
						}, -- [5]
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
						}, -- [6]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Sacred Shield",
							["GUID"] = "TMW:icon:1bP6ZsEhWhyX",
							["Conditions"] = {
								{
									["Name"] = "Sacred Shield",
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
						}, -- [7]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Word of Glory",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HOLY_POWER",
									["Name"] = "Sacred Shield",
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "HEALTH",
									["Level"] = 80,
									["Operator"] = "<=",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1cGDgHveUk4V",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Crusader Strike",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "xAOE(10) == 1 or not IsSpellKnown(53595)",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
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
						}, -- [11]
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
						}, -- [12]
						{
							["GUID"] = "TMW:icon:1Z6tL7hXaSCZ",
							["Type"] = "cooldown",
							["Name"] = "Exorcism",
							["RangeCheck"] = true,
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
							["Type"] = "cooldown",
							["Name"] = "Seal of Truth",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Level"] = 3,
									["Name"] = "Seal of Truth",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Name"] = "Seal of Insight",
									["Type"] = "BUFFDUR",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1ZkmyynlJgaL",
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
							["Name"] = "Avenger's Shield",
							["GUID"] = "TMW:icon:1ZkmyyWWPpGC",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Unit"] = "mouseover",
								}, -- [1]
								{
									["Name"] = "xInRange(30,\"mouseover\")",
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
						}, -- [21]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Hammer of the Righteous",
							["GUID"] = "TMW:icon:1ZkmyyWS_emA",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Level"] = 0.6,
									["Name"] = "Hammer of the Righteous",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [2]
								{
									["Name"] = "xAOE(10)>1",
									["Type"] = "LUA",
								}, -- [3]
								["n"] = 3,
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
						}, -- [22]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shield of the Righteous",
							["GUID"] = "TMW:icon:1ZkmyyWUmDSs",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Level"] = 0.6,
									["Name"] = "Shield of Righteousness",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [2]
								{
									["Type"] = "HOLY_POWER",
									["Level"] = 3,
								}, -- [3]
								["n"] = 3,
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
						}, -- [23]
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
								{
									["Type"] = "SPELLCD",
									["Level"] = 1.1,
									["Name"] = "Holy Shield",
									["Operator"] = "<=",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1YXd9eWHzTSH",
							["States"] = {
								{
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								{
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
							["ManaCheck"] = true,
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
									["Name"] = "xInRange(8)",
									["Type"] = "LUA",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1ZkmyyWX_u4d",
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
								{
									["Type"] = "SPEED",
								}, -- [4]
								["n"] = 4,
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
						}, -- [41]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Judgement",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Level"] = 1.1,
									["Name"] = "Judgement",
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1bMBoWa6os4j",
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
							["ManaCheck"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
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
									["Alpha"] = 0,
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
								{
									["Name"] = "IsUsableSpell(498)",
									["Type"] = "LUA",
								}, -- [3]
								["n"] = 3,
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
							["States"] = {
								{
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
							["GUID"] = "TMW:icon:1ZmhsoGZsuaJ",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 50,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "6262",
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
							["OnlyInBags"] = true,
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
								["n"] = 4,
							},
							["Icons"] = {
								"TMW:icon:1ZmhsoGZsuaJ", -- [1]
								"TMW:icon:1ZmhsoDa4SWt", -- [2]
								"TMW:icon:1ZkmyynlJgaL", -- [3]
								"TMW:icon:1ZmhO7mqKue=", -- [4]
								"TMW:icon:1cGDgHveUk4V", -- [5]
								"TMW:icon:1Z6tL7hZeq4n", -- [6]
								"TMW:icon:1ZwdlWxY789W", -- [7]
								"TMW:icon:1Z6tL7hbgPqi", -- [8]
								"TMW:icon:1ZkmyyWWPpGC", -- [9]
								"TMW:icon:1ZkmyyWZapS_", -- [10]
								"TMW:icon:1Z6tL7hfkyqu", -- [11]
								"TMW:icon:1ZkmyyWX_u4d", -- [12]
								"TMW:icon:1ZkmyyWUmDSs", -- [13]
								"TMW:icon:1bMBP=Ir0TOf", -- [14]
								"TMW:icon:1YawP4LcafCX", -- [15]
								"TMW:icon:1ZkmyyWS_emA", -- [16]
								"TMW:icon:1bMBoWa6os4j", -- [17]
								"TMW:icon:1YXd9eWHzTSH", -- [18]
								"TMW:icon:1bP6ZsEhWhyX", -- [19]
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
								["n"] = 4,
							},
							["Icons"] = {
								"TMW:icon:1ZmhsoGZsuaJ", -- [1]
								"TMW:icon:1ZmhsoDa4SWt", -- [2]
								"TMW:icon:1ZkmyynlJgaL", -- [3]
								"TMW:icon:1ZmhO7mqKue=", -- [4]
								"TMW:icon:1cGDgHveUk4V", -- [5]
								"TMW:icon:1Z6tL7hZeq4n", -- [6]
								"TMW:icon:1ZkmyyWZapS_", -- [7]
								"TMW:icon:1ZwdlWxY789W", -- [8]
								"TMW:icon:1Z6tL7hbgPqi", -- [9]
								"TMW:icon:1ZkmyyWWPpGC", -- [10]
								"TMW:icon:1Z6tL7hfkyqu", -- [11]
								"TMW:icon:1ZkmyyWX_u4d", -- [12]
								"TMW:icon:1ZkmyyWUmDSs", -- [13]
								"TMW:icon:1bMBP=Ir0TOf", -- [14]
								"TMW:icon:1YawP4LcafCX", -- [15]
								"TMW:icon:1ZkmyyWS_emA", -- [16]
								"TMW:icon:1bMBoWa6os4j", -- [17]
								"TMW:icon:1YXd9eWHzTSH", -- [18]
								"TMW:icon:1bP6ZsEhWhyX", -- [19]
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
			["Version"] = 102601,
		},
	},
}
