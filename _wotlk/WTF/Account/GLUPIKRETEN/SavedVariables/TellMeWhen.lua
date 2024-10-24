
TellMeWhenDB = {
	["Version"] = 11001001,
	["profileKeys"] = {
		["Mxzq - Golemagg"] = "HUNTER",
		["Vermina - Golemagg"] = "PALADIN",
		["Mxyz - Golemagg"] = "PRIEST",
		["Battlearm - Golemagg"] = "DEATHKNIGHT",
		["Battitude - Golemagg"] = "ROGUE",
		["Kaonac - Jin'do"] = "PRIEST",
		["Battledog - Gehennas"] = "WARRIOR",
		["Battlemoo - Golemagg"] = "DRUID",
		["Tandaram - Jin'do"] = "WARRIOR",
		["Wells - Jin'do"] = "DRUID",
		["Poklopac - Dreadnaught"] = "HUNTER",
		["Moolatz - Golemagg"] = "DRUID",
		["Mxyzptlk - Golemagg"] = "WARLOCK",
		["Asjrdfsad - Golemagg"] = "PRIEST",
		["Tudum - Ashbringer"] = "WARRIOR",
		["Augustin - Golemagg"] = "MAGE",
		["Tudum - Jin'do"] = "WARRIOR",
		["Provokator - Jin'do"] = "HUNTER",
		["Vermin - Golemagg"] = "WARRIOR",
		["Pitchwise - Ashbringer"] = "SHAMAN",
		["Poklopac - Mirage Raceway"] = "HUNTER",
		["Miqa - Golemagg"] = "PRIEST",
		["Battlearm - Gehennas"] = "WARRIOR",
		["Handrmandr - Golemagg"] = "PALADIN",
		["Tadibey - Golemagg"] = "SHAMAN",
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
		["NumGroups"] = 1,
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
		["Groups"] = {
			{
				["Scale"] = 1,
				["Locked"] = true,
				["GUID"] = "TMW:group:1cKF2JRSFFaW",
				["Columns"] = 5,
				["Alpha"] = 0,
				["Name"] = "SHARED",
				["Point"] = {
					["relativeTo"] = "TellMeWhen_Group1",
					["point"] = "TOPLEFT",
					["relativePoint"] = "TOPRIGHT",
					["x"] = 40,
				},
				["Icons"] = {
					{
						["OnlyEquipped"] = true,
						["Type"] = "item",
						["Enabled"] = true,
						["Name"] = "Battlemaster's Resolve",
						["OnlyInBags"] = true,
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
						["Conditions"] = {
							{
								["Type"] = "HEALTH",
								["Operator"] = "<=",
								["Level"] = 55,
							}, -- [1]
							["n"] = 1,
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
						["Type"] = "buff",
						["Enabled"] = true,
						["Name"] = "Kalytha's Haunted Locket",
						["Conditions"] = {
							{
								["Type"] = "LUA",
								["Name"] = "select(1, C_Container.GetItemCooldown(68806)) == 0",
							}, -- [1]
							{
								["Type"] = "BUFFDUR",
								["Name"] = "Iron Boot Flask",
							}, -- [2]
							{
								["Type"] = "LOC_ZONE",
								["Name"] = "Old Hillsbrad Foothills",
								["Level"] = 1,
							}, -- [3]
							["n"] = 3,
						},
						["GUID"] = "TMW:icon:1cJVovwBE2GS",
						["CustomTex"] = "Interface/Icons/item_icecrownnecklaced",
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
						["Type"] = "item",
						["Enabled"] = true,
						["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011; 19013, 9421, 19012, 5510, 19011, 19010, 19008, 19009, 5509, 5511, 19006, 19007, 5512, 19005, 19004",
						["OnlyInBags"] = true,
						["Conditions"] = {
							{
								["Type"] = "HEALTH",
								["Operator"] = "<=",
								["Level"] = 50,
							}, -- [1]
							["n"] = 1,
						},
						["GUID"] = "TMW:icon:1ZmhsoGZsuaJ",
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
					}, -- [4]
					{
						["Type"] = "item",
						["Enabled"] = true,
						["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905; 57191; 57099",
						["OnlyInBags"] = true,
						["Conditions"] = {
							{
								["Type"] = "HEALTH",
								["Operator"] = "<=",
								["Level"] = 40,
							}, -- [1]
							["n"] = 1,
						},
						["GUID"] = "TMW:icon:1ZmhsoDa4SWt",
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
					}, -- [5]
				},
			}, -- [1]
		},
	},
	["profiles"] = {
		["HUNTER"] = {
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
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
							["ManaCheck"] = true,
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
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
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
									["Type"] = "EXISTS",
									["Unit"] = "pet",
								}, -- [1]
								{
									["Type"] = "ALIVE",
									["Unit"] = "pet",
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
							["GUID"] = "TMW:icon:1X=OmHlbqz67",
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
									["Type"] = "EXISTS",
									["Unit"] = "pet",
								}, -- [3]
								{
									["Type"] = "ALIVE",
									["Unit"] = "pet",
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
									["Type"] = "EXISTS",
									["Unit"] = "focus",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["AndOr"] = "OR",
									["Unit"] = "pet",
								}, -- [2]
								{
									["Name"] = "Misdirection",
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
					["Locked"] = true,
					["Point"] = {
						["y"] = -4.996173281900221,
						["x"] = -0.0002605930177353105,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Alpha"] = 0,
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
								"TMW:icon:1cJVovwBE2GS", -- [5]
								"TMW:icon:1ZmhsoGZsuaJ", -- [6]
								"TMW:icon:1ZmhsoDa4SWt", -- [7]
								"TMW:icon:1ZDRwPNRMoWc", -- [8]
								"TMW:icon:1ZDQ16jrgNie", -- [9]
								"TMW:icon:1TeVAjjavXC6", -- [10]
								"TMW:icon:1ZNfjO2NI8Ga", -- [11]
								"TMW:icon:1TeVAjjXQ0WB", -- [12]
								"TMW:icon:1ZdATsSrLd8x", -- [13]
								"TMW:icon:1ZdATsSuWeuC", -- [14]
								"TMW:icon:1YS2u64Alj4P", -- [15]
								"TMW:icon:1V6lsULwY3_Y", -- [16]
								"TMW:icon:1YS2u64Csf0H", -- [17]
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
								"TMW:icon:1cJVovwBE2GS", -- [5]
								"TMW:icon:1ZmhsoGZsuaJ", -- [6]
								"TMW:icon:1ZmhsoDa4SWt", -- [7]
								"TMW:icon:1ZDRwPNRMoWc", -- [8]
								"TMW:icon:1ZDQ16jrgNie", -- [9]
								"TMW:icon:1TeVAjjavXC6", -- [10]
								"TMW:icon:1ZNfjO2NI8Ga", -- [11]
								"TMW:icon:1TeVAjjXQ0WB", -- [12]
								"TMW:icon:1ZdATsSrLd8x", -- [13]
								"TMW:icon:1ZdATsSuWeuC", -- [14]
								"TMW:icon:1YS2u64Alj4P", -- [15]
								"TMW:icon:1V6lsULwY3_Y", -- [16]
								"TMW:icon:1YS2u64Csf0H", -- [17]
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
					["Columns"] = 20,
					["Scale"] = 1,
					["Rows"] = 3,
					["Alpha"] = 0,
					["Name"] = "SPELLS",
					["Locked"] = true,
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
							["GUID"] = "TMW:icon:1TWZdpV26rm5",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Demoralizing Shout",
							["Enabled"] = true,
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
							["GUID"] = "TMW:icon:1Xrn34GriOqy",
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
									["Type"] = "RAGE_ABS",
									["Level"] = 40,
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
									["PrtsAfter"] = 2,
									["Type"] = "RAGE_ABS",
									["Name"] = "Defensive Stance",
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
									["Type"] = "SPELLCD",
									["Level"] = 0.6,
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
									["Operator"] = ">",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Unit"] = "target",
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
									["Type"] = "SPELLCD",
									["Level"] = 0.6,
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
							["Name"] = "Thunder Clap",
							["Unit"] = "target",
							["BuffOrDebuff"] = "HARMFUL",
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
									["Name"] = "xRend()",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Type"] = "LUA",
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
							["GUID"] = "TMW:icon:1Z55tRw3mJGc",
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
							["ManaCheck"] = true,
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
									["PrtsAfter"] = 1,
									["Type"] = "SPELLCD",
									["Name"] = "Shield Bash",
									["Operator"] = "~=",
								}, -- [2]
								{
									["PrtsBefore"] = 1,
									["Type"] = "STANCE",
									["Name"] = "Berserker Stance",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["PrtsAfter"] = 1,
									["Type"] = "SPELLCD",
									["Name"] = "Pummel",
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
									["PrtsAfter"] = 2,
									["Type"] = "SPELLCD",
									["Name"] = "Shield Bash",
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
									["Type"] = "REACT",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [10]
								{
									["Type"] = "BUFFDUR",
									["PrtsAfter"] = 1,
									["Name"] = "Spell Reflection",
								}, -- [11]
								{
									["Name"] = "xUnitCastingNonInteruptable(\"target\")",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Type"] = "LUA",
								}, -- [12]
								{
									["Type"] = "SPEC",
									["Level"] = 1,
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
									["Operator"] = "<=",
									["Unit"] = "target",
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
									["Type"] = "SPEC",
									["Level"] = 2,
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
							["GUID"] = "TMW:icon:1Z7AzkxDmWSh",
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
							["OnlyInBags"] = true,
							["Name"] = "10",
							["OnlyEquipped"] = true,
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
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [4]
								["n"] = 4,
							},
							["CustomTex"] = "52766",
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
							["GUID"] = "TMW:icon:1cImVBIcAY4d",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPEC",
									["Name"] = "IsEquippedItemType(\"Shields\")",
									["Level"] = 1,
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
						}, -- [43]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shockwave",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["Level"] = 1,
									["Name"] = "IsEquippedItemType(\"Shields\")",
									["BitFlags"] = {
										[73] = true,
									},
								}, -- [1]
								{
									["Name"] = "--xBehindTarget()\nxAOE(8) > 1",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Unit"] = "target",
									["Type"] = "DEBUFFDUR",
									["Name"] = "Rend",
									["Operator"] = "~=",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1cInmKqRcgiv",
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
									["Operator"] = "<",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sunder Armor",
									["Unit"] = "target",
									["Level"] = 7.5,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "<",
								}, -- [2]
								{
									["Type"] = "LUA",
									["Name"] = "xTTD > 20",
									["Unit"] = "target",
								}, -- [3]
								{
									["Operator"] = ">=",
									["Level"] = 82,
									["Type"] = "LEVEL",
									["Unit"] = "target",
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
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "PVPFLAG",
								}, -- [1]
								{
									["Type"] = "CLASS2",
									["Unit"] = "target",
									["BitFlags"] = 43,
								}, -- [2]
								{
									["Type"] = "STANCE",
									["PrtsAfter"] = 1,
									["Name"] = "Defensive Stance",
								}, -- [3]
								{
									["Type"] = "NAME",
									["AndOr"] = "OR",
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
							["GUID"] = "TMW:icon:1YXBo4F3g7mS",
							["Type"] = "buff",
							["Name"] = "Sweeping Strikes",
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
					["TextureName"] = "Details Flat",
					["Name"] = "GENERAL",
					["Locked"] = true,
					["Alpha"] = 0,
					["Point"] = {
						["y"] = -95,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["OnlyInCombat"] = true,
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Columns"] = 1,
					["Scale"] = 1.2,
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
					["TextureName"] = "Details Flat",
					["Name"] = "OTHER PORTRAIT",
					["Alpha"] = 0,
					["Point"] = {
						["y"] = -74,
						["x"] = -290,
					},
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
								"TMW:icon:1cJVovwBE2GS", -- [1]
								"TMW:icon:1ZmhsoGZsuaJ", -- [2]
								"TMW:icon:1ZmhsoDa4SWt", -- [3]
								"TMW:icon:1Z7R_6NwuWuK", -- [4]
								"TMW:icon:1ZtDewhXS=4x", -- [5]
								"TMW:icon:1ZsiUeXgH5da", -- [6]
								"TMW:icon:1Z679nrqAgG4", -- [7]
								"TMW:icon:1YO55KEUKaW4", -- [8]
								"TMW:icon:1YP2Xjgjriiu", -- [9]
								"TMW:icon:1cGTQ9CmyiK1", -- [10]
								"TMW:icon:1TQv_Ltf40Wl", -- [11]
								"TMW:icon:1Z7PEaK_TNq3", -- [12]
								"TMW:icon:1ZYr3kQXDQKM", -- [13]
								"TMW:icon:1YWHZ7T27TKe", -- [14]
								"TMW:icon:1cInmKqRcgiv", -- [15]
								"TMW:icon:1TU=hLnlwyeY", -- [16]
								"TMW:icon:1Z55tRwA_pKn", -- [17]
								"TMW:icon:1ZQcfScLCzCQ", -- [18]
								"TMW:icon:1Xwc=6KNp27d", -- [19]
								"TMW:icon:1YEqZQbYmmFD", -- [20]
								"TMW:icon:1Xrn34GriOqy", -- [21]
								"TMW:icon:1TWZdpV26rm5", -- [22]
								"TMW:icon:1XzwOSGxkHLD", -- [23]
								"TMW:icon:1cImVBIcAY4d", -- [24]
								"TMW:icon:1TZvNvflXM0_", -- [25]
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
						{
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
								"TMW:icon:1cJVovwBE2GS", -- [1]
								"TMW:icon:1ZmhsoGZsuaJ", -- [2]
								"TMW:icon:1ZmhsoDa4SWt", -- [3]
								"TMW:icon:1Z7R_6NwuWuK", -- [4]
								"TMW:icon:1ZtDewhXS=4x", -- [5]
								"TMW:icon:1ZsiUeXgH5da", -- [6]
								"TMW:icon:1Z679nrqAgG4", -- [7]
								"TMW:icon:1YO55KEUKaW4", -- [8]
								"TMW:icon:1YP2Xjgjriiu", -- [9]
								"TMW:icon:1cGTQ9CmyiK1", -- [10]
								"TMW:icon:1TQv_Ltf40Wl", -- [11]
								"TMW:icon:1Z7PEaK_TNq3", -- [12]
								"TMW:icon:1ZYr3kQXDQKM", -- [13]
								"TMW:icon:1YWHZ7T27TKe", -- [14]
								"TMW:icon:1cInmKqRcgiv", -- [15]
								"TMW:icon:1TU=hLnlwyeY", -- [16]
								"TMW:icon:1Z55tRwA_pKn", -- [17]
								"TMW:icon:1ZQcfScLCzCQ", -- [18]
								"TMW:icon:1Xwc=6KNp27d", -- [19]
								"TMW:icon:1YEqZQbYmmFD", -- [20]
								"TMW:icon:1Xrn34GriOqy", -- [21]
								"TMW:icon:1TWZdpV26rm5", -- [22]
								"TMW:icon:1XzwOSGxkHLD", -- [23]
								"TMW:icon:1cImVBIcAY4d", -- [24]
								"TMW:icon:1TZvNvflXM0_", -- [25]
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
					["Locked"] = true,
					["Scale"] = 0.4,
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
					["Name"] = "ROTATION QUEUE",
				}, -- [6]
				{
					["GUID"] = "TMW:group:1ZM=EKbLryuK",
					["Point"] = {
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
					},
					["Scale"] = 0.4,
					["Locked"] = true,
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
					["Columns"] = 1,
				}, -- [7]
			},
			["Locked"] = true,
			["Version"] = 102701,
			["NumGroups"] = 7,
			["TextureName"] = "xVerminClean",
		},
		["ROGUE"] = {
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
							["Name"] = "Sinister Strike",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "GetComboPoints(\"player\", \"target\") < 4",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
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
							["Name"] = "Eviscerate",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "GetComboPoints(\"player\", \"target\") >= 4",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
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
							["Name"] = "Slice and Dice",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Level"] = 4.6,
									["Name"] = "Slice and Dice",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Name"] = "GetComboPoints(\"player\", \"target\") >= 1",
									["Type"] = "LUA",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1cbKjFXlYlWy",
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
							["Type"] = "cooldown",
							["Name"] = "Blade Flurry",
							["GUID"] = "TMW:icon:1cbByxtiElWn",
							["Conditions"] = {
								{
									["Name"] = "xAOE(10)<2",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "57499",
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
						}, -- [19]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blade Flurry",
							["Conditions"] = {
								{
									["Name"] = "xAOE(10)>1",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Name"] = "Blade Flurry",
									["Type"] = "BUFFDUR",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1cbByxtj3W4q",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Auto Attack",
							["GUID"] = "TMW:icon:1cLpuyk8rjiz",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "IsCurrentSpell(6603) == false",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "674",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Pick Pocket",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "COMBAT",
									["Level"] = 1,
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
					["Name"] = "Rogue Spells",
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
								"TMW:icon:1cLpuyk8rjiz", -- [1]
								"TMW:icon:1cbByxtiElWn", -- [2]
								"TMW:icon:1cbByxtj3W4q", -- [3]
								"TMW:icon:1TeVAjjXQ0WB", -- [4]
								"TMW:icon:1cbKjFXlYlWy", -- [5]
								"TMW:icon:1TeVAjjavXC6", -- [6]
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
								"TMW:icon:1cLpuyk8rjiz", -- [1]
								"TMW:icon:1cbByxtiElWn", -- [2]
								"TMW:icon:1cbByxtj3W4q", -- [3]
								"TMW:icon:1TeVAjjXQ0WB", -- [4]
								"TMW:icon:1cbKjFXlYlWy", -- [5]
								"TMW:icon:1TeVAjjavXC6", -- [6]
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
					["GUID"] = "TMW:group:1ZThAKUg1Y0w",
					["Columns"] = 1,
					["Scale"] = 0.4,
					["Locked"] = true,
					["Name"] = "Rotation OFFGCD",
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
					["Point"] = {
						["y"] = -9.187387125994171e-05,
						["x"] = 30,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
				}, -- [5]
			},
			["NumGroups"] = 5,
			["Version"] = 11001001,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Power Word: Shield",
							["GUID"] = "TMW:icon:1cI7GiRvWhaO",
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
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Power Word: Shield",
							["GUID"] = "TMW:icon:1cHVGCLT5o8x",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Weakened Soul",
									["Unit"] = "mouseover",
								}, -- [1]
								{
									["Operator"] = "<",
									["Level"] = 80,
									["Type"] = "HEALTH",
									["Unit"] = "mouseover",
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
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Renew",
							["GUID"] = "TMW:icon:1a7l2flZcXmn",
							["Conditions"] = {
								{
									["Name"] = "Renew",
									["Type"] = "BUFFDUR",
								}, -- [1]
								{
									["Type"] = "HEALTH",
									["Level"] = 70,
									["Operator"] = "<",
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
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Renew",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Renew",
									["Unit"] = "mouseover",
								}, -- [1]
								{
									["Operator"] = "<",
									["Level"] = 80,
									["Type"] = "HEALTH",
									["Unit"] = "mouseover",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shadow Word: Pain",
							["GUID"] = "TMW:icon:1a7jsvYwXc4j",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 1.4,
									["Name"] = "Shadow Word: Pain",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "CREATURETYPE",
									["Level"] = 1,
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
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
						}, -- [7]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Devouring Plague",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 1.4,
									["Name"] = "Devouring Plague",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "CREATURETYPE",
									["Level"] = 1,
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "SPEC",
									["Level"] = 1,
								}, -- [4]
								["n"] = 4,
							},
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
						}, -- [8]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Vampiric Touch",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 1.4,
									["Name"] = "Vampiric Touch",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "CREATURETYPE",
									["Level"] = 1,
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
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
						}, -- [9]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mind Flay",
							["GUID"] = "TMW:icon:1a9kPVhaMuWr",
							["RangeCheck"] = true,
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
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "CREATURETYPE",
									["Level"] = 1,
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "SPEC",
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Mind Blast",
									["Operator"] = "~=",
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
						}, -- [10]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mind Blast",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
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
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "CREATURETYPE",
									["Level"] = 1,
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "SPEC",
									["Level"] = 1,
								}, -- [6]
								["n"] = 6,
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
						}, -- [11]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shadow Word: Death",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 25,
									["Name"] = "Shadow Word: Pain",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "CREATURETYPE",
									["Level"] = 1,
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "SPEC",
									["Level"] = 1,
								}, -- [4]
								["n"] = 4,
							},
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
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "mouseover",
							["Name"] = "Disease",
							["GUID"] = "TMW:icon:1cHVGCLeBnC9",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Name"] = "magi",
									["Unit"] = "mouseover",
								}, -- [1]
								{
									["Type"] = "ALIVE",
									["Operator"] = "<",
									["Unit"] = "mouseover",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 2,
									["Unit"] = "mouseover",
								}, -- [3]
								["n"] = 3,
							},
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
						}, -- [19]
						{
							["ManaCheck"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "mouseover",
							["Enabled"] = true,
							["Name"] = "Magic",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks:Hide(0)]", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1a9ihU2QC18O",
							["Conditions"] = {
								{
									["Type"] = "EXISTS",
									["Name"] = "magi",
									["Unit"] = "mouseover",
								}, -- [1]
								{
									["Type"] = "ALIVE",
									["Operator"] = "<",
									["Unit"] = "mouseover",
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
							["Conditions"] = {
								{
									["Type"] = "AUTOSPELL",
									["Name"] = "Shoot",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [2]
								["n"] = 2,
							},
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Holy Nova",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "xAOE(10)>1",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
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
						}, -- [26]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Smite",
							["GUID"] = "TMW:icon:1a7l2fmj178S",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [2]
								{
									["Name"] = "xBehindTarget()",
									["Type"] = "LUA",
								}, -- [3]
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [4]
								{
									["Type"] = "CREATURETYPE",
									["Level"] = 1,
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
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
						}, -- [27]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Holy Fire",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [2]
								{
									["Name"] = "xBehindTarget()",
									["Type"] = "LUA",
								}, -- [3]
								{
									["Type"] = "SPEC",
									["Level"] = 2,
								}, -- [4]
								{
									["Type"] = "CREATURETYPE",
									["Level"] = 1,
									["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter; Not specified",
									["Unit"] = "target",
								}, -- [5]
								["n"] = 5,
							},
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
						}, -- [28]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Archangel",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "BUFFSTACKS",
									["Name"] = "Evangelism",
									["Level"] = 5,
								}, -- [1]
								["n"] = 1,
							},
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
							["Name"] = "Inner Fire",
							["GUID"] = "TMW:icon:1a7lUEjXAASn",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Power Word: Fortitude",
							["ManaCheck"] = true,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shadow Word: Pain",
							["GUID"] = "TMW:icon:1a7lUEjf6xOH",
							["ManaCheck"] = true,
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
								"TMW:icon:1cJVovwBE2GS", -- [1]
								"TMW:icon:1ZmhsoGZsuaJ", -- [2]
								"TMW:icon:1ZmhsoDa4SWt", -- [3]
								"TMW:icon:1a9ihU2QC18O", -- [4]
								"TMW:icon:1cHVGCLeBnC9", -- [5]
								"TMW:icon:1a8KSxK3rF0S", -- [6]
								"TMW:icon:1a7lUEjXAASn", -- [7]
								"TMW:icon:1cI7GiRvWhaO", -- [8]
								"TMW:icon:1cIUNzB8Z0C9", -- [9]
								"TMW:icon:1cI7Gl5Tx2q9", -- [10]
								"TMW:icon:1a7jsvYwXc4j", -- [11]
								"TMW:icon:1a9kNk57eWOn", -- [12]
								"TMW:icon:1a7l2fmgZwCv", -- [13]
								"TMW:icon:1a9kPVhaMuWr", -- [14]
								"TMW:icon:1cHmgODPePq4", -- [15]
								"TMW:icon:1a7l2fmj178S", -- [16]
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
								"TMW:icon:1cJVovwBE2GS", -- [1]
								"TMW:icon:1ZmhsoGZsuaJ", -- [2]
								"TMW:icon:1ZmhsoDa4SWt", -- [3]
								"TMW:icon:1a9ihU2QC18O", -- [4]
								"TMW:icon:1cHVGCLeBnC9", -- [5]
								"TMW:icon:1a8KSxK3rF0S", -- [6]
								"TMW:icon:1a7lUEjXAASn", -- [7]
								"TMW:icon:1cI7GiRvWhaO", -- [8]
								"TMW:icon:1cIUNzB8Z0C9", -- [9]
								"TMW:icon:1cI7Gl5Tx2q9", -- [10]
								"TMW:icon:1a7jsvYwXc4j", -- [11]
								"TMW:icon:1a9kNk57eWOn", -- [12]
								"TMW:icon:1a7l2fmgZwCv", -- [13]
								"TMW:icon:1a9kPVhaMuWr", -- [14]
								"TMW:icon:1cHmgODPePq4", -- [15]
								"TMW:icon:1a7l2fmj178S", -- [16]
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
			["Version"] = 110401,
			["NumGroups"] = 6,
			["TextureName"] = "xVerminClean",
		},
		["Asjrdfsad - Golemagg"] = {
			["Version"] = 102601,
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
					["Name"] = "Warlock Spells",
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
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
					["Locked"] = true,
					["Columns"] = 20,
					["Alpha"] = 0,
					["Scale"] = 1,
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
		["DEATHKNIGHT"] = {
			["Locked"] = true,
			["NumGroups"] = 5,
			["Version"] = 102701,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Scale"] = 1,
					["Rows"] = 3,
					["Alpha"] = 0,
					["Name"] = "DK Spells",
					["Locked"] = true,
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
							["Enabled"] = true,
							["OnlyMine"] = true,
							["Name"] = "Icebound Fortitude",
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 50,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Horn of Winter",
							["Enabled"] = true,
							["GCDAsUnusable"] = true,
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
						}, -- [4]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Death and Decay",
							["GUID"] = "TMW:icon:1ZXaz0p3YpOm",
							["Conditions"] = {
								{
									["Name"] = "xAOE(10) > 2",
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
						}, -- [5]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Death Coil",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Level"] = 1,
									["Type"] = "SPEC",
								}, -- [1]
								{
									["Type"] = "RUNIC_POWER",
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
									["Unit"] = "target",
									["Name"] = "Blood Plague",
									["Operator"] = "~=",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Frost Fever",
									["Operator"] = "~=",
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
									["Unit"] = "target",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["AndOr"] = "OR",
									["PrtsBefore"] = 1,
									["Level"] = 7.5,
									["Name"] = "Frost Fever",
									["Operator"] = ">",
								}, -- [6]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Blood Plague",
									["Level"] = 7.5,
									["PrtsAfter"] = 2,
									["Operator"] = ">",
								}, -- [7]
								{
									["Level"] = 1.1,
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
									["Unit"] = "target",
									["Name"] = "local blood, frost, unholy, death = xRuneCount()\n\nif frost>0 and unholy>0 then return true end\nif frost>0 and death>0 and blood+death>1 then return true end\nif unholy>0 and death>0 and blood+death>1 then return true end\n\nreturn false",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["Operator"] = ">",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Bone Shield",
							["GUID"] = "TMW:icon:1ZYXYoMjwNSI",
							["Conditions"] = {
								{
									["Name"] = "Bone Shield",
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
						}, -- [17]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blood Strike",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["Level"] = 2,
									["BitFlags"] = {
										[250] = true,
									},
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
						}, -- [18]
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
									["Type"] = "UNITSPEC",
									["Level"] = 2,
									["BitFlags"] = {
										[250] = true,
									},
								}, -- [3]
								["n"] = 3,
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
						}, -- [19]
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
									["Type"] = "UNITSPEC",
									["Level"] = 2,
									["BitFlags"] = {
										[250] = true,
									},
								}, -- [3]
								{
									["Name"] = "xAOE(5) <= 3",
									["Type"] = "LUA",
								}, -- [4]
								["n"] = 4,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Pestilence",
							["GUID"] = "TMW:icon:1Z4FFfpv6jKF",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "xPestilenceAOE()",
									["AndOr"] = "OR",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Rune Strike",
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1V6noP8ARoel",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Divine Shield",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Ice Block",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Anti-Magic Shell",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "RUNIC_POWER",
									["Level"] = 85,
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
						}, -- [38]
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
									["Type"] = "UNITSPEC",
									["Level"] = 2,
									["BitFlags"] = {
										[250] = true,
									},
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
						}, -- [39]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blood Boil",
							["GUID"] = "TMW:icon:1Z3Dak8Afvm1",
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "LUA",
									["Name"] = "xAOE(10) > 3",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Level"] = 2,
									["Type"] = "UNITSPEC",
									["PrtsAfter"] = 1,
									["BitFlags"] = {
										[250] = true,
									},
								}, -- [2]
								{
									["AndOr"] = "OR",
									["Type"] = "BUFFDUR",
									["Name"] = "Crimson Scourge",
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
						}, -- [40]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Outbreak",
							["GUID"] = "TMW:icon:1cKFCwWrVAeH",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Frost Fever",
									["Level"] = 4,
									["Operator"] = "<=",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Blood Plague",
									["Operator"] = "<=",
									["AndOr"] = "OR",
									["Level"] = 4,
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
									["Alpha"] = 0,
								}, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [41]
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
						}, -- [42]
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
						}, -- [43]
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
						}, -- [44]
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Dancing Rune Weapon",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "LEVEL",
									["Name"] = "Blood Plague",
									["Level"] = -1,
									["AndOr"] = "OR",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1cKFLl4STJ4j",
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
								"TMW:icon:1cJVovwBE2GS", -- [1]
								"TMW:icon:1ZmhsoGZsuaJ", -- [2]
								"TMW:icon:1ZmhsoDa4SWt", -- [3]
								"TMW:icon:1Zsi3BcdqHDl", -- [4]
								"TMW:icon:1Z4FFfpv6jKF", -- [5]
								"TMW:icon:1V6lsULwY3_Y", -- [6]
								"TMW:icon:1ZMyzzwKlj0c", -- [7]
								"TMW:icon:1cKFLl4STJ4j", -- [8]
								"TMW:icon:1ZXaz0p3YpOm", -- [9]
								"TMW:icon:1cKFCwWrVAeH", -- [10]
								"TMW:icon:1YYs1I2bCNGy", -- [11]
								"TMW:icon:1YYs1I2c_Meo", -- [12]
								"TMW:icon:1Z3Dak8Afvm1", -- [13]
								"TMW:icon:1V6noP8ARoel", -- [14]
								"TMW:icon:1ZYXYoMjwNSI", -- [15]
								"TMW:icon:1YaXVCdLMBa8", -- [16]
								"TMW:icon:1YYv3MYeNeSM", -- [17]
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
					["Point"] = {
						["y"] = -140,
						["x"] = -5.450076092640056e-05,
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
								"TMW:icon:1cJVovwBE2GS", -- [1]
								"TMW:icon:1ZmhsoGZsuaJ", -- [2]
								"TMW:icon:1ZmhsoDa4SWt", -- [3]
								"TMW:icon:1Zsi3BcdqHDl", -- [4]
								"TMW:icon:1Z4FFfpv6jKF", -- [5]
								"TMW:icon:1V6lsULwY3_Y", -- [6]
								"TMW:icon:1ZMyzzwKlj0c", -- [7]
								"TMW:icon:1cKFLl4STJ4j", -- [8]
								"TMW:icon:1ZXaz0p3YpOm", -- [9]
								"TMW:icon:1cKFCwWrVAeH", -- [10]
								"TMW:icon:1YYs1I2bCNGy", -- [11]
								"TMW:icon:1YYs1I2c_Meo", -- [12]
								"TMW:icon:1Z3Dak8Afvm1", -- [13]
								"TMW:icon:1V6noP8ARoel", -- [14]
								"TMW:icon:1ZYXYoMjwNSI", -- [15]
								"TMW:icon:1YaXVCdLMBa8", -- [16]
								"TMW:icon:1YYv3MYeNeSM", -- [17]
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
					["Point"] = {
						["y"] = 6.103515625e-05,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
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
								"TMW:icon:1ZsFvYGT2kWU", -- [1]
								"TMW:icon:1TeVAjjavXC6", -- [2]
								"TMW:icon:1TeVAjjXQ0WB", -- [3]
								"TMW:icon:1YbGRIr4FVqp", -- [4]
								"TMW:icon:1ZYXYoMn068Y", -- [5]
								"TMW:icon:1ZGiKdRg6oif", -- [6]
								"TMW:icon:1ZYXYoMjwNSI", -- [7]
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
		},
		["Battlemoo - Golemagg"] = {
			["Version"] = 102601,
		},
		["DRUID"] = {
			["Locked"] = true,
			["Version"] = 11001001,
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
							["Name"] = "Maul",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["AndOr"] = "OR",
									["Type"] = "RAGE_ABS",
									["Level"] = 55,
									["Operator"] = ">=",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Swipe",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 2,
									["Type"] = "LUA",
									["Name"] = "xAOE(10) > 2",
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 55,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "xInRange(8)",
								}, -- [3]
								["n"] = 3,
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
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Lacerate",
							["GUID"] = "TMW:icon:1ZJNiKMfEYOM",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFSTACKS",
									["Name"] = "Lacerate",
									["PrtsBefore"] = 1,
									["Level"] = 3,
									["Unit"] = "target",
									["Operator"] = "<",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Lacerate",
									["AndOr"] = "OR",
									["Unit"] = "target",
									["Level"] = 5,
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
								}, -- [3]
								{
									["Name"] = "xAOE(10) == 1",
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
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Thrash",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "xInRange(8)",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Name"] = "Bear Form",
									["Type"] = "STANCE",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1cLBDv16RMKP",
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
						}, -- [4]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mangle",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Name"] = "33878",
									["Type"] = "SPELLCD",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1Z6o5cxM6Qma",
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
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [5]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Bash",
							["GUID"] = "TMW:icon:1cNVkh6MdjCP",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "SPELLCD",
									["Name"] = "80964",
									["Operator"] = "~=",
								}, -- [3]
								{
									["Name"] = "xUnitCasting(\"target\")",
									["Type"] = "LUA",
								}, -- [4]
								["n"] = 4,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Faerie Fire (Feral)",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Bear Form; Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Faerie Fire",
									["Unit"] = "target",
								}, -- [2]
								{
									["Name"] = "Prowl",
									["Type"] = "BUFFDUR",
								}, -- [3]
								{
									["Name"] = "xInRange(10)",
									["Type"] = "LUA",
								}, -- [4]
								{
									["Name"] = "xAOE(10) == 1",
									["Type"] = "LUA",
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
									["Name"] = "xBehindTarget()",
									["Type"] = "LUA",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1ZeQiVw1QEaz",
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
						}, -- [16]
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
									["AndOr"] = "OR",
									["Level"] = 5,
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Rip",
									["Level"] = 5,
									["Operator"] = ">",
									["Unit"] = "target",
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
						}, -- [17]
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
									["Name"] = "Rake",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
								}, -- [2]
								{
									["Name"] = "xAOE(10) <= 5",
									["Type"] = "LUA",
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
						}, -- [18]
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
									["Level"] = 5,
									["Type"] = "COMBO",
								}, -- [2]
								{
									["Name"] = "Rip",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
								}, -- [3]
								{
									["Level"] = 10000,
									["Type"] = "HEALTH_ABS",
									["Unit"] = "target",
									["Operator"] = ">",
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
						}, -- [19]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mangle",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle",
									["Level"] = 6,
									["Operator"] = "<=",
									["Unit"] = "target",
								}, -- [2]
								["n"] = 2,
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
						}, -- [20]
						{
							["GUID"] = "TMW:icon:1V6noP8ARoel",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Barkskin",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Level"] = 60,
									["Type"] = "HEALTH",
									["Name"] = "Bear Form; Cat Form",
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
						}, -- [21]
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
									["Level"] = 45,
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
						}, -- [22]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Frenzied Regeneration",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 60,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Name"] = "Bear Form",
									["Type"] = "STANCE",
								}, -- [2]
								["n"] = 2,
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
						}, -- [23]
						{
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["Type"] = "cooldown",
							["RangeCheck"] = true,
							["OnlyMine"] = true,
							["Name"] = "Demoralizing Roar",
							["Enabled"] = true,
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
									["Operator"] = "<=",
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
						}, -- [24]
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Auto Attack",
							["GUID"] = "TMW:icon:1cLpuyk8rjiz",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "IsCurrentSpell(6603) == false",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "674",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Savage Roar",
							["Conditions"] = {
								{
									["Type"] = "COMBO",
									["Level"] = 1,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Name"] = "Savage Roar",
									["Type"] = "BUFFDUR",
								}, -- [2]
								{
									["Level"] = 10000,
									["Type"] = "HEALTH_ABS",
									["Unit"] = "target",
									["Operator"] = ">",
								}, -- [3]
								["n"] = 3,
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
						}, -- [38]
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
									["Type"] = "ENERGY_ABS",
									["Level"] = 30,
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
						}, -- [39]
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
						}, -- [40]
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
									["Level"] = 85,
									["Type"] = "THREATSCALED",
									["Unit"] = "target",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Pulverize",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Level"] = 3,
									["Name"] = "Lacerate",
									["Unit"] = "target",
								}, -- [2]
								{
									["Name"] = "xAOE(10) == 1",
									["Type"] = "LUA",
								}, -- [3]
								{
									["Level"] = 1.5,
									["Type"] = "BUFFDUR",
									["Name"] = "Pulverize",
									["Operator"] = "<=",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1cLBDv2Q0aKk",
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
							["Name"] = "Nature's Grasp",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Type"] = "ISPLAYER",
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
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1ZJOZ6wmptif",
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
							["Type"] = "cooldown",
							["Name"] = "Claw",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Level"] = 4,
									["Operator"] = "<=",
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
						}, -- [59]
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
									["Name"] = "Rip",
									["PrtsBefore"] = 2,
									["Level"] = 5.5,
									["Unit"] = "target",
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "IsSpellKnown(1079)",
								}, -- [4]
								{
									["Type"] = "HEALTH_ABS",
									["Level"] = 10000,
									["Unit"] = "target",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
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
					["Name"] = "Druid Spells",
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
									["Name"] = "not IsAltKeyDown();",
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
								{
									["Type"] = "STANCE",
									["Name"] = "Tree of Life",
									["AndOr"] = "OR",
								}, -- [6]
								["n"] = 6,
							},
							["Icons"] = {
								"TMW:icon:1cNVkh6MdjCP", -- [1]
								"TMW:icon:1cLpuyk8rjiz", -- [2]
								"TMW:icon:1ZM_VlmD27Ka", -- [3]
								"TMW:icon:1V6noP8ARoel", -- [4]
								"TMW:icon:1Z69muUKqqKC", -- [5]
								"TMW:icon:1bRqDvw9Jzmr", -- [6]
								"TMW:icon:1Z4qW_DgW_ek", -- [7]
								"TMW:icon:1Z6o5cxM6Qma", -- [8]
								"TMW:icon:1cLBDv2Q0aKk", -- [9]
								"TMW:icon:1ZJNiKMfEYOM", -- [10]
								"TMW:icon:1cLBDv16RMKP", -- [11]
								"TMW:icon:1V6lsULwY3_Y", -- [12]
								"TMW:icon:1YatF3BT0RKW", -- [13]
								"TMW:icon:1TeVAjjavXC6", -- [14]
								"TMW:icon:1YbFYj2F1X0v", -- [15]
								"TMW:icon:1Z69muUIlNiY", -- [16]
								"TMW:icon:1ZamSC33bwu9", -- [17]
								"TMW:icon:1YaXVCdLMBa8", -- [18]
								"TMW:icon:1YZamy7DqjiW", -- [19]
								"TMW:icon:1ZeQiVw1QEaz", -- [20]
								"TMW:icon:1YYs1I2bCNGy", -- [21]
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
								{
									["Type"] = "STANCE",
									["Name"] = "Tree of Life",
									["AndOr"] = "OR",
								}, -- [6]
								["n"] = 6,
							},
							["Icons"] = {
								"TMW:icon:1cNVkh6MdjCP", -- [1]
								"TMW:icon:1cLpuyk8rjiz", -- [2]
								"TMW:icon:1ZM_VlmD27Ka", -- [3]
								"TMW:icon:1V6noP8ARoel", -- [4]
								"TMW:icon:1Z69muUKqqKC", -- [5]
								"TMW:icon:1bRqDvw9Jzmr", -- [6]
								"TMW:icon:1Z4qW_DgW_ek", -- [7]
								"TMW:icon:1Z6o5cxM6Qma", -- [8]
								"TMW:icon:1cLBDv2Q0aKk", -- [9]
								"TMW:icon:1ZJNiKMfEYOM", -- [10]
								"TMW:icon:1cLBDv16RMKP", -- [11]
								"TMW:icon:1V6lsULwY3_Y", -- [12]
								"TMW:icon:1YatF3BT0RKW", -- [13]
								"TMW:icon:1TeVAjjavXC6", -- [14]
								"TMW:icon:1YbFYj2F1X0v", -- [15]
								"TMW:icon:1Z69muUIlNiY", -- [16]
								"TMW:icon:1ZamSC33bwu9", -- [17]
								"TMW:icon:1YaXVCdLMBa8", -- [18]
								"TMW:icon:1YZamy7DqjiW", -- [19]
								"TMW:icon:1ZeQiVw1QEaz", -- [20]
								"TMW:icon:1YYs1I2bCNGy", -- [21]
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
					["SortPriorities"] = {
						{
							["Order"] = -1,
						}, -- [1]
					},
					["Name"] = "Rotation TOPLEFT",
					["Locked"] = true,
					["Columns"] = 1,
					["OnlyInCombat"] = true,
				}, -- [4]
				{
					["GUID"] = "TMW:group:1ZI1LEibEVeR",
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
									["Name"] = "return not IsAltKeyDown();",
									["Type"] = "LUA",
								}, -- [2]
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [3]
								{
									["Unit"] = "target",
									["Type"] = "ALIVE",
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
		},
		["SHAMAN"] = {
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
							["GUID"] = "TMW:icon:1Zi_P9LYFYqt",
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Earth Shock",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = ">",
									["Level"] = 4,
									["Name"] = "Flame Shock",
									["Unit"] = "target",
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
					["Name"] = "SHAMAN SPELLS",
					["Locked"] = true,
					["Alpha"] = 0,
					["Columns"] = 20,
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
			["Version"] = 102701,
		},
		["PALADIN"] = {
			["Version"] = 11001001,
			["NumGroups"] = 5,
			["Groups"] = {
				{
					["Scale"] = 1,
					["Rows"] = 3,
					["Locked"] = true,
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Alpha"] = 0,
					["Name"] = "PALADIN SPELLS",
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Icons"] = {
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Righteous Fury",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "Righteous Fury",
								}, -- [1]
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[66] = true,
									},
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
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Avenger's Shield",
							["GUID"] = "TMW:icon:1ZkmyyWWPpGC",
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
									["Unit"] = "mouseover",
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "xInRange(30,\"mouseover\")",
								}, -- [2]
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[66] = true,
									},
								}, -- [3]
								["n"] = 3,
							},
						}, -- [2]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Hammer of the Righteous",
							["GUID"] = "TMW:icon:1ZkmyyWS_emA",
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
							["RangeCheck"] = true,
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Operator"] = "<=",
									["Name"] = "Hammer of the Righteous",
									["Level"] = 0.6,
								}, -- [1]
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[66] = true,
									},
									["Level"] = 2,
								}, -- [2]
								{
									["Type"] = "LUA",
									["Name"] = "xAOE(10)>1",
								}, -- [3]
								["n"] = 3,
							},
						}, -- [3]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Shield of the Righteous",
							["GUID"] = "TMW:icon:1ZkmyyWUmDSs",
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
							["RangeCheck"] = true,
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Operator"] = "<=",
									["Name"] = "Shield of Righteousness",
									["Level"] = 0.6,
								}, -- [1]
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[66] = true,
									},
									["Level"] = 2,
								}, -- [2]
								{
									["Type"] = "HOLY_POWER",
									["Level"] = 3,
								}, -- [3]
								["n"] = 3,
							},
						}, -- [4]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Holy Shield",
							["ManaCheck"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[66] = true,
									},
									["Level"] = 2,
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Holy Shield",
								}, -- [2]
								{
									["Type"] = "MANA",
									["Operator"] = ">=",
									["Level"] = 15,
								}, -- [3]
								{
									["Type"] = "SPELLCD",
									["Operator"] = "<=",
									["Name"] = "Holy Shield",
									["Level"] = 1.1,
								}, -- [4]
								["n"] = 4,
							},
						}, -- [5]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Holy Wrath",
							["ManaCheck"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "xInRange(8)",
								}, -- [1]
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[66] = true,
									},
								}, -- [2]
								["n"] = 2,
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
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Seal of Insight",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Operator"] = "<=",
									["Name"] = "Seal of Insight",
									["Level"] = 15,
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Seal of Truth",
								}, -- [2]
								{
									["Type"] = "LUA",
									["Name"] = "not IsSpellKnown(31801)",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1cLq3CArMVCl",
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
						}, -- [19]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Seal of Truth",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Operator"] = "<=",
									["Name"] = "Seal of Truth",
									["Level"] = 15,
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Seal of Insight",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Seal of Righteousness",
								}, -- [3]
								["n"] = 3,
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
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Divine Protection",
							["ManaCheck"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 80,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [21]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Divine Shield",
							["GUID"] = "TMW:icon:1cJR_CEgBZWT",
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
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 40,
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Forbearance",
								}, -- [2]
								["n"] = 2,
							},
						}, -- [22]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Ardent Defender",
							["GUID"] = "TMW:icon:1cJSdd6q=s8Z",
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
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 30,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [23]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Lay on Hands",
							["ManaCheck"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 20,
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Forbearance",
								}, -- [2]
								["n"] = 2,
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
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "mouseover",
							["Type"] = "buff",
							["Enabled"] = true,
							["Name"] = "Poison; Disease",
							["Conditions"] = {
								{
									["Type"] = "REACT",
									["Unit"] = "mouseover",
									["Level"] = 2,
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZwdlWxY789W",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
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
						}, -- [39]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Type"] = "buff",
							["Name"] = "Poison; Disease",
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "xBehindTarget()",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1Z6tL7hbgPqi",
							["ManaCheck"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
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
							["Enabled"] = true,
						}, -- [40]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Consecration",
							["ManaCheck"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "xAOE(10) > 0 and xInRange(2)",
								}, -- [1]
								{
									["Type"] = "MANA",
									["Operator"] = ">=",
									["Level"] = 15,
								}, -- [2]
								{
									["Type"] = "SPEED",
								}, -- [3]
								["n"] = 3,
							},
						}, -- [41]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Judgement",
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
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1bMBoWa6os4j",
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Operator"] = "<=",
									["Name"] = "Judgement",
									["Level"] = 1.1,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [42]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Hammer of Wrath",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Unit"] = "target",
									["Operator"] = "<=",
									["Level"] = 20,
								}, -- [1]
								{
									["Type"] = "MANA",
									["Operator"] = ">=",
									["Level"] = 15,
								}, -- [2]
								["n"] = 2,
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
							["RangeCheck"] = true,
						}, -- [43]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Crusader Strike",
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
							["GUID"] = "TMW:icon:1YawP4LcafCX",
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "xAOE(10) == 1 or not IsSpellKnown(53595)",
								}, -- [1]
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[66] = true,
									},
								}, -- [2]
								["n"] = 2,
							},
						}, -- [44]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Divine Storm",
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
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1YatF3BT0RKW",
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[70] = true,
									},
									["Level"] = 2,
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "xInRange(8)",
								}, -- [2]
								["n"] = 2,
							},
						}, -- [45]
						{
							["Type"] = "cooldown",
							["GUID"] = "TMW:icon:1Z6tL7hXaSCZ",
							["Name"] = "Exorcism",
							["ManaCheck"] = true,
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
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Word of Glory",
							["ManaCheck"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "HOLY_POWER",
									["Operator"] = ">",
									["Name"] = "Sacred Shield",
								}, -- [1]
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 80,
								}, -- [2]
								["n"] = 2,
							},
						}, -- [56]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Divine Plea",
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Operator"] = "<=",
									["Level"] = 75,
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
								}, -- [1]
								nil, -- [2]
								{
								}, -- [3]
								{
								}, -- [4]
							},
						}, -- [57]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Sacred Shield",
							["GUID"] = "TMW:icon:1bP6ZsEhWhyX",
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
									["Name"] = "Sacred Shield",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [58]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
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
									["Type"] = "HEALTH",
									["Unit"] = "mouseover",
									["Operator"] = "<",
									["Level"] = 90,
								}, -- [3]
								{
									["Type"] = "REACT",
									["Unit"] = "mouseover",
									["Level"] = 2,
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
						}, -- [59]
						{
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Name"] = "Beacon of Light",
							["GUID"] = "TMW:icon:1Ztb9RIdmLi9",
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
									["Type"] = "SPEC",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "focus",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Unit"] = "focus",
									["Name"] = "Beacon of Light",
								}, -- [3]
								["n"] = 3,
							},
						}, -- [60]
					},
				}, -- [1]
				{
					["Point"] = {
						["y"] = -20.00000522536274,
						["x"] = -229.9999934656047,
					},
					["Scale"] = 1.5,
					["TextureName"] = "Details Flat",
					["GUID"] = "TMW:group:1TWYPj24VzCn",
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
					["Name"] = "OTHER",
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
								"TMW:icon:1cJVovwBE2GS", -- [1]
								"TMW:icon:1ZmhsoGZsuaJ", -- [2]
								"TMW:icon:1ZmhsoDa4SWt", -- [3]
								"TMW:icon:1cLq3CArMVCl", -- [4]
								"TMW:icon:1ZkmyynlJgaL", -- [5]
								"TMW:icon:1ZmhO7mqKue=", -- [6]
								"TMW:icon:1cGDgHveUk4V", -- [7]
								"TMW:icon:1cJR_CEgBZWT", -- [8]
								"TMW:icon:1Z6tL7hZeq4n", -- [9]
								"TMW:icon:1ZkmyyWZapS_", -- [10]
								"TMW:icon:1ZwdlWxY789W", -- [11]
								"TMW:icon:1Z6tL7hbgPqi", -- [12]
								"TMW:icon:1ZkmyyWWPpGC", -- [13]
								"TMW:icon:1Z6tL7hfkyqu", -- [14]
								"TMW:icon:1ZkmyyWX_u4d", -- [15]
								"TMW:icon:1ZkmyyWUmDSs", -- [16]
								"TMW:icon:1bMBP=Ir0TOf", -- [17]
								"TMW:icon:1YawP4LcafCX", -- [18]
								"TMW:icon:1ZkmyyWS_emA", -- [19]
								"TMW:icon:1bMBoWa6os4j", -- [20]
								"TMW:icon:1YXd9eWHzTSH", -- [21]
								"TMW:icon:1bP6ZsEhWhyX", -- [22]
							},
							["Enabled"] = true,
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
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [4]
								["n"] = 4,
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
					["Name"] = "ROTATION CENTER",
					["GUID"] = "TMW:group:1TeVDtajUwqa",
				}, -- [3]
				{
					["Point"] = {
						["y"] = 6.103515625e-05,
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
								"TMW:icon:1cJVovwBE2GS", -- [1]
								"TMW:icon:1ZmhsoGZsuaJ", -- [2]
								"TMW:icon:1ZmhsoDa4SWt", -- [3]
								"TMW:icon:1cLq3CArMVCl", -- [4]
								"TMW:icon:1ZkmyynlJgaL", -- [5]
								"TMW:icon:1ZmhO7mqKue=", -- [6]
								"TMW:icon:1cGDgHveUk4V", -- [7]
								"TMW:icon:1cJR_CEgBZWT", -- [8]
								"TMW:icon:1Z6tL7hZeq4n", -- [9]
								"TMW:icon:1ZkmyyWZapS_", -- [10]
								"TMW:icon:1ZwdlWxY789W", -- [11]
								"TMW:icon:1Z6tL7hbgPqi", -- [12]
								"TMW:icon:1ZkmyyWWPpGC", -- [13]
								"TMW:icon:1Z6tL7hfkyqu", -- [14]
								"TMW:icon:1ZkmyyWX_u4d", -- [15]
								"TMW:icon:1ZkmyyWUmDSs", -- [16]
								"TMW:icon:1bMBP=Ir0TOf", -- [17]
								"TMW:icon:1YawP4LcafCX", -- [18]
								"TMW:icon:1ZkmyyWS_emA", -- [19]
								"TMW:icon:1bMBoWa6os4j", -- [20]
								"TMW:icon:1YXd9eWHzTSH", -- [21]
								"TMW:icon:1bP6ZsEhWhyX", -- [22]
							},
							["Enabled"] = true,
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
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "MOUNTED",
									["Level"] = 1,
								}, -- [4]
								["n"] = 4,
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
					["Name"] = "ROTATION TOPLEFT",
					["GUID"] = "TMW:group:1YWtClNC=L8S",
				}, -- [4]
				{
					["GUID"] = "TMW:group:1Zmhq7u_10aD",
					["Scale"] = 0.4,
					["Locked"] = true,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1Z6tL7hdj2mo", -- [1]
								"TMW:icon:1cJSdd6q=s8Z", -- [2]
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "COMBAT",
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
					["Name"] = "ROTATION QUEUE",
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
			["Locked"] = true,
		},
	},
}
