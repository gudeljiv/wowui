
TellMeWhenDB = {
	["profileKeys"] = {
		["Dotwise - Golemagg"] = "Warrior",
		["Vermins - Stonespine"] = "Warrior",
		["Mxyz - Golemagg"] = "Mxyz - Golemagg",
		["Pitchwise - Golemagg"] = "Warrior",
		["Verminz - Golemagg"] = "Warrior",
		["Mxzq - Golemagg"] = "Warrior",
		["Elohssa - Stonespine"] = "Elohssa - Stonespine",
		["Paydo - Dreadmist"] = "Warrior",
		["Kosturko - Golemagg"] = "Kosturko - Golemagg",
		["Greenwise - Golemagg"] = "Warrior",
		["Korupcija - Stonespine"] = "Warrior",
		["Judawise - Golemagg"] = "Warrior",
		["Vermin - Golemagg"] = "Warrior",
		["Vermins - Dreadmist"] = "Vermins - Dreadmist",
		["Ozrencic - Golemagg"] = "Ozrencic - Golemagg",
		["Whatevs - Stonespine"] = "Whatevs - Stonespine",
	},
	["global"] = {
		["TextLayouts"] = {
			["icon1"] = {
				{
				}, -- [1]
				{
				}, -- [2]
			},
			["bar2"] = {
				{
				}, -- [1]
				{
				}, -- [2]
			},
			["TMW:textlayout:1TYZ96XyCAeK"] = {
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
					["Height"] = 1,
				}, -- [1]
				{
					["Outline"] = "OUTLINE",
					["SkinAs"] = "Count",
					["Anchors"] = {
						{
							["point"] = "BOTTOMRIGHT",
							["relativePoint"] = "BOTTOMRIGHT",
						}, -- [1]
					},
					["StringName"] = "Stacks",
					["DefaultText"] = "[Stacks:Hide(0)]",
				}, -- [2]
				["GUID"] = "TMW:textlayout:1TYZ96XyCAeK",
				["Name"] = "Icon Layout 2",
				["n"] = 2,
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
		["AllowCombatConfig"] = true,
		["HelpSettings"] = {
			["CNDT_ANDOR_FIRSTSEE"] = true,
			["SUG_FIRSTHELP"] = true,
			["CNDT_PARENTHESES_FIRSTSEE"] = true,
			["SCROLLBAR_DROPDOWN"] = true,
		},
	},
	["Version"] = 86907,
	["profiles"] = {
		["Dotwise - Golemagg"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TYIpcX76ymi",
				}, -- [1]
			},
		},
		["Mxyz - Golemagg"] = {
			["Locked"] = true,
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1V1AouTcfJCA",
				}, -- [1]
			},
		},
		["Pitchwise - Golemagg"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TYIvCrLrKyo",
				}, -- [1]
			},
		},
		["Verminz - Golemagg"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TT_BcN4Ph4K",
				}, -- [1]
			},
		},
		["Paydo - Dreadmist"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TTcu_6AC6Sa",
				}, -- [1]
			},
		},
		["Kosturko - Golemagg"] = {
			["Locked"] = true,
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TVw=k072CWx",
				}, -- [1]
			},
		},
		["Arms"] = {
			["Version"] = 86907,
			["NumGroups"] = 9,
			["TextureName"] = "Blizzard Raid Bar",
			["Groups"] = {
				{
					["Strata"] = "HIGH",
					["Point"] = {
						["y"] = -57.2282093962039,
						["x"] = 3.52281761169434,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Scale"] = 0.600000023841858,
					["Rows"] = 7,
					["EnabledSpecs"] = {
						[73] = false,
						[72] = false,
					},
					["Columns"] = 20,
					["Icons"] = {
						{
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Type"] = "buff",
							["Name"] = "772",
							["Conditions"] = {
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "19138",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "208086",
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["Operator"] = ">",
									["Unit"] = "target",
									["Level"] = 20,
								}, -- [3]
								["n"] = 3,
							},
							["DurationMaxEnabled"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								[100] = {
									["Alpha"] = 0.06,
								},
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RGdpp24C0VS",
							["DurationMax"] = 3.5,
							["Enabled"] = true,
						}, -- [1]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "107574",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22397",
								}, -- [1]
								{
									["Type"] = "COUNTER",
									["Name"] = "cooldown_toggle",
								}, -- [2]
								{
									["Type"] = "COUNTER",
									["Name"] = "arms_avatar",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1RZ8uyGIHkyU",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [2]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "227847",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
								}, -- [1]
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["PrtsBefore"] = 3,
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = "<=",
									["Level"] = 35,
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "208086",
								}, -- [4]
								{
									["Type"] = "SPELLCD",
									["Operator"] = "<",
									["Name"] = "167105",
									["PrtsBefore"] = 2,
									["Level"] = 3,
								}, -- [5]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "SPELLCD",
									["Operator"] = "<",
									["AndOr"] = "OR",
									["Name"] = "262161",
									["PrtsBefore"] = 1,
									["Level"] = 3,
								}, -- [7]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 3,
									["Name"] = "22391",
								}, -- [8]
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [9]
								{
									["Type"] = "SPELLCD",
									["Operator"] = "~=",
									["Name"] = "262161",
									["PrtsBefore"] = 2,
								}, -- [10]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [11]
								{
									["Type"] = "SPELLCD",
									["Operator"] = "~=",
									["Name"] = "167105",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [12]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 2,
									["Name"] = "22391",
									["Level"] = 1,
								}, -- [13]
								{
									["Type"] = "LASTCAST",
									["Name"] = "262161",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [14]
								{
									["Type"] = "LASTCAST",
									["PrtsAfter"] = 1,
									["Name"] = "167105",
									["Level"] = 1,
								}, -- [15]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "275529",
									["PrtsBefore"] = 1,
								}, -- [16]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
									["Name"] = "275540",
									["AndOr"] = "OR",
								}, -- [17]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 3,
									["Unit"] = "target",
									["Name"] = "208086",
								}, -- [18]
								{
									["Type"] = "COUNTER",
									["Name"] = "cooldown_toggle",
								}, -- [19]
								{
									["Type"] = "COUNTER",
									["Name"] = "arms_bs",
								}, -- [20]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "21667",
									["Level"] = 1,
								}, -- [21]
								["n"] = 21,
							},
							["GUID"] = "TMW:icon:1Rg1PA0lcPyA",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [3]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "167105",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Name"] = "262161",
									["PrtsBefore"] = 3,
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [2]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Level"] = 1,
									["Name"] = "22391",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
								}, -- [4]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["PrtsBefore"] = 2,
								}, -- [5]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 1,
									["Operator"] = ">",
									["Level"] = 55,
								}, -- [6]
								{
									["Type"] = "COUNTER",
									["PrtsAfter"] = 2,
									["Level"] = 1,
									["Name"] = "testofmight",
									["AndOr"] = "OR",
								}, -- [7]
								{
									["Type"] = "COUNTER",
									["Name"] = "cooldown_toggle",
								}, -- [8]
								{
									["Type"] = "COUNTER",
									["Name"] = "arms_cs",
								}, -- [9]
								["n"] = 9,
							},
							["GUID"] = "TMW:icon:1RGdpp2C6tbD",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [4]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTBzFiJhwQj",
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Unit"] = "target",
									["Name"] = "execute",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "SPELLCD",
									["Operator"] = "<",
									["Name"] = "12294",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Name"] = "12294",
									["Level"] = 30,
								}, -- [3]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "7384",
									["PrtsBefore"] = 2,
									["Level"] = 2,
								}, -- [4]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22407",
								}, -- [5]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 2,
									["Name"] = "272866",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [6]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 2,
									["Name"] = "272867",
									["AndOr"] = "OR",
								}, -- [7]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["PrtsAfter"] = 3,
									["Unit"] = "target",
									["Level"] = 2,
									["Name"] = "272870",
									["AndOr"] = "OR",
								}, -- [8]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTD2ohayX3V",
								}, -- [9]
								["n"] = 9,
							},
							["DurationMax"] = 2,
							["Enabled"] = true,
						}, -- [5]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RGdpp2Rvc8H",
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Operator"] = "<",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 30,
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
									["Name"] = "262228",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
									["Name"] = "execute",
								}, -- [4]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTD2m1wLgWu",
								}, -- [5]
								["n"] = 5,
							},
							["DurationMax"] = 2,
							["Enabled"] = true,
						}, -- [6]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "260643",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = "<=",
									["Level"] = 60,
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22371",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTC8jAsrdvG",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1RGe00HwCayk",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [7]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]",
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RGeD0uAObsB",
							["Conditions"] = {
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "7384",
									["Level"] = 2,
								}, -- [1]
								{
									["Type"] = "SPELLCD",
									["Name"] = "12294",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 30,
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
									["Name"] = "262228",
									["AndOr"] = "OR",
								}, -- [4]
								{
									["Type"] = "COUNTER",
									["Unit"] = "target",
									["Name"] = "execute",
								}, -- [5]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTC8jAvrtK1",
								}, -- [6]
								["n"] = 6,
							},
							["DurationMax"] = 2,
							["Enabled"] = true,
						}, -- [8]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "227847",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = ">",
									["Unit"] = "target",
									["Name"] = "208086",
									["Level"] = 2,
								}, -- [1]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["PrtsBefore"] = 1,
								}, -- [3]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = "<",
									["Level"] = 35,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [4]
								{
									["Type"] = "COUNTER",
									["PrtsAfter"] = 2,
									["Name"] = "execute",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "COUNTER",
									["Name"] = "cooldown_toggle",
								}, -- [6]
								{
									["Type"] = "COUNTER",
									["Name"] = "arms_bs",
								}, -- [7]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "21667",
									["Level"] = 1,
								}, -- [8]
								["n"] = 8,
							},
							["GUID"] = "TMW:icon:1RTBzNx11CSK",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [9]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "7384",
							["ClockGCD"] = true,
							["GUID"] = "TMW:icon:1RGdpp2XiEgf",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTC8jApfn=I",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "208086",
									["PrtsBefore"] = 3,
								}, -- [2]
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Name"] = "testofmight",
								}, -- [4]
								{
									["Type"] = "COUNTER",
									["AndOr"] = "OR",
									["Name"] = "execute",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 3,
									["Operator"] = "~=",
									["Name"] = "7384",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "298357",
								}, -- [7]
								["n"] = 7,
							},
							["Enabled"] = true,
						}, -- [10]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "7384",
							["ClockGCD"] = true,
							["GUID"] = "TMW:icon:1Rg0on0B7Owq",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["PrtsBefore"] = 2,
								}, -- [1]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
									["Unit"] = "target",
									["Name"] = "208086",
									["PrtsBefore"] = 2,
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 2,
									["Unit"] = "target",
									["Name"] = "208086",
									["AndOr"] = "OR",
								}, -- [4]
								{
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Level"] = 1,
									["Name"] = "testofmight",
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1Rg1obpBJO85",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "298357",
								}, -- [7]
								["n"] = 7,
							},
							["Enabled"] = true,
						}, -- [11]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "163201",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">",
									["Name"] = "163201",
									["PrtsBefore"] = 4,
									["Level"] = 20,
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
									["Name"] = "262228",
									["AndOr"] = "OR",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["PrtsBefore"] = 2,
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "HEALTH",
									["PrtsAfter"] = 1,
									["Operator"] = "<",
									["Unit"] = "target",
									["Level"] = 20,
								}, -- [4]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "HEALTH",
									["PrtsAfter"] = 3,
									["Operator"] = "<",
									["Unit"] = "target",
									["Level"] = 35,
								}, -- [7]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "52437",
									["AndOr"] = "OR",
								}, -- [8]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
									["PrtsBefore"] = 2,
								}, -- [9]
								{
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 1,
									["Name"] = "281000",
								}, -- [10]
								{
									["Type"] = "TALENTLEARNED",
									["AndOr"] = "OR",
									["Name"] = "22380",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [11]
								{
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 4,
									["Name"] = "163201",
								}, -- [12]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTC8jAyqkvm",
								}, -- [13]
								["n"] = 13,
							},
							["GUID"] = "TMW:icon:1RGdpp2IFjGf",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [12]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "1680",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22489",
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["PrtsBefore"] = 4,
									["Level"] = 35,
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 2,
									["Operator"] = "~=",
									["Name"] = "262228",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "HEALTH",
									["Operator"] = ">",
									["Unit"] = "target",
									["Level"] = 20,
								}, -- [4]
								{
									["Type"] = "SPELLCD",
									["Operator"] = ">",
									["Name"] = "12294",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Name"] = "testofmight",
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["PrtsBefore"] = 2,
									["AndOr"] = "OR",
								}, -- [7]
								{
									["Type"] = "SPELLCD",
									["Operator"] = ">",
									["Name"] = "167105",
									["PrtsBefore"] = 2,
									["Level"] = 15,
								}, -- [8]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
									["Level"] = 1,
								}, -- [9]
								{
									["Type"] = "SPELLCD",
									["Operator"] = ">",
									["AndOr"] = "OR",
									["Name"] = "262161",
									["PrtsBefore"] = 1,
									["Level"] = 15,
								}, -- [10]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [11]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 3,
									["Operator"] = ">",
									["Level"] = 65,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [12]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 2,
									["Operator"] = ">",
									["Level"] = 30,
								}, -- [13]
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
								}, -- [14]
								["n"] = 14,
							},
							["GUID"] = "TMW:icon:1RGdpp2dIykT",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [13]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "1464",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22489",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["PrtsBefore"] = 4,
									["Level"] = 25,
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 2,
									["Operator"] = "~=",
									["Name"] = "262228",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "HEALTH",
									["Operator"] = ">",
									["Unit"] = "target",
									["Level"] = 20,
								}, -- [4]
								{
									["Type"] = "SPELLCD",
									["Operator"] = ">",
									["Name"] = "12294",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Name"] = "testofmight",
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [7]
								{
									["Type"] = "SPELLCD",
									["Operator"] = ">",
									["Name"] = "167105",
									["PrtsBefore"] = 2,
									["Level"] = 15,
								}, -- [8]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
									["Level"] = 1,
								}, -- [9]
								{
									["Type"] = "SPELLCD",
									["Operator"] = ">",
									["AndOr"] = "OR",
									["Name"] = "262161",
									["PrtsBefore"] = 1,
									["Level"] = 15,
								}, -- [10]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [11]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 4,
									["Operator"] = ">",
									["Level"] = 65,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [12]
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
								}, -- [13]
								["n"] = 13,
							},
							["GUID"] = "TMW:icon:1RGeIgsJQX0r",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [14]
						{
							["ShowTimer"] = true,
							["Type"] = "swingtimer",
							["Enabled"] = true,
							["Events"] = {
								{
									["AnchorTo"] = "IconModule_CooldownSweepCooldown",
									["Type"] = "Animations",
									["Period"] = 1,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1RJiuYRLZrXP",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 1,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1RJiuYRLZrXP",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1RJiuYRHNBx2",
							["CustomTex"] = "8386",
							["FakeHidden"] = true,
						}, -- [15]
						{
							["ShowTimer"] = true,
							["Type"] = "swingtimer",
							["Enabled"] = true,
							["DurationMaxEnabled"] = true,
							["GUID"] = "TMW:icon:1RJiuYRLZrXP",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 1,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "8386",
							["FakeHidden"] = true,
							["DurationMax"] = 1,
						}, -- [16]
						{
							["Type"] = "buff",
							["ShowTTText"] = true,
							["Name"] = "7384",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1RGeD0uM4U3o",
							["FakeHidden"] = true,
						}, -- [17]
						nil, -- [18]
						{
							["Type"] = "conditionicon",
							["Enabled"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Single",
									},
								},
							},
							["CustomTex"] = "NONE",
							["FakeHidden"] = true,
						}, -- [19]
						nil, -- [20]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "260708",
							["ClockGCD"] = true,
							["GUID"] = "TMW:icon:1RL=eAHTYJcw",
							["FakeHidden"] = true,
							["Enabled"] = true,
						}, -- [21]
						{
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Type"] = "buff",
							["Name"] = "772",
							["Conditions"] = {
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "19138",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "208086",
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["Operator"] = ">",
									["Unit"] = "target",
									["Level"] = 20,
								}, -- [3]
								["n"] = 3,
							},
							["DurationMaxEnabled"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RL=eAHUbY_S",
							["DurationMax"] = 3.5,
							["Enabled"] = true,
						}, -- [22]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "167105",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Name"] = "262161",
									["PrtsBefore"] = 2,
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [2]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Level"] = 1,
									["Name"] = "22391",
									["AndOr"] = "OR",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1RL=eAHVfoHi",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [23]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "227847",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = ">",
									["Unit"] = "target",
									["Name"] = "208086",
									["Level"] = 2,
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "21667",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "COUNTER",
									["Name"] = "cooldown_toggle",
								}, -- [3]
								{
									["Type"] = "COUNTER",
									["Name"] = "arms_bs",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1RTCMxEg4qi8",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [24]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTCN7EH5rEt",
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Unit"] = "target",
									["Name"] = "execute",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "SPELLCD",
									["Operator"] = "<",
									["Name"] = "12294",
									["Level"] = 1.5,
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Name"] = "12294",
									["Level"] = 30,
								}, -- [3]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "7384",
									["PrtsBefore"] = 2,
									["Level"] = 2,
								}, -- [4]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22407",
								}, -- [5]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 2,
									["Name"] = "272866",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [6]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 2,
									["Name"] = "272867",
									["AndOr"] = "OR",
								}, -- [7]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["PrtsAfter"] = 3,
									["Unit"] = "target",
									["Level"] = 2,
									["Name"] = "272870",
									["AndOr"] = "OR",
								}, -- [8]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTD2ohayX3V",
								}, -- [9]
								["n"] = 9,
							},
							["DurationMax"] = 2,
							["Enabled"] = true,
						}, -- [25]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RL=eAHXlHCC",
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Operator"] = "<",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 1.5,
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 30,
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
									["Name"] = "262228",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
									["Name"] = "execute",
								}, -- [4]
								["n"] = 4,
							},
							["DurationMax"] = 2,
							["Enabled"] = true,
						}, -- [26]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "260643",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = "<=",
									["Level"] = 80,
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22371",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1RL=eAHYlywP",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [27]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]",
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RL=eAHaq80u",
							["Conditions"] = {
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "7384",
									["Level"] = 2,
								}, -- [1]
								{
									["Type"] = "SPELLCD",
									["Name"] = "12294",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 30,
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
									["Name"] = "262228",
									["AndOr"] = "OR",
								}, -- [4]
								{
									["Type"] = "COUNTER",
									["Unit"] = "target",
									["Name"] = "execute",
								}, -- [5]
								["n"] = 5,
							},
							["DurationMax"] = 2,
							["Enabled"] = true,
						}, -- [28]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "845",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 20,
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22362",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1Ra7fP21bk42",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [29]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "228920",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = ">",
									["Unit"] = "target",
									["Name"] = "208086",
									["PrtsBefore"] = 2,
									["Level"] = 2,
								}, -- [1]
								{
									["Type"] = "HEALTH",
									["PrtsAfter"] = 1,
									["Operator"] = ">",
									["Unit"] = "target",
									["Level"] = 20,
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["Level"] = 20,
									["Unit"] = "target",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 2,
									["Operator"] = "<",
									["Level"] = 30,
								}, -- [4]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "21667",
								}, -- [5]
								{
									["Type"] = "COUNTER",
									["Name"] = "cooldown_toggle",
								}, -- [6]
								{
									["Type"] = "COUNTER",
									["Name"] = "arms_rav",
								}, -- [7]
								["n"] = 7,
							},
							["GUID"] = "TMW:icon:1RTCPcVTM2Je",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [30]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "7384",
							["ClockGCD"] = true,
							["GUID"] = "TMW:icon:1RL=eAHZoKRG",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "298357",
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
						}, -- [31]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "163201",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">",
									["Name"] = "163201",
									["PrtsBefore"] = 2,
									["Level"] = 40,
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
									["Name"] = "262228",
									["AndOr"] = "OR",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["PrtsBefore"] = 2,
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "HEALTH",
									["PrtsAfter"] = 1,
									["Operator"] = "<",
									["Unit"] = "target",
									["Level"] = 20,
								}, -- [4]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "HEALTH",
									["PrtsAfter"] = 3,
									["Operator"] = "<",
									["Unit"] = "target",
									["Level"] = 35,
								}, -- [7]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "52437",
									["AndOr"] = "OR",
								}, -- [8]
								["n"] = 8,
							},
							["GUID"] = "TMW:icon:1RL=eAHWk5Yo",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [32]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "1680",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 30,
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "262228",
									["AndOr"] = "OR",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1RL=eAHbqFqW",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [33]
						{
							["ShowTimer"] = true,
							["Type"] = "swingtimer",
							["Enabled"] = true,
							["Events"] = {
								{
									["AnchorTo"] = "IconModule_CooldownSweepCooldown",
									["Type"] = "Animations",
									["Period"] = 1,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1RJiuYRLZrXP",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 1,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1RJiuYRLZrXP",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1RL=eAHcqhaW",
							["CustomTex"] = "8386",
							["FakeHidden"] = true,
						}, -- [34]
						nil, -- [35]
						nil, -- [36]
						nil, -- [37]
						nil, -- [38]
						{
							["Type"] = "conditionicon",
							["Enabled"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "AoE",
									},
								},
							},
							["CustomTex"] = "NONE",
							["FakeHidden"] = true,
						}, -- [39]
						nil, -- [40]
						{
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Type"] = "buff",
							["Name"] = "772",
							["Conditions"] = {
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "19138",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Unit"] = "target",
									["Name"] = "208086",
									["Level"] = 2,
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["Operator"] = ">",
									["Unit"] = "target",
									["Level"] = 20,
								}, -- [3]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
								}, -- [4]
								["n"] = 4,
							},
							["DurationMaxEnabled"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTBxKd1K0Rf",
							["DurationMax"] = 5.5,
							["Enabled"] = true,
						}, -- [41]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "167105",
							["ClockGCD"] = true,
							["DurationMaxEnabled"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTBxKd2Ohfq",
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Operator"] = "<",
									["Name"] = "262161",
									["PrtsBefore"] = 3,
									["Level"] = 2,
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [2]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Level"] = 1,
									["Name"] = "22391",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["PrtsBefore"] = 2,
								}, -- [4]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 1,
									["Operator"] = ">",
									["Level"] = 30,
								}, -- [5]
								{
									["Type"] = "COUNTER",
									["PrtsAfter"] = 2,
									["Level"] = 1,
									["Name"] = "testofmight",
									["AndOr"] = "OR",
								}, -- [6]
								{
									["Type"] = "COUNTER",
									["Name"] = "cooldown_toggle",
								}, -- [7]
								{
									["Type"] = "COUNTER",
									["Name"] = "arms_cs",
								}, -- [8]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
								}, -- [9]
								["n"] = 9,
							},
							["DurationMax"] = 2,
							["Enabled"] = true,
						}, -- [42]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTC7Mb45nXX",
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Unit"] = "target",
									["Name"] = "execute",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "SPELLCD",
									["Operator"] = "<",
									["Name"] = "12294",
									["Level"] = 3.5,
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 30,
								}, -- [3]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 5,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [4]
								{
									["Type"] = "MHSWING",
									["PrtsAfter"] = 2,
									["Operator"] = "<",
									["Level"] = 2,
								}, -- [5]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "7384",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2XiEgf",
								}, -- [7]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 2,
									["Name"] = "22407",
								}, -- [8]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RTBzFiJhwQj",
								}, -- [9]
								["n"] = 9,
							},
							["DurationMax"] = 2,
							["Enabled"] = true,
						}, -- [43]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTBxKd4NdPL",
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Operator"] = "<",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 3.5,
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Name"] = "12294",
									["PrtsBefore"] = 2,
									["Level"] = 30,
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 5,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "MHSWING",
									["PrtsAfter"] = 2,
									["Operator"] = "<",
									["Level"] = 2,
								}, -- [4]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
									["Name"] = "262228",
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
									["Name"] = "execute",
								}, -- [6]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2Rvc8H",
								}, -- [7]
								["n"] = 7,
							},
							["DurationMax"] = 2,
							["Enabled"] = true,
						}, -- [44]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "260643",
							["ClockGCD"] = true,
							["DurationMaxEnabled"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTBxKd5Ox2K",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = "<=",
									["Level"] = 60,
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22371",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGe00HwCayk",
								}, -- [3]
								["n"] = 3,
							},
							["DurationMax"] = 2,
							["Enabled"] = true,
						}, -- [45]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]",
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTBxKd6Np0=",
							["Conditions"] = {
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "7384",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "SPELLCD",
									["Operator"] = "<",
									["Name"] = "12294",
									["Level"] = 1.5,
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Name"] = "12294",
									["PrtsBefore"] = 2,
									["Level"] = 30,
								}, -- [3]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 5,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [4]
								{
									["Type"] = "MHSWING",
									["PrtsAfter"] = 2,
									["Operator"] = "<",
									["Level"] = 2,
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
									["Name"] = "262228",
									["AndOr"] = "OR",
								}, -- [6]
								{
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
									["Name"] = "execute",
								}, -- [7]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGeD0uAObsB",
								}, -- [8]
								["n"] = 8,
							},
							["DurationMax"] = 2,
							["Enabled"] = true,
						}, -- [46]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "7384",
							["ClockGCD"] = true,
							["DurationMaxEnabled"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTBxKd7Msy4",
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTC8jApfn=I",
								}, -- [1]
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["PrtsBefore"] = 2,
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Name"] = "testofmight",
								}, -- [3]
								{
									["Type"] = "COUNTER",
									["AndOr"] = "OR",
									["Name"] = "execute",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [4]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 2,
									["Operator"] = "<",
									["Level"] = 35,
								}, -- [5]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2XiEgf",
								}, -- [6]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1Rg0on0B7Owq",
								}, -- [7]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Name"] = "298357",
									["Level"] = 1.5,
								}, -- [8]
								["n"] = 8,
							},
							["DurationMax"] = 2,
							["Enabled"] = true,
						}, -- [47]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "7384",
							["ClockGCD"] = true,
							["GUID"] = "TMW:icon:1Rg1qywrOCAo",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["PrtsBefore"] = 2,
								}, -- [1]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = "<",
									["PrtsBefore"] = 2,
									["Level"] = 40,
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
									["Unit"] = "target",
									["Name"] = "208086",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 2,
									["Operator"] = "<",
									["Level"] = 2,
									["Unit"] = "target",
									["Name"] = "208086",
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Level"] = 1,
									["Name"] = "testofmight",
									["AndOr"] = "OR",
								}, -- [6]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1Rg0on0B7Owq",
								}, -- [7]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2XiEgf",
								}, -- [8]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Name"] = "298357",
									["Level"] = 1.5,
								}, -- [9]
								["n"] = 9,
							},
							["Enabled"] = true,
						}, -- [48]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "163201",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">",
									["Name"] = "163201",
									["PrtsBefore"] = 5,
									["Level"] = 20,
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [2]
								{
									["Type"] = "MHSWING",
									["PrtsAfter"] = 2,
									["Operator"] = "<",
									["Level"] = 2,
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
									["Name"] = "262228",
									["AndOr"] = "OR",
								}, -- [4]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["PrtsBefore"] = 2,
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "HEALTH",
									["PrtsAfter"] = 1,
									["Operator"] = "<",
									["Unit"] = "target",
									["Level"] = 20,
								}, -- [6]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [7]
								{
									["Type"] = "REACT",
									["Unit"] = "target",
									["Level"] = 1,
								}, -- [8]
								{
									["Type"] = "HEALTH",
									["PrtsAfter"] = 3,
									["Operator"] = "<",
									["Unit"] = "target",
									["Level"] = 35,
								}, -- [9]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "52437",
									["AndOr"] = "OR",
								}, -- [10]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
									["PrtsBefore"] = 2,
								}, -- [11]
								{
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 1,
									["Name"] = "281000",
								}, -- [12]
								{
									["Type"] = "TALENTLEARNED",
									["AndOr"] = "OR",
									["Name"] = "22380",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [13]
								{
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 4,
									["Name"] = "163201",
								}, -- [14]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2IFjGf",
								}, -- [15]
								["n"] = 15,
							},
							["GUID"] = "TMW:icon:1RTBxKd8OIaD",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [49]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "1680",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22489",
									["PrtsBefore"] = 1,
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["PrtsBefore"] = 1,
									["Level"] = 5,
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 2,
									["Operator"] = "~=",
									["Name"] = "262228",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "HEALTH",
									["Operator"] = ">",
									["Unit"] = "target",
									["Level"] = 20,
								}, -- [4]
								{
									["Type"] = "SPELLCD",
									["Operator"] = ">",
									["Name"] = "12294",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [7]
								{
									["Type"] = "SPELLCD",
									["Operator"] = ">",
									["Name"] = "167105",
									["PrtsBefore"] = 2,
									["Level"] = 15,
								}, -- [8]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
									["Level"] = 1,
								}, -- [9]
								{
									["Type"] = "SPELLCD",
									["Operator"] = ">",
									["AndOr"] = "OR",
									["Name"] = "262161",
									["PrtsBefore"] = 1,
									["Level"] = 15,
								}, -- [10]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [11]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 4,
									["Operator"] = ">",
									["Level"] = 40,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [12]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2dIykT",
								}, -- [13]
								["n"] = 13,
							},
							["GUID"] = "TMW:icon:1RTBxKd9OUM_",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [50]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "1464",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22489",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["PrtsBefore"] = 1,
									["Level"] = 5,
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsAfter"] = 2,
									["Operator"] = "~=",
									["Name"] = "262228",
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "HEALTH",
									["Operator"] = ">",
									["Unit"] = "target",
									["Level"] = 20,
								}, -- [4]
								{
									["Type"] = "SPELLCD",
									["Operator"] = ">",
									["Name"] = "12294",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [7]
								{
									["Type"] = "SPELLCD",
									["Operator"] = ">",
									["Name"] = "167105",
									["PrtsBefore"] = 2,
									["Level"] = 15,
								}, -- [8]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
									["Level"] = 1,
								}, -- [9]
								{
									["Type"] = "SPELLCD",
									["Operator"] = ">",
									["AndOr"] = "OR",
									["Name"] = "262161",
									["PrtsBefore"] = 1,
									["Level"] = 15,
								}, -- [10]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [11]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 4,
									["Operator"] = ">",
									["Level"] = 40,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [12]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGeIgsJQX0r",
								}, -- [13]
								["n"] = 13,
							},
							["GUID"] = "TMW:icon:1RTBxKdANcIS",
							["Enabled"] = true,
							["FakeHidden"] = true,
						}, -- [51]
						nil, -- [52]
						nil, -- [53]
						nil, -- [54]
						nil, -- [55]
						nil, -- [56]
						nil, -- [57]
						nil, -- [58]
						{
							["Type"] = "conditionicon",
							["Enabled"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Predict",
									},
								},
							},
							["CustomTex"] = "NONE",
							["FakeHidden"] = true,
						}, -- [59]
						nil, -- [60]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["ShowTimerText"] = true,
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1QvCpZlkrDFs",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Name"] = "227847",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "21667",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
						}, -- [61]
						nil, -- [62]
						nil, -- [63]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["ShowTimerText"] = true,
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1RGePhvZnHAy",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Name"] = "107574",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22397",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGePi2spDfn",
								}, -- [3]
								["n"] = 3,
							},
						}, -- [64]
						{
							["ShowTimer"] = true,
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22397",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1RGePi2spDfn",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["Name"] = "107574",
							["FakeHidden"] = true,
							["Enabled"] = true,
						}, -- [65]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["ShowTimerText"] = true,
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1RGePi2vizrO",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Name"] = "262228",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22399",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGePi2zBPNT",
								}, -- [3]
								["n"] = 3,
							},
						}, -- [66]
						{
							["ShowTimer"] = true,
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22399",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1RGePi2zBPNT",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["Name"] = "262228",
							["FakeHidden"] = true,
							["Enabled"] = true,
						}, -- [67]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["ShowTimerText"] = true,
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1RGfOgkWiSuM",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Name"] = "152277",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "21667",
								}, -- [2]
								["n"] = 2,
							},
						}, -- [68]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["ShowTimerText"] = true,
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1Rg0QjwlDIk1",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Name"] = "167105",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22391",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
						}, -- [69]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["ShowTimerText"] = true,
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1Rg0QjwmXRyU",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Name"] = "262161",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22391",
								}, -- [2]
								["n"] = 2,
							},
						}, -- [70]
						nil, -- [71]
						{
							["Type"] = "buff",
							["ShowTTText"] = true,
							["Name"] = "275540",
							["Enabled"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0)]",
									},
								},
							},
							["GUID"] = "TMW:icon:1TCHfoi=WAuc",
						}, -- [72]
						nil, -- [73]
						nil, -- [74]
						nil, -- [75]
						nil, -- [76]
						nil, -- [77]
						nil, -- [78]
						{
							["Type"] = "conditionicon",
							["Enabled"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Cooldowns",
									},
								},
							},
							["CustomTex"] = "NONE",
							["FakeHidden"] = true,
						}, -- [79]
						{
							["Enabled"] = true,
						}, -- [80]
						{
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1RTD2ohayX3V",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"1", -- [2]
									},
								},
							},
							["CustomTex"] = "12294",
							["FakeHidden"] = true,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
								}, -- [1]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RZ8uyGIHkyU",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1Rg1PA0lcPyA",
								}, -- [3]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
								}, -- [4]
								["n"] = 4,
							},
						}, -- [81]
						{
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1RTD2m1wLgWu",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "2",
									},
								},
							},
							["CustomTex"] = "12294",
							["FakeHidden"] = true,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
								}, -- [1]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RZ8uyGIHkyU",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1Rg1PA0lcPyA",
								}, -- [3]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
								}, -- [4]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RTBzFiJhwQj",
								}, -- [5]
								["n"] = 5,
							},
						}, -- [82]
						{
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1RTC8jAsrdvG",
							["CustomTex"] = "260643",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
								}, -- [1]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RZ8uyGIHkyU",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1Rg1PA0lcPyA",
								}, -- [3]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
								}, -- [4]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RTBzFiJhwQj",
								}, -- [5]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2Rvc8H",
								}, -- [6]
								["n"] = 6,
							},
							["Enabled"] = true,
						}, -- [83]
						{
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1RTC8jAvrtK1",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "3",
									},
								},
							},
							["CustomTex"] = "12294",
							["FakeHidden"] = true,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
								}, -- [1]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RZ8uyGIHkyU",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1Rg1PA0lcPyA",
								}, -- [3]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
								}, -- [4]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RTBzFiJhwQj",
								}, -- [5]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2Rvc8H",
								}, -- [6]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGe00HwCayk",
								}, -- [7]
								["n"] = 7,
							},
						}, -- [84]
						{
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1RTC8jApfn=I",
							["CustomTex"] = "7384",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
								}, -- [1]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RZ8uyGIHkyU",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1Rg1PA0lcPyA",
								}, -- [3]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
								}, -- [4]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RTBzFiJhwQj",
								}, -- [5]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2Rvc8H",
								}, -- [6]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGe00HwCayk",
								}, -- [7]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGeD0uAObsB",
								}, -- [8]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RTBzNx11CSK",
								}, -- [9]
								["n"] = 9,
							},
							["Enabled"] = true,
						}, -- [85]
						{
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1Rg1obpBJO85",
							["CustomTex"] = "7384",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
								}, -- [1]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RZ8uyGIHkyU",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1Rg1PA0lcPyA",
								}, -- [3]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
								}, -- [4]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RTBzFiJhwQj",
								}, -- [5]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2Rvc8H",
								}, -- [6]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGe00HwCayk",
								}, -- [7]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGeD0uAObsB",
								}, -- [8]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RTBzNx11CSK",
								}, -- [9]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2XiEgf",
								}, -- [10]
								["n"] = 10,
							},
							["Enabled"] = true,
						}, -- [86]
						{
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1RTC8jAyqkvm",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["CustomTex"] = "5308",
							["FakeHidden"] = true,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
								}, -- [1]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RZ8uyGIHkyU",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1Rg1PA0lcPyA",
								}, -- [3]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
								}, -- [4]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RTBzFiJhwQj",
								}, -- [5]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2Rvc8H",
								}, -- [6]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGe00HwCayk",
								}, -- [7]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGeD0uAObsB",
								}, -- [8]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RTBzNx11CSK",
								}, -- [9]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGdpp2XiEgf",
								}, -- [10]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1Rg0on0B7Owq",
								}, -- [11]
								["n"] = 11,
							},
						}, -- [87]
						[99] = {
							["Type"] = "conditionicon",
							["Enabled"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Predict Help",
									},
								},
							},
							["CustomTex"] = "NONE",
							["FakeHidden"] = true,
						},
						[101] = {
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["Counter"] = "arms_bs",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1RYjPWe1zjh4",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "On",
									},
								},
							},
							["GUID"] = "TMW:icon:1RYjPWe1zjh4",
							["CustomTex"] = "46924",
							["FakeHidden"] = true,
							["Enabled"] = true,
						},
						[102] = {
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["Counter"] = "arms_bs",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1RYjOKqM=xzp",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Off",
									},
								},
							},
							["GUID"] = "TMW:icon:1RYjOKqM=xzp",
							["CustomTex"] = "46924",
							["FakeHidden"] = true,
						},
						[103] = {
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["Counter"] = "arms_rav",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1RYjOKqPrqZ0",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "On",
									},
								},
							},
							["GUID"] = "TMW:icon:1RYjOKqPrqZ0",
							["CustomTex"] = "152277",
							["FakeHidden"] = true,
							["Enabled"] = true,
						},
						[104] = {
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["Counter"] = "arms_rav",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1RYjOKqSlOoj",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Off",
									},
								},
							},
							["GUID"] = "TMW:icon:1RYjOKqSlOoj",
							["CustomTex"] = "152277",
							["FakeHidden"] = true,
						},
						[105] = {
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["Counter"] = "arms_avatar",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1RYjOK3OUw0_",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "On",
									},
								},
							},
							["GUID"] = "TMW:icon:1RYjOK3OUw0_",
							["CustomTex"] = "107574",
							["FakeHidden"] = true,
							["Enabled"] = true,
						},
						[106] = {
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["Counter"] = "arms_avatar",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1RYjOK3U8Flu",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Off",
									},
								},
							},
							["GUID"] = "TMW:icon:1RYjOK3U8Flu",
							["CustomTex"] = "107574",
							["FakeHidden"] = true,
						},
						[107] = {
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["Counter"] = "arms_cs",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1RZA9mRp2XSl",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "On",
									},
								},
							},
							["GUID"] = "TMW:icon:1RZA9mRp2XSl",
							["CustomTex"] = "167105",
							["FakeHidden"] = true,
							["Enabled"] = true,
						},
						[108] = {
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["Counter"] = "arms_cs",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1RZA9mRsbOPA",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Off",
									},
								},
							},
							["GUID"] = "TMW:icon:1RZA9mRsbOPA",
							["CustomTex"] = "167105",
							["FakeHidden"] = true,
						},
						[109] = {
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["Counter"] = "testofmight",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1RZ8bU8TfXPC",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "On",
									},
								},
							},
							["GUID"] = "TMW:icon:1RZ8bU8TfXPC",
							["CustomTex"] = "275529",
							["FakeHidden"] = true,
						},
						[110] = {
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["Counter"] = "testofmight",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1RZ8bU8Z1jLS",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Off",
									},
								},
							},
							["GUID"] = "TMW:icon:1RZ8bU8Z1jLS",
							["CustomTex"] = "275529",
							["FakeHidden"] = true,
							["Enabled"] = true,
						},
						[119] = {
							["Type"] = "conditionicon",
							["Enabled"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Cooldown Toggles",
									},
								},
							},
							["CustomTex"] = "NONE",
							["FakeHidden"] = true,
						},
						[121] = {
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1T3cIanoF_i6",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["Counter"] = "border_toggle",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1T3cIanoF_i6",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "on",
									},
								},
							},
							["CustomTex"] = "143612",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "settings_toggle",
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
						},
						[122] = {
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1T3cIasRc1aj",
							["Events"] = {
								{
									["Type"] = "Counter",
									["Counter"] = "border_toggle",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1T3cIasRc1aj",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "off",
									},
								},
							},
							["CustomTex"] = "143612",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "settings_toggle",
								}, -- [1]
								["n"] = 1,
							},
						},
						[123] = {
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1T3cIanoNemZ",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["Counter"] = "combat_toggle",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1T3cIanoNemZ",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "on",
									},
								},
							},
							["CustomTex"] = "88163",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "settings_toggle",
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
						},
						[124] = {
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1T3cIasS69qg",
							["Events"] = {
								{
									["Type"] = "Counter",
									["Counter"] = "combat_toggle",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1T3cIasS69qg",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "off",
									},
								},
							},
							["CustomTex"] = "88163",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "settings_toggle",
								}, -- [1]
								["n"] = 1,
							},
						},
						[125] = {
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1T3cIanoUjuz",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["Counter"] = "target_toggle",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1T3cIanoUjuz",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "on",
									},
								},
							},
							["CustomTex"] = "204219",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "settings_toggle",
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
						},
						[126] = {
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1T3cIasSZwWl",
							["Events"] = {
								{
									["Type"] = "Counter",
									["Counter"] = "target_toggle",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1T3cIasSZwWl",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "off",
									},
								},
							},
							["CustomTex"] = "204219",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "settings_toggle",
								}, -- [1]
								["n"] = 1,
							},
						},
						[133] = {
							["Type"] = "conditionicon",
							["Name"] = "403",
							["ClockGCD"] = true,
							["GUID"] = "TMW:icon:1QpP_HqMELD0",
							["Events"] = {
								{
									["AnimColor"] = "ff000000",
									["Type"] = "Animations",
									["Period"] = 0.8,
									["Animation"] = "ICONALPHAFLASH",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1QpP_HqMELD0",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["CustomTex"] = "163446",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "target_toggle",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
									["PrtsBefore"] = 1,
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "REACT",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
									["Level"] = 2,
									["AndOr"] = "OR",
								}, -- [3]
								["n"] = 3,
							},
							["Enabled"] = true,
						},
						[134] = {
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "403",
							["ClockGCD"] = true,
							["GUID"] = "TMW:icon:1QpNXXs1Yg0u",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["CustomTex"] = "NONE",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["Enabled"] = true,
						},
						[136] = {
							["ShowTimer"] = true,
							["OnlyMine"] = true,
							["DurationMin"] = 1,
							["Type"] = "buff",
							["Name"] = "46924; 227847",
							["DurationMinEnabled"] = true,
							["GUID"] = "TMW:icon:1RL=eAD8Kmw0",
							["FakeHidden"] = true,
							["Enabled"] = true,
						},
						[137] = {
							["ShowTimer"] = true,
							["Type"] = "buff",
							["GUID"] = "TMW:icon:1Rg0QjxDyopx",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Animation"] = "ACTVTNGLOW",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1Rg0QjxDyopx",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["FakeHidden"] = true,
							["Enabled"] = true,
							["Name"] = "6673",
						},
						[138] = {
							["Type"] = "conditionicon",
							["Name"] = "280735",
							["ClockGCD"] = true,
							["Events"] = {
								{
									["Type"] = "Counter",
									["Counter"] = "execute",
									["CounterOperation"] = "=",
									["Event"] = "OnShow",
								}, -- [1]
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["Counter"] = "execute",
									["CounterOperation"] = "=",
									["Event"] = "OnHide",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "5308",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["PrtsAfter"] = 1,
									["Operator"] = "<",
									["Unit"] = "target",
									["PrtsBefore"] = 2,
									["Level"] = 20,
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["PrtsAfter"] = 2,
									["Operator"] = "<",
									["Unit"] = "target",
									["Level"] = 35,
								}, -- [3]
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [4]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [5]
								["n"] = 5,
							},
							["Enabled"] = true,
						},
					},
					["Name"] = "Arms Profile",
					["SettingsPerView"] = {
						["icon"] = {
							["SpacingY"] = 10,
						},
					},
					["GUID"] = "TMW:group:1QvASKcpevmB",
				}, -- [1]
				{
					["Strata"] = "HIGH",
					["Point"] = {
						["y"] = -80.2499954106969,
					},
					["Scale"] = 1.31473815441132,
					["ShrinkGroup"] = true,
					["EnabledSpecs"] = {
						[72] = false,
						[73] = false,
					},
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Events"] = {
								{
									["Type"] = "Counter",
									["Counter"] = "version_#1",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ALIVE",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["Counter"] = "version_#2",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ALIVE",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [2]
								{
									["Type"] = "Counter",
									["Counter"] = "version_#3",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "ALIVE",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [3]
								["n"] = 3,
							},
							["CustomTex"] = "181573",
						}, -- [1]
					},
					["SortPriorities"] = {
						{
							["Method"] = "shown",
							["Order"] = -1,
						}, -- [1]
					},
					["Name"] = "Anchor",
					["GUID"] = "TMW:group:1Qogrdv2HV3Z",
				}, -- [2]
				{
					["BackdropColor"] = "ff000000",
					["Point"] = {
						["y"] = -57.32825844569,
						["relativeTo"] = "TMW:group:1Ov1GPZDfFXX",
						["point"] = "TOP",
						["relativePoint"] = "TOP",
						["x"] = 0.00032635226234065,
					},
					["Scale"] = 0.954276204109192,
					["Rows"] = 4,
					["TextureName"] = "Minimalist",
					["ShrinkGroup"] = true,
					["EnabledSpecs"] = {
						[72] = false,
						[73] = false,
					},
					["Columns"] = 1,
					["BackdropColor_Enable"] = true,
					["Icons"] = {
						{
							["Type"] = "value",
							["Enabled"] = true,
							["Events"] = {
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"[Value:Short]", -- [2]
									},
								},
							},
							["CustomTex"] = "NONE",
							["GUID"] = "TMW:icon:1QvB=xTL4Fxx",
						}, -- [1]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Type"] = "buff",
							["TimerBar_StartColor"] = "ffffda00",
							["ShowTTText"] = true,
							["Name"] = "208086",
							["TimerBar_EnableColors"] = true,
							["BackdropColor"] = "ff7a0000",
							["Events"] = {
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["TextLayout"] = "bar1",
									["Texts"] = {
										"[Duration:TMWFormatDuration]", -- [1]
										"[Spell]", -- [2]
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 0.5,
								}, -- [2]
							},
							["TimerBar_MiddleColor"] = "ffffda00",
							["TimerBar_CompleteColor"] = "ffffda00",
							["Enabled"] = true,
							["BackdropColor_Enable"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								["n"] = 1,
							},
						}, -- [2]
						{
							["OnlyMine"] = true,
							["Type"] = "buff",
							["ShowTTText"] = true,
							["Name"] = "275540",
							["BarDisplay_Invert"] = true,
							["BackdropColor"] = "ff7a0000",
							["Events"] = {
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["TextLayout"] = "bar1",
									["Texts"] = {
										"[Duration:TMWFormatDuration]", -- [1]
										"[Spell] [Stacks(icon=\"TMW:icon:1TCHfoi=WAuc\"):Hide(0)]", -- [2]
									},
								},
							},
							["TimerBar_MiddleColor"] = "ffff0000",
							["TimerBar_CompleteColor"] = "ffff0000",
							["Enabled"] = true,
							["TimerBar_EnableColors"] = true,
							["BackdropColor_Enable"] = true,
						}, -- [3]
						{
							["Type"] = "conditionicon",
							["TimerBar_EnableColors"] = true,
							["Events"] = {
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"[\"Ready\":Yellow]", -- [1]
										"Sweeping Strikes ", -- [2]
									},
								},
							},
							["TimerBar_CompleteColor"] = "0000ff00",
							["Enabled"] = true,
							["BackdropColor"] = "ffff6500",
							["BackdropColor_Enable"] = true,
						}, -- [4]
						{
							["OnlyMine"] = true,
							["Type"] = "buff",
							["TimerBar_StartColor"] = "ffac5d00",
							["ShowTTText"] = true,
							["Name"] = "190456",
							["TimerBar_EnableColors"] = true,
							["BackdropColor"] = "ff402200",
							["Events"] = {
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[AuraSource AuraSource]", -- [2]
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 0.5,
								}, -- [2]
							},
							["TimerBar_MiddleColor"] = "ffac5d00",
							["TimerBar_CompleteColor"] = "ffac5d00",
							["Enabled"] = true,
							["BackdropColor_Enable"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[73] = true,
									},
								}, -- [1]
								["n"] = 1,
							},
						}, -- [5]
					},
					["SortPriorities"] = {
						{
							["Method"] = "shown",
							["Order"] = -1,
						}, -- [1]
						{
							["Method"] = "id",
							["Order"] = 1,
						}, -- [2]
					},
					["Name"] = "Main Resource Bar",
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 172.4,
							["Icon"] = false,
						},
					},
					["Conditions"] = {
						{
							["Type"] = "REACT",
							["Unit"] = "target",
							["PrtsBefore"] = 3,
							["Level"] = 1,
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["Type"] = "COMBAT",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["AndOr"] = "OR",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["Level"] = 1,
						}, -- [5]
						{
							["Type"] = "COMBAT",
							["PrtsBefore"] = 2,
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 4,
							["AndOr"] = "OR",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["Level"] = 1,
						}, -- [8]
						{
							["Type"] = "VEHICLE",
							["Level"] = 1,
						}, -- [9]
						["n"] = 9,
					},
					["GUID"] = "TMW:group:1QoUgaC7I4Vd",
					["View"] = "bar",
				}, -- [3]
				{
					["Point"] = {
						["y"] = -53.132709187559,
						["relativeTo"] = "TMW:group:1Qogrdv2HV3Z",
						["point"] = "BOTTOM",
						["relativePoint"] = "TOP",
						["x"] = 0.0370833462401805,
					},
					["Scale"] = 1.75434064865112,
					["EnabledSpecs"] = {
						[72] = false,
						[73] = false,
					},
					["Columns"] = 1,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1QpP_HqMELD0", -- [1]
								"TMW:icon:1RL=eAD8Kmw0", -- [2]
								"TMW:icon:1RGdpp24C0VS", -- [3]
								"TMW:icon:1RZ8uyGIHkyU", -- [4]
								"TMW:icon:1Rg1PA0lcPyA", -- [5]
								"TMW:icon:1RGdpp2C6tbD", -- [6]
								"TMW:icon:1RTBzFiJhwQj", -- [7]
								"TMW:icon:1RGdpp2Rvc8H", -- [8]
								"TMW:icon:1RGe00HwCayk", -- [9]
								"TMW:icon:1RGeD0uAObsB", -- [10]
								"TMW:icon:1RTBzNx11CSK", -- [11]
								"TMW:icon:1RGdpp2XiEgf", -- [12]
								"TMW:icon:1Rg0on0B7Owq", -- [13]
								"TMW:icon:1RGdpp2IFjGf", -- [14]
								"TMW:icon:1RGdpp2dIykT", -- [15]
								"TMW:icon:1RGeIgsJQX0r", -- [16]
								"TMW:icon:1RJiuYRHNBx2", -- [17]
								"TMW:icon:1QpNXXs1Yg0u", -- [18]
							},
							["Events"] = {
								{
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1R6WKU2symQa",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								["n"] = 1,
							},
						}, -- [1]
					},
					["Name"] = "Main Rotation (Meta)",
					["Conditions"] = {
						{
							["Type"] = "REACT",
							["Unit"] = "target",
							["PrtsBefore"] = 3,
							["Level"] = 1,
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["Type"] = "COMBAT",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["AndOr"] = "OR",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["Level"] = 1,
						}, -- [5]
						{
							["Type"] = "COMBAT",
							["PrtsBefore"] = 2,
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 4,
							["AndOr"] = "OR",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["Level"] = 1,
						}, -- [8]
						{
							["Type"] = "VEHICLE",
							["Level"] = 1,
						}, -- [9]
						["n"] = 9,
					},
					["GUID"] = "TMW:group:1Ov1GPZDfFXX",
				}, -- [4]
				{
					["Strata"] = "LOW",
					["Point"] = {
						["relativeTo"] = "TMW:group:1QoUgaC7I4Vd",
						["point"] = "TOP",
						["relativePoint"] = "BOTTOM",
						["x"] = -0.00019878718566014,
					},
					["Scale"] = 1.11,
					["ShrinkGroup"] = true,
					["EnabledSpecs"] = {
						[72] = false,
						[73] = false,
					},
					["Columns"] = 5,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1Rg0QjwlDIk1", -- [1]
								"TMW:icon:1Rg0QjwmXRyU", -- [2]
							},
							["Events"] = {
								{
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
						}, -- [1]
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["Name"] = "6552",
							["ShowTimerText"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["Checked"] = true,
									["BitFlags"] = {
										[255] = true,
									},
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1QvCRK1mfvhk",
							["Events"] = {
								{
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Enabled"] = true,
						}, -- [2]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TCGwSQJf6Si", -- [1]
								"TMW:icon:1TCGwSQM_F8V", -- [2]
								"TMW:icon:1TCGwSQQB=Gg", -- [3]
								"TMW:icon:1TCGwSQTWJKV", -- [4]
								"TMW:icon:1TCGwbluFSqd", -- [5]
								"TMW:icon:1TCGwbpI3xSi", -- [6]
								"TMW:icon:1TCGwbsj9yqy", -- [7]
								"TMW:icon:1TCGwb8Arae7", -- [8]
								"TMW:icon:1TCGwbE7v1W2", -- [9]
								"TMW:icon:1TJYgeZA44yl", -- [10]
								"TMW:icon:1TJYgeZDuCO5", -- [11]
								"TMW:icon:1TJYgeZHhayk", -- [12]
								"TMW:icon:1TJYgeZLEvOZ", -- [13]
								"TMW:icon:1TJYgeZOxgWY", -- [14]
								"TMW:icon:1TJYgeZSRTyW", -- [15]
								"TMW:icon:1TJYiuKyQaeN", -- [16]
								"TMW:icon:1TJYiuL2cxqa", -- [17]
								"TMW:icon:1TJYiuLAVaiv", -- [18]
							},
							["Events"] = {
								{
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
						}, -- [3]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1QvCpZlkrDFs", -- [1]
								"TMW:icon:1RGfOgkWiSuM", -- [2]
							},
							["Events"] = {
								{
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
						}, -- [4]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1RGePhvZnHAy", -- [1]
								"TMW:icon:1RGePi2spDfn", -- [2]
								"TMW:icon:1RGePi2vizrO", -- [3]
								"TMW:icon:1RGePi2zBPNT", -- [4]
							},
							["Events"] = {
								{
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
						}, -- [5]
					},
					["SortPriorities"] = {
						{
							["Method"] = "shown",
							["Order"] = -1,
						}, -- [1]
						{
							["Method"] = "id",
							["Order"] = 1,
						}, -- [2]
					},
					["Name"] = "Cooldown Bar (Bottom)",
					["Conditions"] = {
						{
							["Type"] = "REACT",
							["Unit"] = "target",
							["PrtsBefore"] = 3,
							["Level"] = 1,
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["Type"] = "COMBAT",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["AndOr"] = "OR",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["Level"] = 1,
						}, -- [5]
						{
							["Type"] = "COMBAT",
							["PrtsBefore"] = 2,
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 4,
							["AndOr"] = "OR",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["Level"] = 1,
						}, -- [8]
						{
							["Type"] = "VEHICLE",
							["Level"] = 1,
						}, -- [9]
						["n"] = 9,
					},
					["GUID"] = "TMW:group:1QvCPR5qcfPC",
				}, -- [5]
				{
					["View"] = "bar",
					["Point"] = {
						["y"] = 0.000163693677429945,
						["relativeTo"] = "TMW:group:1T1lA4Tqg1qw",
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPRIGHT",
						["x"] = -38,
					},
					["Scale"] = 1.0708874464035,
					["Rows"] = 12,
					["TimerBar_CompleteColor"] = "ff008fff",
					["Locked"] = true,
					["EnabledSpecs"] = {
						[64] = false,
						[63] = false,
						[72] = false,
						[73] = false,
					},
					["TimerBar_EnableColors"] = true,
					["Columns"] = 1,
					["BackdropColor_Enable"] = true,
					["Icons"] = {
						{
							["Type"] = "conditionicon",
							["BarDisplay_Invert"] = true,
							["TimerBar_EnableColors"] = true,
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1T1lwuRfZ3C7",
								}, -- [1]
								["n"] = 1,
							},
							["BarDisplay_Reverse"] = true,
							["ConditionDur"] = 5,
							["SettingsPerView"] = {
								["bar"] = {
									["TextLayout"] = "bar1",
									["Texts"] = {
										"", -- [1]
										"[\"IN COMBAT!\":Yellow] Closing Menu in [Duration(\"TMW:icon:1T1lwuRfZ3C7\"):VeryShort]", -- [2]
									},
								},
							},
							["CustomTex"] = "NONE",
							["TimerBar_CompleteColor"] = "ff886332",
							["Enabled"] = true,
						}, -- [1]
						{
							["Type"] = "conditionicon",
							["BarDisplay_Invert"] = true,
							["TimerBar_EnableColors"] = true,
							["BarDisplay_Reverse"] = true,
							["ConditionDur"] = 5,
							["SettingsPerView"] = {
								["bar"] = {
									["TextLayout"] = "bar1",
									["Texts"] = {
										"", -- [1]
										"UI Options", -- [2]
									},
								},
							},
							["CustomTex"] = "NONE",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["TimerBar_CompleteColor"] = "ff463f5e",
							["Enabled"] = true,
						}, -- [2]
						{
							["Type"] = "conditionicon",
							["Enabled"] = true,
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 121\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 122\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\n\n",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Fade"] = false,
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
								}, -- [2]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff00fff1",
									["Type"] = "Animations",
									["OnlyShown"] = true,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [3]
								["n"] = 3,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"Toggle Borders for All Icons", -- [2]
									},
								},
							},
							["CustomTex"] = "NONE",
						}, -- [3]
						{
							["Type"] = "conditionicon",
							["Enabled"] = true,
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 123\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 124\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\n\n",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Fade"] = false,
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "combat_toggle",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
								}, -- [2]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff00fff1",
									["Type"] = "Animations",
									["OnlyShown"] = true,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [3]
								["n"] = 3,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"Only Show While in Combat", -- [2]
									},
								},
							},
							["CustomTex"] = "NONE",
						}, -- [4]
						{
							["Type"] = "conditionicon",
							["Enabled"] = true,
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 125\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 126\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\n\n",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Fade"] = false,
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "target_toggle",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
								}, -- [2]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff00fff1",
									["Type"] = "Animations",
									["OnlyShown"] = true,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [3]
								["n"] = 3,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"Only Show With Hostile Target", -- [2]
									},
								},
							},
							["CustomTex"] = "NONE",
						}, -- [5]
						{
							["Type"] = "conditionicon",
							["BarDisplay_Invert"] = true,
							["TimerBar_EnableColors"] = true,
							["BarDisplay_Reverse"] = true,
							["ConditionDur"] = 5,
							["SettingsPerView"] = {
								["bar"] = {
									["TextLayout"] = "bar1",
									["Texts"] = {
										"", -- [1]
										"Class Options", -- [2]
									},
								},
							},
							["CustomTex"] = "NONE",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["TimerBar_CompleteColor"] = "ff463f5e",
							["Enabled"] = true,
						}, -- [6]
						{
							["Type"] = "conditionicon",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								["n"] = 1,
							},
							["BarDisplay_Reverse"] = true,
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"Arms", -- [2]
									},
								},
							},
							["CustomTex"] = "12294",
							["BarDisplay_Invert"] = true,
						}, -- [7]
						{
							["Type"] = "conditionicon",
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "21667",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["Enabled"] = true,
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 101\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 102\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Fade"] = false,
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "arms_bs",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
								}, -- [2]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff00fff1",
									["Type"] = "Animations",
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [3]
								["n"] = 3,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"AoE/Single", -- [1]
										"Blade Storm", -- [2]
									},
								},
							},
							["CustomTex"] = "NONE",
						}, -- [8]
						{
							["Type"] = "conditionicon",
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "21667",
								}, -- [2]
								["n"] = 2,
							},
							["Enabled"] = true,
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 103\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 104\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Fade"] = false,
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "arms_rav",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
								}, -- [2]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff00fff1",
									["Type"] = "Animations",
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [3]
								["n"] = 3,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"AoE", -- [1]
										"Ravager", -- [2]
									},
								},
							},
							["CustomTex"] = "NONE",
						}, -- [9]
						{
							["Type"] = "conditionicon",
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 105\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 106\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Fade"] = false,
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "arms_avatar",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
								}, -- [2]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff00fff1",
									["Type"] = "Animations",
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [3]
								["n"] = 3,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"Single", -- [1]
										"Avatar", -- [2]
									},
								},
							},
							["CustomTex"] = "NONE",
						}, -- [10]
						{
							["Type"] = "conditionicon",
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 107\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 108\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Fade"] = false,
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "arms_cs",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
								}, -- [2]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff00fff1",
									["Type"] = "Animations",
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [3]
								["n"] = 3,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"Single", -- [1]
										"Colossus Smash/Warbreaker", -- [2]
									},
								},
							},
							["CustomTex"] = "NONE",
						}, -- [11]
						{
							["Type"] = "conditionicon",
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 109\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 110\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Fade"] = false,
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "testofmight",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
								}, -- [2]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "7f00ff1d",
									["Fade"] = false,
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "testofmight",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [3]
								{
									["AnimColor"] = "ff00fff1",
									["Type"] = "Animations",
									["Animation"] = "ICONFLASH",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [4]
								["n"] = 4,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"[\"Azerite\":Yellow]", -- [1]
										"Test of Might", -- [2]
									},
								},
							},
							["CustomTex"] = "NONE",
						}, -- [12]
					},
					["SortPriorities"] = {
						{
							["Method"] = "shown",
							["Order"] = -1,
						}, -- [1]
						{
							["Method"] = "id",
							["Order"] = 1,
						}, -- [2]
					},
					["Name"] = "Cooldown Menu",
					["SettingsPerView"] = {
						["bar"] = {
							["BorderBar"] = 2,
							["SizeX"] = 245.04655456543,
							["Icon"] = false,
						},
					},
					["ShrinkGroup"] = true,
					["Conditions"] = {
						{
							["Type"] = "COUNTER",
							["Name"] = "menu_open",
							["Level"] = 1,
						}, -- [1]
						["n"] = 1,
					},
					["BackdropColor"] = "00333333",
					["GUID"] = "TMW:group:1T3cKuwHQNun",
				}, -- [6]
				{
					["Strata"] = "LOW",
					["Point"] = {
						["y"] = 14.9995957008774,
						["x"] = 1.74517393112183,
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
					},
					["Scale"] = 1.36504948139191,
					["EnabledSpecs"] = {
						[64] = false,
						[73] = false,
						[259] = false,
						[260] = false,
						[63] = false,
						[72] = false,
					},
					["Columns"] = 2,
					["Icons"] = {
						{
							["Type"] = "conditionicon",
							["Enabled"] = true,
							["Events"] = {
								{
									["Type"] = "Counter",
									["Counter"] = "menu_open",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["Type"] = "Counter",
									["Counter"] = "menu_open",
									["Event"] = "OnRightClick",
								}, -- [2]
								{
									["Type"] = "Counter",
									["Counter"] = "menu_open",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["CounterAmt"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Operator"] = ">=",
											["Name"] = "menu_open",
											["Level"] = 2,
										}, -- [1]
										["n"] = 1,
									},
									["Frequency"] = 0.2,
								}, -- [3]
								{
									["Type"] = "Counter",
									["Counter"] = "settings_help",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [4]
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["Counter"] = "settings_help",
									["CounterOperation"] = "=",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
								}, -- [5]
								{
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [6]
								["n"] = 6,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["CustomTex"] = "232283",
						}, -- [1]
						{
							["Type"] = "conditionicon",
							["ShowTimerText"] = true,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Level"] = 1,
									["Name"] = "menu_open_c",
									["AndOr"] = "OR",
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDur"] = 5,
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "bar1",
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1T1lwuRfZ3C7",
							["CustomTex"] = "Attack",
							["FakeHidden"] = true,
							["OnlyIfCounting"] = true,
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["Counter"] = "menu_open",
									["CounterOperation"] = "=",
									["Event"] = "OnHide",
								}, -- [1]
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["Counter"] = "menu_open_c",
									["CounterOperation"] = "=",
									["Event"] = "OnHide",
								}, -- [2]
								{
									["Type"] = "Counter",
									["Counter"] = "menu_open_c",
									["Event"] = "OnCondition",
									["OnConditionConditions"] = {
										{
											["Type"] = "COMBAT",
										}, -- [1]
										{
											["Type"] = "COUNTER",
											["Name"] = "menu_open",
											["Level"] = 1,
										}, -- [2]
										["n"] = 2,
									},
								}, -- [3]
								["n"] = 3,
							},
							["ConditionDurEnabled"] = true,
						}, -- [2]
					},
					["LayoutDirection"] = 4,
					["EnabledProfiles"] = {
						["Maverin - Area 52"] = false,
					},
					["Name"] = "Cooldown Menu Button",
					["GUID"] = "TMW:group:1T1lA4Tqg1qw",
				}, -- [7]
				{
					["GUID"] = "TMW:group:1T3cQ7dMw8S1",
					["Strata"] = "HIGH",
					["Point"] = {
						["relativeTo"] = "TMW:group:1QoUgaC7I4Vd",
						["point"] = "BOTTOM",
						["relativePoint"] = "BOTTOM",
					},
					["Scale"] = 0.954276204109192,
					["Rows"] = 2,
					["TextureName"] = "Minimalist",
					["EnabledSpecs"] = {
						[72] = false,
						[73] = false,
					},
					["Columns"] = 1,
					["BackdropColor_Enable"] = true,
					["Icons"] = {
						{
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["TimerBar_StartColor"] = "ff000000",
							["ShowTimerText"] = true,
							["GUID"] = "TMW:icon:1RGeD16VQQ=Z",
							["Name"] = "260708",
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Type"] = "ICON",
									["Level"] = 1,
									["Icon"] = "TMW:icon:1RGeD16XRQTK",
								}, -- [2]
								["n"] = 2,
							},
							["TimerBar_EnableColors"] = true,
							["BackdropColor"] = "00ff6500",
							["BarDisplay_Reverse"] = true,
							["Events"] = {
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ffffff00",
									["PassingCndt"] = true,
									["Type"] = "Animations",
									["CndtJustPassed"] = true,
									["OnlyShown"] = true,
									["Value"] = 1,
									["Animation"] = "ICONALPHAFLASH",
									["Event"] = "OnDuration",
									["Operator"] = "<=",
								}, -- [1]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ffffff00",
									["PassingCndt"] = true,
									["Type"] = "Animations",
									["CndtJustPassed"] = true,
									["OnlyShown"] = true,
									["Value"] = 1,
									["Animation"] = "ICONBORDER",
									["Event"] = "OnDuration",
									["Operator"] = "<=",
								}, -- [2]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [3]
								["n"] = 3,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
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
							},
							["TimerBar_MiddleColor"] = "ff000000",
							["TimerBar_CompleteColor"] = "ff000000",
							["Enabled"] = true,
							["BarDisplay_FakeMax"] = 18,
							["BackdropColor_Enable"] = true,
						}, -- [1]
						{
							["ShowTimer"] = true,
							["Type"] = "buff",
							["TimerBar_StartColor"] = "ffffda00",
							["Name"] = "260708",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								["n"] = 1,
							},
							["TimerBar_EnableColors"] = true,
							["GUID"] = "TMW:icon:1RGeD16XRQTK",
							["Events"] = {
								{
									["AnimColor"] = "ffffff00",
									["PassingCndt"] = true,
									["Type"] = "Animations",
									["CndtJustPassed"] = true,
									["OnlyShown"] = true,
									["Animation"] = "ICONBORDER",
									["Event"] = "OnDuration",
									["Operator"] = ">",
									["Infinite"] = true,
								}, -- [1]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [2]
								{
									["Type"] = "Animations",
									["Animation"] = "ICONCLEAR",
									["Event"] = "OnHide",
								}, -- [3]
								["n"] = 3,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
								["bar"] = {
									["TextLayout"] = "bar1",
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_MiddleColor"] = "ffffa500",
							["TimerBar_CompleteColor"] = "ffff6500",
							["ShowTimerText"] = true,
						}, -- [2]
					},
					["SortPriorities"] = {
						{
							["Method"] = "fakehidden",
						}, -- [1]
						{
							["Method"] = "shown",
							["Order"] = -1,
						}, -- [2]
						{
							["Method"] = "id",
							["Order"] = 1,
						}, -- [3]
					},
					["LayoutDirection"] = 4,
					["Name"] = "Sweeping Strikes CD",
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 172.4,
							["Icon"] = false,
						},
					},
					["Conditions"] = {
						{
							["Type"] = "REACT",
							["Unit"] = "target",
							["PrtsBefore"] = 3,
							["Level"] = 1,
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["Type"] = "COMBAT",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["AndOr"] = "OR",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["Level"] = 1,
						}, -- [5]
						{
							["Type"] = "COMBAT",
							["PrtsBefore"] = 2,
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 4,
							["AndOr"] = "OR",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["Level"] = 1,
						}, -- [8]
						{
							["Type"] = "VEHICLE",
							["Level"] = 1,
						}, -- [9]
						["n"] = 9,
					},
					["View"] = "bar",
					["BackdropColor"] = "ff000000",
				}, -- [8]
				{
					["Strata"] = "LOW",
					["Point"] = {
						["y"] = -3,
						["x"] = 1.171682344764670e-05,
						["relativeTo"] = "TMW:group:1Ov1GPZDfFXX",
					},
					["Scale"] = 1.5,
					["EnabledSpecs"] = {
						[73] = false,
						[72] = false,
					},
					["Columns"] = 2,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1RL=eAHTYJcw", -- [1]
								"TMW:icon:1RL=eAHUbY_S", -- [2]
								"TMW:icon:1RL=eAHVfoHi", -- [3]
								"TMW:icon:1RTCMxEg4qi8", -- [4]
								"TMW:icon:1RTCN7EH5rEt", -- [5]
								"TMW:icon:1RL=eAHXlHCC", -- [6]
								"TMW:icon:1RL=eAHYlywP", -- [7]
								"TMW:icon:1RL=eAHaq80u", -- [8]
								"TMW:icon:1Ra7fP21bk42", -- [9]
								"TMW:icon:1RTCPcVTM2Je", -- [10]
								"TMW:icon:1RL=eAHZoKRG", -- [11]
								"TMW:icon:1RL=eAHWk5Yo", -- [12]
								"TMW:icon:1RL=eAHbqFqW", -- [13]
								"TMW:icon:1RL=eAHcqhaW", -- [14]
								"TMW:icon:1QpNXXs1Yg0u", -- [15]
							},
							["Events"] = {
								{
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1R6WVznvrf0C",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								["n"] = 1,
							},
						}, -- [1]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1RTBxKd1K0Rf", -- [1]
								"TMW:icon:1RTBxKd2Ohfq", -- [2]
								"TMW:icon:1RTC7Mb45nXX", -- [3]
								"TMW:icon:1RTBxKd4NdPL", -- [4]
								"TMW:icon:1RTBxKd5Ox2K", -- [5]
								"TMW:icon:1RTBxKd6Np0=", -- [6]
								"TMW:icon:1RTBxKd7Msy4", -- [7]
								"TMW:icon:1Rg1qywrOCAo", -- [8]
								"TMW:icon:1RTBxKd8OIaD", -- [9]
								"TMW:icon:1RTBxKd9OUM_", -- [10]
								"TMW:icon:1RTBxKdANcIS", -- [11]
								"TMW:icon:1QpNXXs1Yg0u", -- [12]
							},
							["Events"] = {
								{
									["AnimColor"] = "ff000000",
									["Fade"] = false,
									["Type"] = "Animations",
									["Thickness"] = 3,
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["Infinite"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1R6WB=OACwE4",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								["n"] = 1,
							},
						}, -- [2]
					},
					["LayoutDirection"] = 4,
					["Name"] = "AoE/Predict Rotation",
					["SettingsPerView"] = {
						["icon"] = {
							["SpacingX"] = 50,
						},
					},
					["Conditions"] = {
						{
							["Type"] = "REACT",
							["Unit"] = "target",
							["PrtsBefore"] = 3,
							["Level"] = 1,
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["Type"] = "COMBAT",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["AndOr"] = "OR",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["Level"] = 1,
						}, -- [5]
						{
							["Type"] = "COMBAT",
							["PrtsBefore"] = 2,
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 4,
							["AndOr"] = "OR",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["Level"] = 1,
						}, -- [8]
						{
							["Type"] = "VEHICLE",
							["Level"] = 1,
						}, -- [9]
						["n"] = 9,
					},
					["GUID"] = "TMW:group:1T3cM2MZ41y7",
				}, -- [9]
			},
			["WarnInvalids"] = false,
		},
		["Warrior"] = {
			["Groups"] = {
				{
					["Point"] = {
						["y"] = -88,
						["x"] = 4.069010416666670e-05,
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
								"TMW:icon:1TZvNvflXM0_", -- [1]
								"TMW:icon:1TWZdpV26rm5", -- [2]
								"TMW:icon:1TU=hLnlwyeY", -- [3]
								"TMW:icon:1TQv_Ltf40Wl", -- [4]
								"TMW:icon:1TQv_LtTwAae", -- [5]
								"TMW:icon:1TQv_Lti1RyX", -- [6]
							},
							["Name"] = "Rend",
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
							},
							["Enabled"] = true,
						}, -- [1]
						{
							["Sort"] = -1,
							["DurationMin"] = 15,
							["Type"] = "buff",
							["Name"] = "Battle Shout",
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
							["DurationMinEnabled"] = true,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 10,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [2]
					},
					["SortPriorities"] = {
						{
							["Order"] = -1,
						}, -- [1]
					},
					["LayoutDirection"] = 2,
					["Name"] = "Warrior Rotation",
					["SettingsPerView"] = {
						["icon"] = {
							["BorderInset"] = false,
							["BorderColor"] = "00000000",
						},
					},
					["GUID"] = "TMW:group:1TQuFk14Ix42",
				}, -- [1]
				{
					["Scale"] = 1,
					["Locked"] = true,
					["GUID"] = "TMW:group:1TQvxnAfbGyU",
					["Columns"] = 20,
					["Icons"] = {
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Type"] = "buff",
							["Name"] = "Rend",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 10,
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1TQv_LtTwAae",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Enabled"] = true,
						}, -- [1]
						{
							["Type"] = "buff",
							["Name"] = "Battle Shout",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 10,
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Operator"] = "<=",
									["Name"] = "Battle Shout",
									["Level"] = 15,
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1TQv_Ltf40Wl",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Enabled"] = true,
						}, -- [2]
						{
							["Type"] = "reactive",
							["Name"] = "Heroic Strike",
							["GUID"] = "TMW:icon:1TQv_Lti1RyX",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 20,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [3]
						{
							["Type"] = "cooldown",
							["ShowTimerText"] = true,
							["Name"] = "Overpower",
							["GUID"] = "TMW:icon:1TU=hLnlwyeY",
							["RangeCheck"] = true,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "REACTIVE",
									["Checked"] = true,
									["Name"] = "Overpower",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [4]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Type"] = "buff",
							["Name"] = "Demoralizing Shout",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 10,
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
							["Enabled"] = true,
						}, -- [5]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["Name"] = "Sunder Armor",
							["GUID"] = "TMW:icon:1TYYu4EDbfSz",
							["Enabled"] = true,
						}, -- [6]
						{
							["Type"] = "reactive",
							["Name"] = "Execute",
							["GUID"] = "TMW:icon:1TZvNvflXM0_",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Operator"] = ">=",
									["Level"] = 15,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [7]
						[20] = {
							["BuffOrDebuff"] = "HARMFUL",
							["GUID"] = "TMW:icon:1TWYMfcUzmi6",
						},
					},
					["Name"] = "Warrior Spells",
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Alpha"] = 0,
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Scale"] = 1.5,
					["TextureName"] = "Details Flat",
					["Columns"] = 1,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TZvNvgAkfmq", -- [1]
								"TMW:icon:1TWYSTcSCl0z", -- [2]
							},
							["Enabled"] = true,
						}, -- [1]
					},
					["Name"] = "Other",
					["Point"] = {
						["y"] = -20,
						["x"] = -230,
					},
				}, -- [3]
				{
					["Scale"] = 1,
					["TextureName"] = "Details Flat",
					["Locked"] = true,
					["GUID"] = "TMW:group:1TWYSTcQ410f",
					["Columns"] = 20,
					["Alpha"] = 0,
					["Name"] = "General Buffs/Debbufs",
					["Point"] = {
						["y"] = -40,
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
							["Enabled"] = true,
						}, -- [1]
						{
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["Name"] = "Enrage",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1TZve345g=GK",
								},
							},
							["GUID"] = "TMW:icon:1TZvNvgAkfmq",
							["Enabled"] = true,
						}, -- [2]
					},
				}, -- [4]
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Scale"] = 1,
					["Columns"] = 20,
					["Icons"] = {
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["Name"] = "Serpent Sting",
							["OnlyMine"] = true,
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["Enabled"] = true,
						}, -- [1]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["Name"] = "Hunter's Mark",
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["Enabled"] = true,
						}, -- [2]
					},
					["Name"] = "Hunter Spells",
					["Point"] = {
						["y"] = -75,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Alpha"] = 0,
				}, -- [5]
				{
					["GUID"] = "TMW:group:1TeVDtajUwqa",
					["Scale"] = 1.5,
					["Columns"] = 3,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TeVAjjavXC6", -- [1]
							},
							["Enabled"] = true,
						}, -- [1]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TeVAjjXQ0WB", -- [1]
							},
							["Enabled"] = true,
						}, -- [2]
					},
					["Name"] = "Hunter Rotation",
					["Point"] = {
						["y"] = -88,
						["x"] = 4.069010416666670e-05,
					},
				}, -- [6]
			},
			["NumGroups"] = 6,
			["Version"] = 86907,
			["Locked"] = true,
		},
		["Vermins - Stonespine"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TQzDMkfvbKy",
				}, -- [1]
			},
		},
		["Vermins - Dreadmist"] = {
			["Locked"] = true,
			["NumGroups"] = 2,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TQuFk14Ix42",
					["Point"] = {
						["y"] = -84.7207569193082,
						["x"] = 3.064344478241010e-05,
					},
					["Scale"] = 1.5675,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["BuffOrDebuff"] = "HARMFUL",
							["Icons"] = {
								"TMW:icon:1TQv_Ltf40Wl", -- [1]
								"TMW:icon:1TQv_LtTwAae", -- [2]
								"TMW:icon:1TQv_Lti1RyX", -- [3]
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
							["DurationMinEnabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
								}, -- [1]
								["n"] = 1,
							},
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
					["Name"] = "Main rotation",
					["SettingsPerView"] = {
						["icon"] = {
							["BorderColor"] = "00000000",
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
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TQvxnAfbGyU",
					["Columns"] = 20,
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TQv_LtTwAae",
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Rend",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
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
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1TQv_Ltf40Wl",
							["OnlyMine"] = true,
							["Name"] = "Battle Shout",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
								}, -- [1]
								["n"] = 1,
							},
							["Type"] = "buff",
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
							["GUID"] = "TMW:icon:1TQv_Lti1RyX",
							["Type"] = "reactive",
							["Name"] = "Heroic Strike",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 20,
									["Operator"] = ">=",
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
						}, -- [3]
					},
					["Scale"] = 1,
					["Name"] = "Warrior Spells",
					["Alpha"] = 0,
					["Locked"] = true,
				}, -- [2]
			},
			["Version"] = 86907,
		},
		["Vermin - Golemagg"] = {
			["Version"] = 86907,
			["NumGroups"] = 0,
		},
		["Mxzq - Golemagg"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1V2UFRKhqpW4",
				}, -- [1]
			},
		},
		["Elohssa - Stonespine"] = {
			["Locked"] = true,
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TYc6xfPRliJ",
				}, -- [1]
			},
		},
		["Judawise - Golemagg"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TYIsxVmmRur",
				}, -- [1]
			},
		},
		["Greenwise - Golemagg"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TYIh7Ul08eI",
				}, -- [1]
			},
		},
		["Korupcija - Stonespine"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TXcvt4aHNmO",
				}, -- [1]
			},
		},
		["Ozrencic - Golemagg"] = {
			["Locked"] = true,
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TVwZMDWso0m",
				}, -- [1]
			},
		},
		["Whatevs - Stonespine"] = {
			["Locked"] = true,
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TYc_p4gFW0n",
				}, -- [1]
			},
		},
	},
}
