
TellMeWhenDB = {
	["profileKeys"] = {
		["Mxzq - Golemagg"] = "Hunter",
		["Mxyz - Golemagg"] = "Priest",
		["Verminz - Golemagg"] = "Warrior",
		["Greshnik - Dreadnaught"] = "Warlock",
		["Battitude - Golemagg"] = "Battitude - Golemagg",
		["Korupcija - Stonespine"] = "Warrior",
		["Poklopac - Dreadnaught"] = "Hunter",
		["Mxym - Golemagg"] = "Priest",
		["Augustin - Golemagg"] = "Mage",
		["Grgur - Golemagg"] = "Grgur - Golemagg",
		["Koloman - Golemagg"] = "Koloman - Golemagg",
		["Vermin - Golemagg"] = "Warrior",
		["Antun - Golemagg"] = "Antun - Golemagg",
		["Moolatz - Dreadnaught"] = "Druid",
		["Handrmandr - Golemagg"] = "Handrmandr - Golemagg",
		["Vermina - Golemagg"] = "Paladin",
		["Pitchwise - Golemagg"] = "Warrior",
		["Nitwit - Dreadnaught"] = "Nitwit - Dreadnaught",
		["Paydo - Dreadmist"] = "Warrior",
		["Mxys - Golemagg"] = "Priest",
		["Vermins - Stonespine"] = "Warrior",
		["Testxv - Golemagg"] = "Testxv - Golemagg",
		["Battlearm - Hydraxian Waterlords"] = "Battlearm - Hydraxian Waterlords",
		["Mxyzptlk - Golemagg"] = "Warlock",
		["Konac - Dreadnaught"] = "Priest",
		["Pitchwise - Dreadnaught"] = "Warrior",
		["Jaroslav - Golemagg"] = "Druid",
		["Klhjakhsgdjh - Golemagg"] = "Klhjakhsgdjh - Golemagg",
		["Dmitar - Golemagg"] = "Dmitar - Golemagg",
		["Judawise - Golemagg"] = "Warrior",
		["Greenwise - Golemagg"] = "Warrior",
		["Battlearm - Golemagg"] = "Deathknight",
		["Dotwise - Golemagg"] = "Warrior",
		["Moolatz - Golemagg"] = "Druid",
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
							["point"] = "BOTTOMRIGHT",
							["relativePoint"] = "BOTTOMRIGHT",
						}, -- [1]
					},
					["StringName"] = "Stacks",
					["DefaultText"] = "[Stacks:Hide(0)]",
					["Size"] = 9,
				}, -- [2]
				{
					["Outline"] = "OUTLINE",
					["Anchors"] = {
						{
							["point"] = "BOTTOM",
							["relativePoint"] = "TOP",
						}, -- [1]
					},
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
		["Mxyz - Golemagg"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1V6oLKCIxoqJ",
				}, -- [1]
			},
		},
		["Greshnik - Dreadnaught"] = {
			["Version"] = 91200,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1XwQBe3fAdvE",
				}, -- [1]
			},
		},
		["Battitude - Golemagg"] = {
			["Locked"] = true,
			["Version"] = 92500,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1Vb7b4GP7kSB",
				}, -- [1]
			},
		},
		["Dmitar - Golemagg"] = {
			["Locked"] = true,
			["Version"] = 92500,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1VAdO9NkNZev",
				}, -- [1]
			},
		},
		["Main profile"] = {
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TQuFk14Ix42",
					["Point"] = {
						["y"] = -88,
						["x"] = 4.06901041666667e-05,
					},
					["Scale"] = 1.5,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["BuffOrDebuff"] = "HARMFUL",
							["Icons"] = {
								"TMW:icon:1TZvNvflXM0_", -- [1]
								"TMW:icon:1TWZdpV26rm5", -- [2]
								"TMW:icon:1TU=hLnlwyeY", -- [3]
								"TMW:icon:1TQv_Ltf40Wl", -- [4]
								"TMW:icon:1TQv_LtTwAae", -- [5]
								"TMW:icon:1TQv_Lti1RyX", -- [6]
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
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
								}, -- [1]
								["n"] = 1,
							},
							["DurationMin"] = 15,
							["DurationMinEnabled"] = true,
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
					["Name"] = "Warrior Rotation",
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
					["Name"] = "Warrior Spells",
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
							["Name"] = "Rend",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
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
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1TQv_Ltf40Wl",
							["Type"] = "buff",
							["Name"] = "Battle Shout",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Level"] = 15,
									["Type"] = "BUFFDUR",
									["Name"] = "Battle Shout",
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
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "reactive",
							["Name"] = "Heroic Strike",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 20,
									["Operator"] = ">=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1TQv_Lti1RyX",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
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
							["Name"] = "Overpower",
							["GUID"] = "TMW:icon:1TU=hLnlwyeY",
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
				}, -- [2]
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
								"TMW:icon:1TZvNvgAkfmq", -- [1]
								"TMW:icon:1TWYSTcSCl0z", -- [2]
							},
						}, -- [1]
					},
					["TextureName"] = "Details Flat",
				}, -- [3]
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
							["Name"] = "Blood Fury",
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
							["ShowTimerText"] = true,
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
					},
					["TextureName"] = "Details Flat",
					["Name"] = "General Buffs/Debbufs",
					["Locked"] = true,
					["Alpha"] = 0,
					["Columns"] = 20,
				}, -- [4]
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Name"] = "Hunter Spells",
					["Point"] = {
						["y"] = -75,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["OnlyMine"] = true,
							["Name"] = "Serpent Sting",
							["Enabled"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["ShowTimerText"] = true,
							["Type"] = "buff",
							["Unit"] = "target",
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["Type"] = "buff",
							["Name"] = "Hunter's Mark",
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
							["ShowTimerText"] = true,
							["Unit"] = "target",
						}, -- [2]
					},
					["Locked"] = true,
					["Columns"] = 20,
					["Alpha"] = 0,
					["Scale"] = 1,
				}, -- [5]
				{
					["GUID"] = "TMW:group:1TeVDtajUwqa",
					["Columns"] = 3,
					["Scale"] = 1.5,
					["Point"] = {
						["y"] = -88,
						["x"] = 4.06901041666667e-05,
					},
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TeVAjjavXC6", -- [1]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TeVAjjXQ0WB", -- [1]
							},
						}, -- [2]
					},
					["Name"] = "Hunter Rotation",
				}, -- [6]
				{
					["GUID"] = "TMW:group:1V6krZ0tqss=",
					["Columns"] = 1,
					["Scale"] = 1.5,
					["Point"] = {
						["y"] = -88,
					},
					["Name"] = "Warlock Rotation",
				}, -- [7]
			},
			["Version"] = 91200,
			["NumGroups"] = 7,
		},
		["Arms"] = {
			["Version"] = 91200,
			["WarnInvalids"] = false,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1QvASKcpevmB",
					["Strata"] = "HIGH",
					["Point"] = {
						["y"] = -57.2282093962039,
						["x"] = 3.52281761169434,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Scale"] = 0.600000023841858,
					["Rows"] = 7,
					["Icons"] = {
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["DurationMaxEnabled"] = true,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["Name"] = "772",
							["DurationMax"] = 3.5,
							["Type"] = "buff",
							["Conditions"] = {
								{
									["Name"] = "19138",
									["Type"] = "TALENTLEARNED",
								}, -- [1]
								{
									["Name"] = "208086",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
								}, -- [2]
								{
									["Operator"] = ">",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Unit"] = "target",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1RGdpp24C0VS",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
								[100] = {
									["Alpha"] = 0.06,
								},
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "107574",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RZ8uyGIHkyU",
							["Conditions"] = {
								{
									["Name"] = "22397",
									["Type"] = "TALENTLEARNED",
								}, -- [1]
								{
									["Name"] = "cooldown_toggle",
									["Type"] = "COUNTER",
								}, -- [2]
								{
									["Name"] = "arms_avatar",
									["Type"] = "COUNTER",
								}, -- [3]
								["n"] = 3,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [2]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "227847",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1Rg1PA0lcPyA",
							["Conditions"] = {
								{
									["Name"] = "testofmight",
									["Type"] = "COUNTER",
								}, -- [1]
								{
									["PrtsBefore"] = 3,
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 35,
									["Operator"] = "<=",
								}, -- [3]
								{
									["Name"] = "208086",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "SPELLCD",
									["Name"] = "167105",
									["PrtsBefore"] = 2,
									["Level"] = 3,
									["Operator"] = "<",
								}, -- [5]
								{
									["Type"] = "TALENTLEARNED",
									["Level"] = 1,
									["Name"] = "22391",
									["PrtsAfter"] = 1,
								}, -- [6]
								{
									["Type"] = "SPELLCD",
									["Name"] = "262161",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 3,
									["Operator"] = "<",
								}, -- [7]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 3,
									["Name"] = "22391",
								}, -- [8]
								{
									["PrtsBefore"] = 1,
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["AndOr"] = "OR",
								}, -- [9]
								{
									["PrtsBefore"] = 2,
									["Type"] = "SPELLCD",
									["Name"] = "262161",
									["Operator"] = "~=",
								}, -- [10]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [11]
								{
									["Type"] = "SPELLCD",
									["Name"] = "167105",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Operator"] = "~=",
								}, -- [12]
								{
									["Type"] = "TALENTLEARNED",
									["Level"] = 1,
									["Name"] = "22391",
									["PrtsAfter"] = 2,
								}, -- [13]
								{
									["PrtsBefore"] = 1,
									["Type"] = "LASTCAST",
									["Name"] = "262161",
									["Level"] = 1,
								}, -- [14]
								{
									["Type"] = "LASTCAST",
									["Level"] = 1,
									["Name"] = "167105",
									["PrtsAfter"] = 1,
								}, -- [15]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["PrtsBefore"] = 1,
									["Name"] = "275529",
									["Operator"] = "~=",
								}, -- [16]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "275540",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [17]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "208086",
									["PrtsAfter"] = 3,
									["Unit"] = "target",
								}, -- [18]
								{
									["Name"] = "cooldown_toggle",
									["Type"] = "COUNTER",
								}, -- [19]
								{
									["Name"] = "arms_bs",
									["Type"] = "COUNTER",
								}, -- [20]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "21667",
									["Level"] = 1,
								}, -- [21]
								["n"] = 21,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [3]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "167105",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RGdpp2C6tbD",
							["Conditions"] = {
								{
									["PrtsBefore"] = 3,
									["Type"] = "SPELLCD",
									["Name"] = "262161",
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [2]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22391",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["AndOr"] = "OR",
								}, -- [3]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
									["Level"] = 1,
								}, -- [4]
								{
									["PrtsBefore"] = 2,
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
								}, -- [5]
								{
									["Level"] = 55,
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [6]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["Level"] = 1,
									["PrtsAfter"] = 2,
									["AndOr"] = "OR",
								}, -- [7]
								{
									["Name"] = "cooldown_toggle",
									["Type"] = "COUNTER",
								}, -- [8]
								{
									["Name"] = "arms_cs",
									["Type"] = "COUNTER",
								}, -- [9]
								["n"] = 9,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [4]
						{
							["GUID"] = "TMW:icon:1RTBzFiJhwQj",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
							["Name"] = "12294",
							["DurationMax"] = 2,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["PrtsBefore"] = 1,
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [1]
								{
									["Level"] = 1,
									["Type"] = "SPELLCD",
									["Name"] = "12294",
									["Operator"] = "<",
								}, -- [2]
								{
									["Level"] = 30,
									["Type"] = "RAGE_ABS",
									["Name"] = "12294",
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["PrtsBefore"] = 2,
									["Level"] = 2,
									["Name"] = "7384",
								}, -- [4]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22407",
								}, -- [5]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Level"] = 2,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Name"] = "272866",
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Level"] = 2,
									["AndOr"] = "OR",
									["Name"] = "272867",
									["Unit"] = "target",
								}, -- [7]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Name"] = "272870",
									["Level"] = 2,
									["AndOr"] = "OR",
									["PrtsAfter"] = 3,
									["Unit"] = "target",
								}, -- [8]
								{
									["Icon"] = "TMW:icon:1RTD2ohayX3V",
									["Type"] = "ICON",
								}, -- [9]
								["n"] = 9,
							},
							["Type"] = "cooldown",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [5]
						{
							["GUID"] = "TMW:icon:1RGdpp2Rvc8H",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
							["Name"] = "12294",
							["DurationMax"] = 2,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 1,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 30,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "262228",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [3]
								{
									["Name"] = "execute",
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Icon"] = "TMW:icon:1RTD2m1wLgWu",
									["Type"] = "ICON",
								}, -- [5]
								["n"] = 5,
							},
							["Type"] = "cooldown",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [6]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "260643",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RGe00HwCayk",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 60,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Name"] = "22371",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								{
									["Icon"] = "TMW:icon:1RTC8jAsrdvG",
									["Type"] = "ICON",
								}, -- [3]
								["n"] = 3,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [7]
						{
							["GUID"] = "TMW:icon:1RGeD0uAObsB",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]",
									},
								},
							},
							["Name"] = "12294",
							["DurationMax"] = 2,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "BUFFSTACKS",
									["Level"] = 2,
									["Name"] = "7384",
									["Checked"] = true,
								}, -- [1]
								{
									["Name"] = "12294",
									["Type"] = "SPELLCD",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 30,
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "262228",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [4]
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["Unit"] = "target",
								}, -- [5]
								{
									["Icon"] = "TMW:icon:1RTC8jAvrtK1",
									["Type"] = "ICON",
								}, -- [6]
								["n"] = 6,
							},
							["Type"] = "cooldown",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [8]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "227847",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTBzNx11CSK",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = ">",
									["Level"] = 2,
									["Name"] = "208086",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["Level"] = 1,
								}, -- [2]
								{
									["PrtsBefore"] = 1,
									["Type"] = "COUNTER",
									["Name"] = "execute",
								}, -- [3]
								{
									["Type"] = "RAGE_ABS",
									["PrtsBefore"] = 1,
									["Level"] = 35,
									["AndOr"] = "OR",
									["Operator"] = "<",
								}, -- [4]
								{
									["Type"] = "COUNTER",
									["Level"] = 1,
									["Name"] = "execute",
									["PrtsAfter"] = 2,
								}, -- [5]
								{
									["Name"] = "cooldown_toggle",
									["Type"] = "COUNTER",
								}, -- [6]
								{
									["Name"] = "arms_bs",
									["Type"] = "COUNTER",
								}, -- [7]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "21667",
									["Level"] = 1,
								}, -- [8]
								["n"] = 8,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [9]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["ClockGCD"] = true,
							["Name"] = "7384",
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
									["Icon"] = "TMW:icon:1RTC8jApfn=I",
									["Type"] = "ICON",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["PrtsBefore"] = 3,
									["Name"] = "208086",
									["Unit"] = "target",
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
									["Name"] = "execute",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "7384",
									["PrtsAfter"] = 3,
									["Operator"] = "~=",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "298357",
								}, -- [7]
								["n"] = 7,
							},
							["GUID"] = "TMW:icon:1RGdpp2XiEgf",
							["Type"] = "cooldown",
						}, -- [10]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["ClockGCD"] = true,
							["Name"] = "7384",
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
									["PrtsBefore"] = 2,
									["Type"] = "COUNTER",
									["Name"] = "execute",
								}, -- [1]
								{
									["Name"] = "testofmight",
									["Type"] = "COUNTER",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "208086",
									["PrtsBefore"] = 2,
									["Operator"] = "~=",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "208086",
									["AndOr"] = "OR",
									["PrtsAfter"] = 2,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Icon"] = "TMW:icon:1Rg1obpBJO85",
									["Type"] = "ICON",
								}, -- [6]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "298357",
								}, -- [7]
								["n"] = 7,
							},
							["GUID"] = "TMW:icon:1Rg0on0B7Owq",
							["Type"] = "cooldown",
						}, -- [11]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "163201",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RGdpp2IFjGf",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Name"] = "163201",
									["PrtsBefore"] = 4,
									["Level"] = 20,
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "262228",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [2]
								{
									["PrtsBefore"] = 2,
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "HEALTH",
									["Operator"] = "<",
									["Level"] = 20,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["PrtsBefore"] = 1,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "HEALTH",
									["Operator"] = "<",
									["Level"] = 35,
									["PrtsAfter"] = 3,
									["Unit"] = "target",
								}, -- [7]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["AndOr"] = "OR",
									["Name"] = "52437",
									["Operator"] = "~=",
								}, -- [8]
								{
									["PrtsBefore"] = 2,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
								}, -- [9]
								{
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 1,
									["Name"] = "281000",
								}, -- [10]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 1,
								}, -- [11]
								{
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 4,
									["Name"] = "163201",
								}, -- [12]
								{
									["Icon"] = "TMW:icon:1RTC8jAyqkvm",
									["Type"] = "ICON",
								}, -- [13]
								["n"] = 13,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [12]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "1680",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RGdpp2dIykT",
							["Conditions"] = {
								{
									["Name"] = "22489",
									["Type"] = "TALENTLEARNED",
								}, -- [1]
								{
									["PrtsBefore"] = 4,
									["Type"] = "RAGE_ABS",
									["Level"] = 35,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "262228",
									["AndOr"] = "OR",
									["PrtsAfter"] = 2,
									["Operator"] = "~=",
								}, -- [3]
								{
									["Operator"] = ">",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Unit"] = "target",
								}, -- [4]
								{
									["Level"] = 1,
									["Type"] = "SPELLCD",
									["Name"] = "12294",
									["Operator"] = ">",
								}, -- [5]
								{
									["Type"] = "COUNTER",
									["Level"] = 1,
									["Name"] = "testofmight",
									["PrtsAfter"] = 1,
								}, -- [6]
								{
									["PrtsBefore"] = 2,
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["AndOr"] = "OR",
								}, -- [7]
								{
									["Type"] = "SPELLCD",
									["Name"] = "167105",
									["PrtsBefore"] = 2,
									["Level"] = 15,
									["Operator"] = ">",
								}, -- [8]
								{
									["Type"] = "TALENTLEARNED",
									["Level"] = 1,
									["Name"] = "22391",
									["PrtsAfter"] = 1,
								}, -- [9]
								{
									["Type"] = "SPELLCD",
									["Name"] = "262161",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 15,
									["Operator"] = ">",
								}, -- [10]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [11]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 65,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["PrtsAfter"] = 3,
									["Operator"] = ">",
								}, -- [12]
								{
									["Level"] = 30,
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 2,
									["Operator"] = ">",
								}, -- [13]
								{
									["Name"] = "execute",
									["Type"] = "COUNTER",
								}, -- [14]
								["n"] = 14,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [13]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "1464",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RGeIgsJQX0r",
							["Conditions"] = {
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22489",
									["Level"] = 1,
								}, -- [1]
								{
									["PrtsBefore"] = 4,
									["Type"] = "RAGE_ABS",
									["Level"] = 25,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "262228",
									["AndOr"] = "OR",
									["PrtsAfter"] = 2,
									["Operator"] = "~=",
								}, -- [3]
								{
									["Operator"] = ">",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Unit"] = "target",
								}, -- [4]
								{
									["Level"] = 1,
									["Type"] = "SPELLCD",
									["Name"] = "12294",
									["Operator"] = ">",
								}, -- [5]
								{
									["Type"] = "COUNTER",
									["Level"] = 1,
									["Name"] = "testofmight",
									["PrtsAfter"] = 1,
								}, -- [6]
								{
									["PrtsBefore"] = 1,
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["AndOr"] = "OR",
								}, -- [7]
								{
									["Type"] = "SPELLCD",
									["Name"] = "167105",
									["PrtsBefore"] = 2,
									["Level"] = 15,
									["Operator"] = ">",
								}, -- [8]
								{
									["Type"] = "TALENTLEARNED",
									["Level"] = 1,
									["Name"] = "22391",
									["PrtsAfter"] = 1,
								}, -- [9]
								{
									["Type"] = "SPELLCD",
									["Name"] = "262161",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 15,
									["Operator"] = ">",
								}, -- [10]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [11]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 65,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["PrtsAfter"] = 4,
									["Operator"] = ">",
								}, -- [12]
								{
									["Name"] = "execute",
									["Type"] = "COUNTER",
								}, -- [13]
								["n"] = 13,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [14]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 1,
									["AnchorTo"] = "IconModule_CooldownSweepCooldown",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1RJiuYRLZrXP",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Animation"] = "ICONFLASH",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 1,
									["Animation"] = "ICONBORDER",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1RJiuYRLZrXP",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1RJiuYRHNBx2",
							["FakeHidden"] = true,
							["CustomTex"] = "8386",
							["Type"] = "swingtimer",
						}, -- [15]
						{
							["GUID"] = "TMW:icon:1RJiuYRLZrXP",
							["ShowTimer"] = true,
							["DurationMaxEnabled"] = true,
							["FakeHidden"] = true,
							["Events"] = {
								{
									["Event"] = "WCSP",
									["Type"] = "Animations",
									["Period"] = 1,
									["Animation"] = "ICONFLASH",
								}, -- [1]
								["n"] = 1,
							},
							["DurationMax"] = 1,
							["Enabled"] = true,
							["CustomTex"] = "8386",
							["Type"] = "swingtimer",
						}, -- [16]
						{
							["ShowTTText"] = true,
							["Type"] = "buff",
							["Name"] = "7384",
							["GUID"] = "TMW:icon:1RGeD0uM4U3o",
							["FakeHidden"] = true,
							["Enabled"] = true,
						}, -- [17]
						nil, -- [18]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
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
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "260708",
							["GUID"] = "TMW:icon:1RL=eAHTYJcw",
							["FakeHidden"] = true,
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [21]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["DurationMaxEnabled"] = true,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["Name"] = "772",
							["DurationMax"] = 3.5,
							["Type"] = "buff",
							["Conditions"] = {
								{
									["Name"] = "19138",
									["Type"] = "TALENTLEARNED",
								}, -- [1]
								{
									["Name"] = "208086",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
								}, -- [2]
								{
									["Operator"] = ">",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Unit"] = "target",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1RL=eAHUbY_S",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [22]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "167105",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RL=eAHVfoHi",
							["Conditions"] = {
								{
									["PrtsBefore"] = 2,
									["Type"] = "SPELLCD",
									["Name"] = "262161",
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [2]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22391",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["AndOr"] = "OR",
								}, -- [3]
								["n"] = 3,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [23]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "227847",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTCMxEg4qi8",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = ">",
									["Level"] = 2,
									["Name"] = "208086",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "21667",
									["Level"] = 1,
								}, -- [2]
								{
									["Name"] = "cooldown_toggle",
									["Type"] = "COUNTER",
								}, -- [3]
								{
									["Name"] = "arms_bs",
									["Type"] = "COUNTER",
								}, -- [4]
								["n"] = 4,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [24]
						{
							["GUID"] = "TMW:icon:1RTCN7EH5rEt",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
							["Name"] = "12294",
							["DurationMax"] = 2,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["PrtsBefore"] = 1,
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [1]
								{
									["Level"] = 1.5,
									["Type"] = "SPELLCD",
									["Name"] = "12294",
									["Operator"] = "<",
								}, -- [2]
								{
									["Level"] = 30,
									["Type"] = "RAGE_ABS",
									["Name"] = "12294",
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["PrtsBefore"] = 2,
									["Level"] = 2,
									["Name"] = "7384",
								}, -- [4]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22407",
								}, -- [5]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Level"] = 2,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Name"] = "272866",
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Level"] = 2,
									["AndOr"] = "OR",
									["Name"] = "272867",
									["Unit"] = "target",
								}, -- [7]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Name"] = "272870",
									["Level"] = 2,
									["AndOr"] = "OR",
									["PrtsAfter"] = 3,
									["Unit"] = "target",
								}, -- [8]
								{
									["Icon"] = "TMW:icon:1RTD2ohayX3V",
									["Type"] = "ICON",
								}, -- [9]
								["n"] = 9,
							},
							["Type"] = "cooldown",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [25]
						{
							["GUID"] = "TMW:icon:1RL=eAHXlHCC",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
							["Name"] = "12294",
							["DurationMax"] = 2,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 1.5,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 30,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "262228",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [3]
								{
									["Name"] = "execute",
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [4]
								["n"] = 4,
							},
							["Type"] = "cooldown",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [26]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "260643",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RL=eAHYlywP",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 80,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Name"] = "22371",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								["n"] = 2,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [27]
						{
							["GUID"] = "TMW:icon:1RL=eAHaq80u",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]",
									},
								},
							},
							["Name"] = "12294",
							["DurationMax"] = 2,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "BUFFSTACKS",
									["Level"] = 2,
									["Name"] = "7384",
									["Checked"] = true,
								}, -- [1]
								{
									["Name"] = "12294",
									["Type"] = "SPELLCD",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 30,
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "262228",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [4]
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["Unit"] = "target",
								}, -- [5]
								["n"] = 5,
							},
							["Type"] = "cooldown",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [28]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "845",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1Ra7fP21bk42",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 20,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Name"] = "22362",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								["n"] = 2,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [29]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "228920",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTCPcVTM2Je",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = ">",
									["PrtsBefore"] = 2,
									["Level"] = 2,
									["Name"] = "208086",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "HEALTH",
									["Operator"] = ">",
									["Level"] = 20,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["Operator"] = "<=",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 20,
									["Unit"] = "target",
								}, -- [3]
								{
									["Level"] = 30,
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 2,
									["Operator"] = "<",
								}, -- [4]
								{
									["Name"] = "21667",
									["Type"] = "TALENTLEARNED",
								}, -- [5]
								{
									["Name"] = "cooldown_toggle",
									["Type"] = "COUNTER",
								}, -- [6]
								{
									["Name"] = "arms_rav",
									["Type"] = "COUNTER",
								}, -- [7]
								["n"] = 7,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [30]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["ClockGCD"] = true,
							["Name"] = "7384",
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
							["GUID"] = "TMW:icon:1RL=eAHZoKRG",
							["Type"] = "cooldown",
						}, -- [31]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "163201",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RL=eAHWk5Yo",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Name"] = "163201",
									["PrtsBefore"] = 2,
									["Level"] = 40,
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "262228",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [2]
								{
									["PrtsBefore"] = 2,
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "HEALTH",
									["Operator"] = "<",
									["Level"] = 20,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["PrtsBefore"] = 1,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "HEALTH",
									["Operator"] = "<",
									["Level"] = 35,
									["PrtsAfter"] = 3,
									["Unit"] = "target",
								}, -- [7]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["AndOr"] = "OR",
									["Name"] = "52437",
									["Operator"] = "~=",
								}, -- [8]
								["n"] = 8,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [32]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "1680",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RL=eAHbqFqW",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 30,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["AndOr"] = "OR",
									["Name"] = "262228",
									["Operator"] = "~=",
								}, -- [2]
								["n"] = 2,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [33]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 1,
									["AnchorTo"] = "IconModule_CooldownSweepCooldown",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1RJiuYRLZrXP",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Animation"] = "ICONFLASH",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 1,
									["Animation"] = "ICONBORDER",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1RJiuYRLZrXP",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1RL=eAHcqhaW",
							["FakeHidden"] = true,
							["CustomTex"] = "8386",
							["Type"] = "swingtimer",
						}, -- [34]
						nil, -- [35]
						nil, -- [36]
						nil, -- [37]
						nil, -- [38]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
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
							["Enabled"] = true,
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["DurationMaxEnabled"] = true,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["Name"] = "772",
							["DurationMax"] = 5.5,
							["Type"] = "buff",
							["Conditions"] = {
								{
									["Name"] = "19138",
									["Type"] = "TALENTLEARNED",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 2,
									["Name"] = "208086",
									["Unit"] = "target",
								}, -- [2]
								{
									["Operator"] = ">",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
									["Level"] = 1,
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1RTBxKd1K0Rf",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [41]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["DurationMaxEnabled"] = true,
							["ClockGCD"] = true,
							["Type"] = "cooldown",
							["Name"] = "167105",
							["DurationMax"] = 2,
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Name"] = "262161",
									["PrtsBefore"] = 3,
									["Level"] = 2,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [2]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22391",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["AndOr"] = "OR",
								}, -- [3]
								{
									["PrtsBefore"] = 2,
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
								}, -- [4]
								{
									["Level"] = 30,
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [5]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["Level"] = 1,
									["PrtsAfter"] = 2,
									["AndOr"] = "OR",
								}, -- [6]
								{
									["Name"] = "cooldown_toggle",
									["Type"] = "COUNTER",
								}, -- [7]
								{
									["Name"] = "arms_cs",
									["Type"] = "COUNTER",
								}, -- [8]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
									["Level"] = 1,
								}, -- [9]
								["n"] = 9,
							},
							["GUID"] = "TMW:icon:1RTBxKd2Ohfq",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [42]
						{
							["GUID"] = "TMW:icon:1RTC7Mb45nXX",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
							["Name"] = "12294",
							["DurationMax"] = 2,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["PrtsBefore"] = 1,
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [1]
								{
									["Level"] = 3.5,
									["Type"] = "SPELLCD",
									["Name"] = "12294",
									["Operator"] = "<",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 30,
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "RAGE_ABS",
									["PrtsBefore"] = 1,
									["Level"] = 5,
									["AndOr"] = "OR",
									["Operator"] = ">=",
								}, -- [4]
								{
									["Level"] = 2,
									["Type"] = "MHSWING",
									["PrtsAfter"] = 2,
									["Operator"] = "<",
								}, -- [5]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["PrtsBefore"] = 1,
									["Level"] = 1,
									["Name"] = "7384",
								}, -- [6]
								{
									["Icon"] = "TMW:icon:1RGdpp2XiEgf",
									["Type"] = "ICON",
								}, -- [7]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 2,
									["Name"] = "22407",
								}, -- [8]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTBzFiJhwQj",
									["Level"] = 1,
								}, -- [9]
								["n"] = 9,
							},
							["Type"] = "cooldown",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [43]
						{
							["GUID"] = "TMW:icon:1RTBxKd4NdPL",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
							["Name"] = "12294",
							["DurationMax"] = 2,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "SPELLCD",
									["Name"] = "12294",
									["PrtsBefore"] = 1,
									["Level"] = 3.5,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "RAGE_ABS",
									["Name"] = "12294",
									["PrtsBefore"] = 2,
									["Level"] = 30,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["PrtsBefore"] = 1,
									["Level"] = 5,
									["AndOr"] = "OR",
									["Operator"] = ">=",
								}, -- [3]
								{
									["Level"] = 2,
									["Type"] = "MHSWING",
									["PrtsAfter"] = 2,
									["Operator"] = "<",
								}, -- [4]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "262228",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [5]
								{
									["Name"] = "execute",
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2Rvc8H",
									["Level"] = 1,
								}, -- [7]
								["n"] = 7,
							},
							["Type"] = "cooldown",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [44]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["DurationMaxEnabled"] = true,
							["ClockGCD"] = true,
							["Type"] = "cooldown",
							["Name"] = "260643",
							["DurationMax"] = 2,
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 60,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Name"] = "22371",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGe00HwCayk",
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1RTBxKd5Ox2K",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [45]
						{
							["GUID"] = "TMW:icon:1RTBxKd6Np0=",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]",
									},
								},
							},
							["Name"] = "12294",
							["DurationMax"] = 2,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["PrtsBefore"] = 1,
									["Level"] = 1,
									["Name"] = "7384",
								}, -- [1]
								{
									["Level"] = 1.5,
									["Type"] = "SPELLCD",
									["Name"] = "12294",
									["Operator"] = "<",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Name"] = "12294",
									["PrtsBefore"] = 2,
									["Level"] = 30,
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "RAGE_ABS",
									["PrtsBefore"] = 1,
									["Level"] = 5,
									["AndOr"] = "OR",
									["Operator"] = ">=",
								}, -- [4]
								{
									["Level"] = 2,
									["Type"] = "MHSWING",
									["PrtsAfter"] = 2,
									["Operator"] = "<",
								}, -- [5]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "262228",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [6]
								{
									["Name"] = "execute",
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [7]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGeD0uAObsB",
									["Level"] = 1,
								}, -- [8]
								["n"] = 8,
							},
							["Type"] = "cooldown",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [46]
						{
							["GUID"] = "TMW:icon:1RTBxKd7Msy4",
							["ShowTimer"] = true,
							["DurationMaxEnabled"] = true,
							["FakeHidden"] = true,
							["ClockGCD"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["Name"] = "7384",
							["DurationMax"] = 2,
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Icon"] = "TMW:icon:1RTC8jApfn=I",
									["Type"] = "ICON",
								}, -- [1]
								{
									["PrtsBefore"] = 2,
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "COUNTER",
									["PrtsAfter"] = 1,
									["Name"] = "testofmight",
								}, -- [3]
								{
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 1,
								}, -- [4]
								{
									["Level"] = 35,
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 2,
									["Operator"] = "<",
								}, -- [5]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2XiEgf",
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1Rg0on0B7Owq",
									["Level"] = 1,
								}, -- [7]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Level"] = 1.5,
									["Name"] = "298357",
									["Operator"] = "<",
								}, -- [8]
								["n"] = 8,
							},
							["Type"] = "cooldown",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [47]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["ClockGCD"] = true,
							["Name"] = "7384",
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
									["PrtsBefore"] = 2,
									["Type"] = "COUNTER",
									["Name"] = "execute",
								}, -- [1]
								{
									["Name"] = "testofmight",
									["Type"] = "COUNTER",
								}, -- [2]
								{
									["PrtsBefore"] = 2,
									["Type"] = "RAGE_ABS",
									["Level"] = 40,
									["Operator"] = "<",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "208086",
									["Operator"] = "~=",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Operator"] = "<",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "208086",
									["Level"] = 2,
									["AndOr"] = "OR",
									["PrtsAfter"] = 2,
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["AndOr"] = "OR",
								}, -- [6]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1Rg0on0B7Owq",
									["Level"] = 1,
								}, -- [7]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2XiEgf",
									["Level"] = 1,
								}, -- [8]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Level"] = 1.5,
									["Name"] = "298357",
									["Operator"] = "<",
								}, -- [9]
								["n"] = 9,
							},
							["GUID"] = "TMW:icon:1Rg1qywrOCAo",
							["Type"] = "cooldown",
						}, -- [48]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "163201",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTBxKd8OIaD",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Name"] = "163201",
									["PrtsBefore"] = 5,
									["Level"] = 20,
									["Operator"] = ">",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "RAGE_ABS",
									["AndOr"] = "OR",
									["Operator"] = ">=",
								}, -- [2]
								{
									["Level"] = 2,
									["Type"] = "MHSWING",
									["PrtsAfter"] = 2,
									["Operator"] = "<",
								}, -- [3]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "262228",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [4]
								{
									["PrtsBefore"] = 2,
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "HEALTH",
									["Operator"] = "<",
									["Level"] = 20,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [6]
								{
									["PrtsBefore"] = 1,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
									["AndOr"] = "OR",
								}, -- [7]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [8]
								{
									["Type"] = "HEALTH",
									["Operator"] = "<",
									["Level"] = 35,
									["PrtsAfter"] = 3,
									["Unit"] = "target",
								}, -- [9]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["AndOr"] = "OR",
									["Name"] = "52437",
									["Operator"] = "~=",
								}, -- [10]
								{
									["PrtsBefore"] = 2,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
								}, -- [11]
								{
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 1,
									["Name"] = "281000",
								}, -- [12]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 1,
								}, -- [13]
								{
									["Type"] = "SPELLCD",
									["PrtsAfter"] = 4,
									["Name"] = "163201",
								}, -- [14]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2IFjGf",
									["Level"] = 1,
								}, -- [15]
								["n"] = 15,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [49]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "1680",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTBxKd9OUM_",
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22489",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "RAGE_ABS",
									["Level"] = 5,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "262228",
									["AndOr"] = "OR",
									["PrtsAfter"] = 2,
									["Operator"] = "~=",
								}, -- [3]
								{
									["Operator"] = ">",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Unit"] = "target",
								}, -- [4]
								{
									["Level"] = 1,
									["Type"] = "SPELLCD",
									["Name"] = "12294",
									["Operator"] = ">",
								}, -- [5]
								{
									["PrtsBefore"] = 1,
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["Level"] = 1,
								}, -- [6]
								{
									["PrtsBefore"] = 1,
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["AndOr"] = "OR",
								}, -- [7]
								{
									["Type"] = "SPELLCD",
									["Name"] = "167105",
									["PrtsBefore"] = 2,
									["Level"] = 15,
									["Operator"] = ">",
								}, -- [8]
								{
									["Type"] = "TALENTLEARNED",
									["Level"] = 1,
									["Name"] = "22391",
									["PrtsAfter"] = 1,
								}, -- [9]
								{
									["Type"] = "SPELLCD",
									["Name"] = "262161",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 15,
									["Operator"] = ">",
								}, -- [10]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [11]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 40,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["PrtsAfter"] = 4,
									["Operator"] = ">",
								}, -- [12]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2dIykT",
									["Level"] = 1,
								}, -- [13]
								["n"] = 13,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [50]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "1464",
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RTBxKdANcIS",
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22489",
									["Level"] = 1,
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "RAGE_ABS",
									["Level"] = 5,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "262228",
									["AndOr"] = "OR",
									["PrtsAfter"] = 2,
									["Operator"] = "~=",
								}, -- [3]
								{
									["Operator"] = ">",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Unit"] = "target",
								}, -- [4]
								{
									["Level"] = 1,
									["Type"] = "SPELLCD",
									["Name"] = "12294",
									["Operator"] = ">",
								}, -- [5]
								{
									["PrtsBefore"] = 1,
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["Level"] = 1,
								}, -- [6]
								{
									["PrtsBefore"] = 1,
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["AndOr"] = "OR",
								}, -- [7]
								{
									["Type"] = "SPELLCD",
									["Name"] = "167105",
									["PrtsBefore"] = 2,
									["Level"] = 15,
									["Operator"] = ">",
								}, -- [8]
								{
									["Type"] = "TALENTLEARNED",
									["Level"] = 1,
									["Name"] = "22391",
									["PrtsAfter"] = 1,
								}, -- [9]
								{
									["Type"] = "SPELLCD",
									["Name"] = "262161",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 15,
									["Operator"] = ">",
								}, -- [10]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "22391",
								}, -- [11]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 40,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["PrtsAfter"] = 4,
									["Operator"] = ">",
								}, -- [12]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGeIgsJQX0r",
									["Level"] = 1,
								}, -- [13]
								["n"] = 13,
							},
							["ClockGCD"] = true,
							["Type"] = "cooldown",
						}, -- [51]
						nil, -- [52]
						nil, -- [53]
						nil, -- [54]
						nil, -- [55]
						nil, -- [56]
						nil, -- [57]
						nil, -- [58]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
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
							["GUID"] = "TMW:icon:1QvCpZlkrDFs",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["Enabled"] = true,
							["Name"] = "227847",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "21667",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["ShowTimerText"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [61]
						nil, -- [62]
						nil, -- [63]
						{
							["GUID"] = "TMW:icon:1RGePhvZnHAy",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["Enabled"] = true,
							["Name"] = "107574",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								{
									["Name"] = "22397",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGePi2spDfn",
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["ShowTimerText"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [64]
						{
							["GUID"] = "TMW:icon:1RGePi2spDfn",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["Name"] = "107574",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								{
									["Name"] = "22397",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								["n"] = 2,
							},
							["ShowTimerText"] = true,
							["Type"] = "buff",
						}, -- [65]
						{
							["GUID"] = "TMW:icon:1RGePi2vizrO",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["Enabled"] = true,
							["Name"] = "262228",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								{
									["Name"] = "22399",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGePi2zBPNT",
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["ShowTimerText"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [66]
						{
							["GUID"] = "TMW:icon:1RGePi2zBPNT",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["Name"] = "262228",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								{
									["Name"] = "22399",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								["n"] = 2,
							},
							["ShowTimerText"] = true,
							["Type"] = "buff",
						}, -- [67]
						{
							["GUID"] = "TMW:icon:1RGfOgkWiSuM",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["Enabled"] = true,
							["Name"] = "152277",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								{
									["Name"] = "21667",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								["n"] = 2,
							},
							["ShowTimerText"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [68]
						{
							["GUID"] = "TMW:icon:1Rg0QjwlDIk1",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["Enabled"] = true,
							["Name"] = "167105",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "22391",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["ShowTimerText"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [69]
						{
							["GUID"] = "TMW:icon:1Rg0QjwmXRyU",
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["Enabled"] = true,
							["Name"] = "262161",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								{
									["Name"] = "22391",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								["n"] = 2,
							},
							["ShowTimerText"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [70]
						nil, -- [71]
						{
							["ShowTTText"] = true,
							["Type"] = "buff",
							["Name"] = "275540",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0)]",
									},
								},
							},
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1TCHfoi=WAuc",
						}, -- [72]
						[83] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1RTC8jAsrdvG",
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RZ8uyGIHkyU",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1Rg1PA0lcPyA",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
									["Level"] = 1,
								}, -- [4]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTBzFiJhwQj",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2Rvc8H",
									["Level"] = 1,
								}, -- [6]
								["n"] = 6,
							},
							["CustomTex"] = "260643",
							["FakeHidden"] = true,
						},
						[85] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1RTC8jApfn=I",
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RZ8uyGIHkyU",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1Rg1PA0lcPyA",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
									["Level"] = 1,
								}, -- [4]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTBzFiJhwQj",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2Rvc8H",
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGe00HwCayk",
									["Level"] = 1,
								}, -- [7]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGeD0uAObsB",
									["Level"] = 1,
								}, -- [8]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTBzNx11CSK",
									["Level"] = 1,
								}, -- [9]
								["n"] = 9,
							},
							["CustomTex"] = "7384",
							["FakeHidden"] = true,
						},
						[87] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["GUID"] = "TMW:icon:1RTC8jAyqkvm",
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RZ8uyGIHkyU",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1Rg1PA0lcPyA",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
									["Level"] = 1,
								}, -- [4]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTBzFiJhwQj",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2Rvc8H",
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGe00HwCayk",
									["Level"] = 1,
								}, -- [7]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGeD0uAObsB",
									["Level"] = 1,
								}, -- [8]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTBzNx11CSK",
									["Level"] = 1,
								}, -- [9]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2XiEgf",
									["Level"] = 1,
								}, -- [10]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1Rg0on0B7Owq",
									["Level"] = 1,
								}, -- [11]
								["n"] = 11,
							},
							["CustomTex"] = "5308",
							["FakeHidden"] = true,
						},
						[136] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "46924; 227847",
							["GUID"] = "TMW:icon:1RL=eAD8Kmw0",
							["DurationMin"] = 1,
							["DurationMinEnabled"] = true,
							["Type"] = "buff",
						},
						[122] = {
							["GUID"] = "TMW:icon:1T3cIasRc1aj",
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1T3cIasRc1aj",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "border_toggle",
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
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "143612",
							["FakeHidden"] = true,
						},
						[124] = {
							["GUID"] = "TMW:icon:1T3cIasS69qg",
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1T3cIasS69qg",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "combat_toggle",
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
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "88163",
							["FakeHidden"] = true,
						},
						[126] = {
							["GUID"] = "TMW:icon:1T3cIasSZwWl",
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1T3cIasSZwWl",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "target_toggle",
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
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "204219",
							["FakeHidden"] = true,
						},
						[86] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1Rg1obpBJO85",
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RZ8uyGIHkyU",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1Rg1PA0lcPyA",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
									["Level"] = 1,
								}, -- [4]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTBzFiJhwQj",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2Rvc8H",
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGe00HwCayk",
									["Level"] = 1,
								}, -- [7]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGeD0uAObsB",
									["Level"] = 1,
								}, -- [8]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTBzNx11CSK",
									["Level"] = 1,
								}, -- [9]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2XiEgf",
									["Level"] = 1,
								}, -- [10]
								["n"] = 10,
							},
							["CustomTex"] = "7384",
							["FakeHidden"] = true,
						},
						[99] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
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
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1RYjPWe1zjh4",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "arms_bs",
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
						},
						[103] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1RYjOKqPrqZ0",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "arms_rav",
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
						},
						[105] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1RYjOK3OUw0_",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "arms_avatar",
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
						},
						[107] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1RZA9mRp2XSl",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "arms_cs",
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
						},
						[109] = {
							["GUID"] = "TMW:icon:1RZ8bU8TfXPC",
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1RZ8bU8TfXPC",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "testofmight",
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
							["CustomTex"] = "275529",
							["FakeHidden"] = true,
						},
						[80] = {
							["Enabled"] = true,
						},
						[82] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "2",
									},
								},
							},
							["GUID"] = "TMW:icon:1RTD2m1wLgWu",
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RZ8uyGIHkyU",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1Rg1PA0lcPyA",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
									["Level"] = 1,
								}, -- [4]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTBzFiJhwQj",
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
							},
							["CustomTex"] = "12294",
							["FakeHidden"] = true,
						},
						[133] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["ClockGCD"] = true,
							["GUID"] = "TMW:icon:1QpP_HqMELD0",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 0.8,
									["Animation"] = "ICONALPHAFLASH",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1QpP_HqMELD0",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Infinite"] = true,
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
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "target_toggle",
									["Level"] = 1,
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "EXISTS",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "REACT",
									["Level"] = 2,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [3]
								["n"] = 3,
							},
							["CustomTex"] = "163446",
							["Name"] = "403",
						},
						[137] = {
							["GUID"] = "TMW:icon:1Rg0QjxDyopx",
							["ShowTimer"] = true,
							["Name"] = "6673",
							["Enabled"] = true,
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Events"] = {
								{
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1Rg0QjxDyopx",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Type"] = "Animations",
									["Event"] = "WCSP",
									["Animation"] = "ACTVTNGLOW",
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
						},
						[119] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
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
							["GUID"] = "TMW:icon:1T3cIanoF_i6",
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1T3cIanoF_i6",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "border_toggle",
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
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "143612",
							["FakeHidden"] = true,
						},
						[123] = {
							["GUID"] = "TMW:icon:1T3cIanoNemZ",
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1T3cIanoNemZ",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "combat_toggle",
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
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "88163",
							["FakeHidden"] = true,
						},
						[125] = {
							["GUID"] = "TMW:icon:1T3cIanoUjuz",
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1T3cIanoUjuz",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "target_toggle",
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
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "204219",
							["FakeHidden"] = true,
						},
						[110] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1RZ8bU8Z1jLS",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "testofmight",
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
						},
						[102] = {
							["GUID"] = "TMW:icon:1RYjOKqM=xzp",
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1RYjOKqM=xzp",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "arms_bs",
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
							["CustomTex"] = "46924",
							["FakeHidden"] = true,
						},
						[134] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["ClockGCD"] = true,
							["FakeHidden"] = true,
							["Name"] = "403",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["Type"] = "cooldown",
							["GUID"] = "TMW:icon:1QpNXXs1Yg0u",
							["CustomTex"] = "NONE",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						},
						[138] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Name"] = "280735",
							["FakeHidden"] = true,
							["Events"] = {
								{
									["CounterOperation"] = "=",
									["Type"] = "Counter",
									["Event"] = "OnShow",
									["Counter"] = "execute",
								}, -- [1]
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["CounterAmt"] = 0,
									["Event"] = "OnHide",
									["Counter"] = "execute",
								}, -- [2]
								["n"] = 2,
							},
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Operator"] = "<",
									["PrtsBefore"] = 2,
									["Level"] = 20,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
									["AndOr"] = "OR",
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["Operator"] = "<",
									["Level"] = 35,
									["PrtsAfter"] = 2,
									["Unit"] = "target",
								}, -- [3]
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [4]
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [5]
								["n"] = 5,
							},
							["CustomTex"] = "5308",
							["ClockGCD"] = true,
						},
						[104] = {
							["GUID"] = "TMW:icon:1RYjOKqSlOoj",
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1RYjOKqSlOoj",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "arms_rav",
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
							["CustomTex"] = "152277",
							["FakeHidden"] = true,
						},
						[106] = {
							["GUID"] = "TMW:icon:1RYjOK3U8Flu",
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1RYjOK3U8Flu",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "arms_avatar",
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
							["CustomTex"] = "107574",
							["FakeHidden"] = true,
						},
						[108] = {
							["GUID"] = "TMW:icon:1RZA9mRsbOPA",
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1RZA9mRsbOPA",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "arms_cs",
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
							["CustomTex"] = "167105",
							["FakeHidden"] = true,
						},
						[79] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Cooldowns",
									},
								},
							},
							["CustomTex"] = "NONE",
							["FakeHidden"] = true,
						},
						[81] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"1", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1RTD2ohayX3V",
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RZ8uyGIHkyU",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1Rg1PA0lcPyA",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
									["Level"] = 1,
								}, -- [4]
								["n"] = 4,
							},
							["CustomTex"] = "12294",
							["FakeHidden"] = true,
						},
						[84] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "3",
									},
								},
							},
							["GUID"] = "TMW:icon:1RTC8jAvrtK1",
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp24C0VS",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RZ8uyGIHkyU",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1Rg1PA0lcPyA",
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2C6tbD",
									["Level"] = 1,
								}, -- [4]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RTBzFiJhwQj",
									["Level"] = 1,
								}, -- [5]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2Rvc8H",
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGe00HwCayk",
									["Level"] = 1,
								}, -- [7]
								["n"] = 7,
							},
							["CustomTex"] = "12294",
							["FakeHidden"] = true,
						},
					},
					["Name"] = "Arms Profile",
					["SettingsPerView"] = {
						["icon"] = {
							["SpacingY"] = 10,
						},
					},
					["EnabledSpecs"] = {
						[73] = false,
						[72] = false,
					},
					["Columns"] = 20,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1Qogrdv2HV3Z",
					["Strata"] = "HIGH",
					["Point"] = {
						["y"] = -80.2499954106969,
					},
					["Scale"] = 1.31473815441132,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Type"] = "ALIVE",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "version_#1",
								}, -- [1]
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Type"] = "ALIVE",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "version_#2",
								}, -- [2]
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Type"] = "ALIVE",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "version_#3",
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
					["ShrinkGroup"] = true,
					["EnabledSpecs"] = {
						[72] = false,
						[73] = false,
					},
					["Columns"] = 1,
				}, -- [2]
				{
					["BackdropColor"] = "ff000000",
					["GUID"] = "TMW:group:1QoUgaC7I4Vd",
					["Columns"] = 1,
					["View"] = "bar",
					["Scale"] = 0.954276204109192,
					["Rows"] = 4,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "value",
							["Events"] = {
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
									["Animation"] = "ICONBORDER",
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
							["BackdropColor"] = "ff7a0000",
							["TimerBar_MiddleColor"] = "ffffda00",
							["BuffOrDebuff"] = "HARMFUL",
							["TimerBar_CompleteColor"] = "ffffda00",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["TimerBar_StartColor"] = "ffffda00",
							["TimerBar_EnableColors"] = true,
							["Enabled"] = true,
							["Type"] = "buff",
							["BackdropColor_Enable"] = true,
							["ShowTTText"] = true,
							["Name"] = "208086",
							["SettingsPerView"] = {
								["bar"] = {
									["TextLayout"] = "bar1",
									["Texts"] = {
										"[Duration:TMWFormatDuration]", -- [1]
										"[Spell]", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								["n"] = 1,
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
									["Animation"] = "ICONBORDER",
								}, -- [1]
								["n"] = 1,
							},
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 0.5,
								}, -- [2]
							},
						}, -- [2]
						{
							["BackdropColor"] = "ff7a0000",
							["Type"] = "buff",
							["TimerBar_MiddleColor"] = "ffff0000",
							["BackdropColor_Enable"] = true,
							["TimerBar_CompleteColor"] = "ffff0000",
							["ShowTTText"] = true,
							["OnlyMine"] = true,
							["Name"] = "275540",
							["SettingsPerView"] = {
								["bar"] = {
									["TextLayout"] = "bar1",
									["Texts"] = {
										"[Duration:TMWFormatDuration]", -- [1]
										"[Spell] [Stacks(icon=\"TMW:icon:1TCHfoi=WAuc\"):Hide(0)]", -- [2]
									},
								},
							},
							["Enabled"] = true,
							["TimerBar_EnableColors"] = true,
							["BarDisplay_Invert"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
									["Animation"] = "ICONBORDER",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
									["Animation"] = "ICONBORDER",
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
							["TimerBar_EnableColors"] = true,
							["BackdropColor_Enable"] = true,
							["TimerBar_CompleteColor"] = "0000ff00",
							["BackdropColor"] = "ffff6500",
						}, -- [4]
						{
							["BackdropColor"] = "ff402200",
							["Type"] = "buff",
							["TimerBar_MiddleColor"] = "ffac5d00",
							["Enabled"] = true,
							["BackdropColor_Enable"] = true,
							["TimerBar_CompleteColor"] = "ffac5d00",
							["SettingsPerView"] = {
								["bar"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[AuraSource AuraSource]", -- [2]
									},
								},
							},
							["ShowTTText"] = true,
							["OnlyMine"] = true,
							["Name"] = "190456",
							["TimerBar_StartColor"] = "ffac5d00",
							["Events"] = {
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
									["Animation"] = "ICONBORDER",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["BitFlags"] = {
										[73] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								["n"] = 1,
							},
							["TimerBar_EnableColors"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 0.5,
								}, -- [2]
							},
						}, -- [5]
					},
					["TextureName"] = "Minimalist",
					["BackdropColor_Enable"] = true,
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
					["ShrinkGroup"] = true,
					["Conditions"] = {
						{
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						{
							["Level"] = 1,
							["Type"] = "VEHICLE",
						}, -- [9]
						["n"] = 9,
					},
					["EnabledSpecs"] = {
						[72] = false,
						[73] = false,
					},
					["Point"] = {
						["y"] = -57.32825844569,
						["relativeTo"] = "TMW:group:1Ov1GPZDfFXX",
						["point"] = "TOP",
						["relativePoint"] = "TOP",
						["x"] = 0.00032635226234065,
					},
				}, -- [3]
				{
					["GUID"] = "TMW:group:1Ov1GPZDfFXX",
					["Columns"] = 1,
					["Point"] = {
						["y"] = -53.132709187559,
						["relativeTo"] = "TMW:group:1Qogrdv2HV3Z",
						["point"] = "BOTTOM",
						["relativePoint"] = "TOP",
						["x"] = 0.0370833462401805,
					},
					["EnabledSpecs"] = {
						[72] = false,
						[73] = false,
					},
					["Scale"] = 1.75434064865112,
					["Conditions"] = {
						{
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						{
							["Level"] = 1,
							["Type"] = "VEHICLE",
						}, -- [9]
						["n"] = 9,
					},
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								["n"] = 1,
							},
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
							["GUID"] = "TMW:icon:1R6WKU2symQa",
						}, -- [1]
					},
					["Name"] = "Main Rotation (Meta)",
				}, -- [4]
				{
					["GUID"] = "TMW:group:1QvCPR5qcfPC",
					["Strata"] = "LOW",
					["Point"] = {
						["relativeTo"] = "TMW:group:1QoUgaC7I4Vd",
						["x"] = -0.00019878718566014,
						["point"] = "TOP",
						["relativePoint"] = "BOTTOM",
					},
					["Scale"] = 1.11,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1Rg0QjwlDIk1", -- [1]
								"TMW:icon:1Rg0QjwmXRyU", -- [2]
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1QvCRK1mfvhk",
							["ShowTimer"] = true,
							["Enabled"] = true,
							["Type"] = "cooldown",
							["ShowTimerText"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks:Hide(0, 1)]",
									},
								},
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
								}, -- [1]
								["n"] = 1,
							},
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
							["Name"] = "6552",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [2]
						{
							["Enabled"] = true,
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
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1QvCpZlkrDFs", -- [1]
								"TMW:icon:1RGfOgkWiSuM", -- [2]
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [4]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1RGePhvZnHAy", -- [1]
								"TMW:icon:1RGePi2spDfn", -- [2]
								"TMW:icon:1RGePi2vizrO", -- [3]
								"TMW:icon:1RGePi2zBPNT", -- [4]
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
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
					["Name"] = "Cooldown Bar (Bottom)",
					["ShrinkGroup"] = true,
					["Conditions"] = {
						{
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						{
							["Level"] = 1,
							["Type"] = "VEHICLE",
						}, -- [9]
						["n"] = 9,
					},
					["EnabledSpecs"] = {
						[72] = false,
						[73] = false,
					},
					["Columns"] = 5,
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
					["Columns"] = 1,
					["BackdropColor_Enable"] = true,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["BarDisplay_Reverse"] = true,
							["TimerBar_CompleteColor"] = "ff886332",
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
							["Conditions"] = {
								{
									["Icon"] = "TMW:icon:1T1lwuRfZ3C7",
									["Type"] = "ICON",
								}, -- [1]
								["n"] = 1,
							},
							["TimerBar_EnableColors"] = true,
							["BarDisplay_Invert"] = true,
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["BarDisplay_Reverse"] = true,
							["TimerBar_CompleteColor"] = "ff463f5e",
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
							["TimerBar_EnableColors"] = true,
							["CustomTex"] = "NONE",
							["BarDisplay_Invert"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 121\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 122\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\n\n",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["Type"] = "Animations",
									["AnimColor"] = "ff00fff1",
									["Animation"] = "ICONFLASH",
									["OnlyShown"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
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
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 123\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 124\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\n\n",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "combat_toggle",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["Type"] = "Animations",
									["AnimColor"] = "ff00fff1",
									["Animation"] = "ICONFLASH",
									["OnlyShown"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
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
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 125\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 126\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\n\n",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "target_toggle",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["Type"] = "Animations",
									["AnimColor"] = "ff00fff1",
									["Animation"] = "ICONFLASH",
									["OnlyShown"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
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
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["BarDisplay_Reverse"] = true,
							["TimerBar_CompleteColor"] = "ff463f5e",
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
							["TimerBar_EnableColors"] = true,
							["CustomTex"] = "NONE",
							["BarDisplay_Invert"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [6]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"Arms", -- [2]
									},
								},
							},
							["BarDisplay_Invert"] = true,
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								["n"] = 1,
							},
							["BarDisplay_Reverse"] = true,
							["CustomTex"] = "12294",
						}, -- [7]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 101\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 102\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "arms_bs",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff00fff1",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Animation"] = "ICONFLASH",
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
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "21667",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "NONE",
						}, -- [8]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 103\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 104\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "arms_rav",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff00fff1",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Animation"] = "ICONFLASH",
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
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								{
									["Name"] = "21667",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "NONE",
						}, -- [9]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 105\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 106\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "arms_avatar",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff00fff1",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Animation"] = "ICONFLASH",
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
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "NONE",
						}, -- [10]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 107\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 108\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "arms_cs",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff00fff1",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Animation"] = "ICONFLASH",
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
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "NONE",
						}, -- [11]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 109\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 110\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "testofmight",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Name"] = "testofmight",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["AnimColor"] = "7f00ff1d",
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [3]
								{
									["Type"] = "Animations",
									["Animation"] = "ICONFLASH",
									["AnimColor"] = "ff00fff1",
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
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								["n"] = 1,
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
					["TimerBar_EnableColors"] = true,
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
					["GUID"] = "TMW:group:1T1lA4Tqg1qw",
					["Strata"] = "LOW",
					["Point"] = {
						["y"] = 14.9995957008774,
						["x"] = 1.74517393112183,
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
					},
					["Scale"] = 1.36504948139191,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["Event"] = "OnLeftClick",
									["Counter"] = "menu_open",
								}, -- [1]
								{
									["Type"] = "Counter",
									["Event"] = "OnRightClick",
									["Counter"] = "menu_open",
								}, -- [2]
								{
									["Type"] = "Counter",
									["Frequency"] = 0.2,
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Level"] = 2,
											["Type"] = "COUNTER",
											["Name"] = "menu_open",
											["Operator"] = ">=",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "menu_open",
								}, -- [3]
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "settings_help",
								}, -- [4]
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Level"] = 1,
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "settings_help",
								}, -- [5]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
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
							["GUID"] = "TMW:icon:1T1lwuRfZ3C7",
							["Type"] = "conditionicon",
							["Enabled"] = true,
							["ConditionDurEnabled"] = true,
							["FakeHidden"] = true,
							["OnlyIfCounting"] = true,
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
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["CounterAmt"] = 0,
									["Event"] = "OnHide",
									["Counter"] = "menu_open",
								}, -- [1]
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["CounterAmt"] = 0,
									["Event"] = "OnHide",
									["Counter"] = "menu_open_c",
								}, -- [2]
								{
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
									["Type"] = "Counter",
									["Event"] = "OnCondition",
									["Counter"] = "menu_open_c",
								}, -- [3]
								["n"] = 3,
							},
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["AndOr"] = "OR",
									["Name"] = "menu_open_c",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "Attack",
							["ShowTimerText"] = true,
						}, -- [2]
					},
					["LayoutDirection"] = 4,
					["EnabledProfiles"] = {
						["Maverin - Area 52"] = false,
					},
					["Name"] = "Cooldown Menu Button",
					["EnabledSpecs"] = {
						[64] = false,
						[73] = false,
						[259] = false,
						[260] = false,
						[63] = false,
						[72] = false,
					},
					["Columns"] = 2,
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
							["GUID"] = "TMW:icon:1RGeD16VQQ=Z",
							["ShowTimer"] = true,
							["TimerBar_MiddleColor"] = "ff000000",
							["TimerBar_CompleteColor"] = "ff000000",
							["TimerBar_StartColor"] = "ff000000",
							["TimerBar_EnableColors"] = true,
							["Enabled"] = true,
							["Type"] = "cooldown",
							["BarDisplay_FakeMax"] = 18,
							["BackdropColor_Enable"] = true,
							["BarDisplay_Reverse"] = true,
							["Name"] = "260708",
							["ShowTimerText"] = true,
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
							["BackdropColor"] = "00ff6500",
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGeD16XRQTK",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ffffff00",
									["Event"] = "OnDuration",
									["Operator"] = "<=",
									["PassingCndt"] = true,
									["OnlyShown"] = true,
									["Animation"] = "ICONALPHAFLASH",
									["Value"] = 1,
									["CndtJustPassed"] = true,
								}, -- [1]
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ffffff00",
									["Event"] = "OnDuration",
									["Operator"] = "<=",
									["PassingCndt"] = true,
									["OnlyShown"] = true,
									["Animation"] = "ICONBORDER",
									["Value"] = 1,
									["CndtJustPassed"] = true,
								}, -- [2]
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
									["Animation"] = "ICONBORDER",
								}, -- [3]
								["n"] = 3,
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
							["GUID"] = "TMW:icon:1RGeD16XRQTK",
							["ShowTimer"] = true,
							["TimerBar_MiddleColor"] = "ffffa500",
							["TimerBar_CompleteColor"] = "ffff6500",
							["Enabled"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["CndtJustPassed"] = true,
									["AnimColor"] = "ffffff00",
									["Event"] = "OnDuration",
									["Operator"] = ">",
									["PassingCndt"] = true,
									["OnlyShown"] = true,
									["Infinite"] = true,
									["Animation"] = "ICONBORDER",
								}, -- [1]
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
									["Animation"] = "ICONBORDER",
								}, -- [2]
								{
									["Type"] = "Animations",
									["Event"] = "OnHide",
									["Animation"] = "ICONCLEAR",
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
							["ShowTimerText"] = true,
							["TimerBar_StartColor"] = "ffffda00",
							["Name"] = "260708",
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								["n"] = 1,
							},
							["TimerBar_EnableColors"] = true,
							["Type"] = "buff",
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
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						{
							["Level"] = 1,
							["Type"] = "VEHICLE",
						}, -- [9]
						["n"] = 9,
					},
					["View"] = "bar",
					["BackdropColor"] = "ff000000",
				}, -- [8]
				{
					["GUID"] = "TMW:group:1T3cM2MZ41y7",
					["Strata"] = "LOW",
					["Point"] = {
						["y"] = -3,
						["x"] = 1.17168234476467e-05,
						["relativeTo"] = "TMW:group:1Ov1GPZDfFXX",
					},
					["Scale"] = 1.5,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								["n"] = 1,
							},
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
							["GUID"] = "TMW:icon:1R6WVznvrf0C",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Icon"] = "TMW:icon:1PBsicu04=LR",
										}, -- [1]
										["n"] = 1,
									},
									["Infinite"] = true,
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["BitFlags"] = {
										[71] = true,
									},
									["Type"] = "UNITSPEC",
								}, -- [1]
								["n"] = 1,
							},
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
							["GUID"] = "TMW:icon:1R6WB=OACwE4",
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
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						{
							["Level"] = 1,
							["Type"] = "VEHICLE",
						}, -- [9]
						["n"] = 9,
					},
					["EnabledSpecs"] = {
						[73] = false,
						[72] = false,
					},
					["Columns"] = 2,
				}, -- [9]
			},
			["NumGroups"] = 9,
			["TextureName"] = "Blizzard Raid Bar",
		},
		["Poklopac - Dreadnaught"] = {
			["Version"] = 91200,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1XmCkCd9kyOx",
				}, -- [1]
			},
		},
		["Konac - Dreadnaught"] = {
			["Version"] = 91200,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1Xql=ZXCq2=U",
				}, -- [1]
			},
		},
		["Mage"] = {
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
		["Grgur - Golemagg"] = {
			["Locked"] = true,
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1VAdPEGP30aT",
				}, -- [1]
			},
		},
		["Koloman - Golemagg"] = {
			["Locked"] = true,
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1VGIsVsXYQu0",
				}, -- [1]
			},
		},
		["Mxyzptlk - Golemagg"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1V6kp8IkwwPU",
				}, -- [1]
			},
		},
		["Warlock"] = {
			["Locked"] = true,
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
			["NumGroups"] = 5,
		},
		["Antun - Golemagg"] = {
			["Locked"] = true,
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1VAdKlotQiIe",
				}, -- [1]
			},
		},
		["Moolatz - Dreadnaught"] = {
			["Version"] = 91200,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1XshOhg1QQ8w",
				}, -- [1]
			},
		},
		["Handrmandr - Golemagg"] = {
			["Version"] = 91200,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1XwcryfW285b",
				}, -- [1]
			},
		},
		["Vermina - Golemagg"] = {
			["Version"] = 91200,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1X=ZtmlIHHbE",
				}, -- [1]
			},
		},
		["Nitwit - Dreadnaught"] = {
			["Locked"] = true,
			["Version"] = 91200,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1XkZKOAJJ_mc",
				}, -- [1]
			},
		},
		["Mxys - Golemagg"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1V9nE5TJjTOt",
				}, -- [1]
			},
		},
		["TEST HUNTER"] = {
			["Version"] = 87101,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TRVv5Bhqdi2",
					["Columns"] = 15,
					["Name"] = "Hunter Profile",
					["Alpha"] = 0,
					["Scale"] = 0.600000023841858,
					["Rows"] = 7,
					["Icons"] = {
						nil, -- [1]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["DurationMaxEnabled"] = true,
							["Type"] = "buff",
							["Unit"] = "target",
							["ClockGCD"] = true,
							["ShowTimerText"] = true,
							["Name"] = "1130; 14323; 14324; 14325",
							["DurationMax"] = 3,
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(1130)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Name"] = "melee_range",
									["Type"] = "COUNTER",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1TVSlzDpfz8W",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [2]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["GUID"] = "TMW:icon:1TVSkh271Uiv",
							["Unit"] = "target",
							["ClockGCD"] = true,
							["OnlyMine"] = true,
							["ShowTimerText"] = true,
							["Name"] = "5116",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(5116)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Name"] = "melee_range",
									["Type"] = "COUNTER",
								}, -- [2]
								{
									["Name"] = "maintain_range",
									["Type"] = "COUNTER",
								}, -- [3]
								{
									["Name"] = "targettarget",
									["Type"] = "UNITISUNIT",
								}, -- [4]
								{
									["Name"] = "5116",
									["Type"] = "SPELLCD",
								}, -- [5]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1ToXQH9jBX8w",
									["Level"] = 1,
								}, -- [6]
								["n"] = 6,
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
						}, -- [3]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["GUID"] = "TMW:icon:1TVSglioC2HZ",
							["Unit"] = "target",
							["ClockGCD"] = true,
							["OnlyMine"] = true,
							["ShowTimerText"] = true,
							["Name"] = "2974; 14267; 14268",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "MANAUSABLE",
									["Name"] = "2974",
									["Operator"] = ">=",
								}, -- [1]
								{
									["Type"] = "COUNTER",
									["Name"] = "melee_range",
									["Level"] = 1,
								}, -- [2]
								{
									["Icon"] = "TMW:icon:1TVSIOW0oWeD",
									["Type"] = "ICON",
								}, -- [3]
								{
									["Name"] = "maintain_range",
									["Type"] = "COUNTER",
								}, -- [4]
								["n"] = 4,
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
						}, -- [4]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["ClockGCD"] = true,
							["ShowTimerText"] = true,
							["Type"] = "reactive",
							["Name"] = "1495",
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(1495)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "MANAUSABLE",
									["Name"] = "1495",
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "COUNTER",
									["Name"] = "melee_range",
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1TVSeFFt8WOP",
						}, -- [5]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["GUID"] = "TMW:icon:1TVSYbg_QJjC",
							["ClockGCD"] = true,
							["Type"] = "swingtimer",
							["ShowTimerText"] = true,
							["Name"] = "2973",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(2973)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "MANAUSABLE",
									["Name"] = "2973",
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "COUNTER",
									["Name"] = "melee_range",
									["Level"] = 1,
								}, -- [3]
								{
									["Name"] = "2973",
									["Type"] = "SPELLCD",
								}, -- [4]
								["n"] = 4,
							},
							["CustomTex"] = "2973",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [6]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ShowTimerText"] = true,
							["GUID"] = "TMW:icon:1TVSXCaYiB0t",
							["Type"] = "swingtimer",
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "melee_range",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "6603",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [7]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["ClockGCD"] = true,
							["ShowTimerText"] = true,
							["Type"] = "cooldown",
							["Name"] = "19434",
							["Conditions"] = {
								{
									["Type"] = "PTSINTAL",
									["Name"] = "19434",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Name"] = "auto_shot",
									["Type"] = "COUNTER",
								}, -- [2]
								{
									["Name"] = "melee_range",
									["Type"] = "COUNTER",
								}, -- [3]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1TVSlzDpfz8W",
									["Level"] = 1,
								}, -- [4]
								["n"] = 4,
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1TVSIOSMkJrY",
						}, -- [8]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["DurationMaxEnabled"] = true,
							["GUID"] = "TMW:icon:1TVSNL2581Hf",
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["ShowTimerText"] = true,
							["DurationMax"] = 3,
							["Name"] = "1978; 13549; 13550; 13551; 13552; 13553; 13554; 13555; 25295",
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(1978)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "GROUP2",
									["Checked"] = true,
									["BitFlags"] = 4,
								}, -- [2]
								{
									["Name"] = "auto_shot",
									["Type"] = "COUNTER",
								}, -- [3]
								{
									["Name"] = "melee_range",
									["Type"] = "COUNTER",
								}, -- [4]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1TVSlzDpfz8W",
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
							},
							["Type"] = "buff",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [9]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["ClockGCD"] = true,
							["Type"] = "cooldown",
							["ShowTimerText"] = true,
							["Name"] = "3044",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(3044)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "MANAUSABLE",
									["Name"] = "3044",
									["Operator"] = ">=",
								}, -- [2]
								{
									["Name"] = "auto_shot",
									["Type"] = "COUNTER",
								}, -- [3]
								{
									["Name"] = "melee_range",
									["Type"] = "COUNTER",
								}, -- [4]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1TVSlzDpfz8W",
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["Fade"] = false,
									["Image"] = "2643",
									["Period"] = 0,
									["OnlyShown"] = true,
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1TVSIOVxdUiM",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1TT8M1YQC7C2",
						}, -- [10]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["GUID"] = "TMW:icon:1TT6tqd5wK83",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
							["FakeHidden"] = true,
							["BarDisplay_BarGCD"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["Fade"] = false,
									["Image"] = "1510",
									["Period"] = 0,
									["OnlyShown"] = true,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "aoe_check",
											["Level"] = 1,
										}, -- [1]
										{
											["Name"] = "spell = IsSpellKnown(1510)\n\nreturn spell",
											["Type"] = "LUA",
										}, -- [2]
										{
											["Name"] = "1510",
											["Type"] = "SPELLCD",
										}, -- [3]
										["n"] = 3,
									},
									["Event"] = "WCSP",
								}, -- [1]
								["n"] = 1,
							},
							["Name"] = 75,
							["ShowTimerText"] = true,
							["Conditions"] = {
								{
									["Name"] = "melee_range",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "5019",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [11]
						[38] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["GUID"] = "TMW:icon:1TVSrNWYFamc",
							["ShowTimerText"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["DurationMaxEnabled"] = true,
							["DurationMin"] = 3,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "1978; 13549; 13550; 13551; 13552; 13553; 13554; 13555; 25295",
							["DurationMax"] = 4.5,
							["DurationMinEnabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(1978)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "GROUP2",
									["Checked"] = true,
									["BitFlags"] = 4,
								}, -- [2]
								{
									["Name"] = "melee_range",
									["Type"] = "COUNTER",
								}, -- [3]
								{
									["Type"] = "COUNTER",
									["Name"] = "auto_shot",
									["Level"] = 1,
								}, -- [4]
								["n"] = 4,
							},
							["Type"] = "buff",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						},
						[46] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1T4P1u1jl30C",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "border_toggle",
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
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "21913",
							["GUID"] = "TMW:icon:1T4P1u1jl30C",
						},
						[54] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1TT71vNC3VXL",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "maintain_range",
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
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "19507",
							["GUID"] = "TMW:icon:1TT71vNC3VXL",
						},
						[76] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ShowTimerText"] = true,
							["Type"] = "conditionicon",
							["Name"] = "2643",
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(2643)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Name"] = "2643",
									["Type"] = "SPELLCD",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "2643",
							["GUID"] = "TMW:icon:1TVSIOVxdUiM",
						},
						[39] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["DurationMaxEnabled"] = true,
							["GUID"] = "TMW:icon:1TVSIOUd0NXr",
							["ShowTimerText"] = true,
							["ClockGCD"] = true,
							["Name"] = "3044",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["Fade"] = false,
									["Image"] = "2643",
									["Period"] = 0,
									["OnlyShown"] = true,
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1TVSIOVxdUiM",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
								}, -- [1]
								["n"] = 1,
							},
							["DurationMax"] = 1.5,
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(3044)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "MANAUSABLE",
									["Name"] = "3044",
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "COUNTER",
									["Name"] = "auto_shot",
									["Level"] = 1,
								}, -- [3]
								{
									["Name"] = "melee_range",
									["Type"] = "COUNTER",
								}, -- [4]
								["n"] = 4,
							},
							["Type"] = "cooldown",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						},
						[47] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1T4P1xmqHSKq",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "border_toggle",
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
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "21913",
							["GUID"] = "TMW:icon:1T4P1xmqHSKq",
						},
						[55] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1TT6FY9Xs0Km",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "maintain_range",
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
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "19507",
							["GUID"] = "TMW:icon:1TT6FY9Xs0Km",
						},
						[78] = {
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Name"] = "2974; 14267; 14268",
							["GUID"] = "TMW:icon:1ToXQH9jBX8w",
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
							["OnlyMine"] = true,
							["Unit"] = "target",
						},
						[94] = {
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "20043; 20190",
							["OnlyMine"] = true,
							["GUID"] = "TMW:icon:1TVSIOWpyLe9",
						},
						[32] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["GUID"] = "TMW:icon:1TVSqJ8ycRuW",
							["FakeHidden"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["DurationMaxEnabled"] = true,
							["DurationMin"] = 3,
							["Unit"] = "target",
							["ClockGCD"] = true,
							["ShowTimerText"] = true,
							["Name"] = "1130; 14323; 14324; 14325",
							["DurationMax"] = 4.5,
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(1130)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Name"] = "melee_range",
									["Type"] = "COUNTER",
								}, -- [2]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1TVSlzDpfz8W",
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["DurationMinEnabled"] = true,
							["Type"] = "buff",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						},
						[40] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["GUID"] = "TMW:icon:1TVSIOUeNL9L",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
							["BarDisplay_BarGCD"] = true,
							["ShowTimerText"] = true,
							["FakeHidden"] = true,
							["Name"] = 75,
							["Conditions"] = {
								{
									["Name"] = "melee_range",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "5019",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						},
						[48] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1T4P1xmoGuCz",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "combat_toggle",
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
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "13715",
							["GUID"] = "TMW:icon:1T4P1xmoGuCz",
						},
						[80] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["ShowTimerText"] = true,
							["GUID"] = "TMW:icon:1TVSIOWJ1T0I",
							["Name"] = "5116",
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(5116)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
							["Type"] = "cooldown",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						},
						[96] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1TVMn47SY695",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "melee_range",
								}, -- [1]
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1TVMn47SY695",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "melee_range",
								}, -- [2]
								["n"] = 2,
							},
							["Conditions"] = {
								{
									["Operator"] = "<=",
									["Level"] = 5,
									["Type"] = "LIBRANGECHECK",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "19382",
							["GUID"] = "TMW:icon:1TVMn47SY695",
						},
						[33] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["DurationMaxEnabled"] = true,
							["ShowTimerText"] = true,
							["Unit"] = "target",
							["ClockGCD"] = true,
							["OnlyMine"] = true,
							["Name"] = "5116",
							["DurationMax"] = 1.5,
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(5116)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Name"] = "melee_range",
									["Type"] = "COUNTER",
								}, -- [2]
								{
									["Type"] = "COUNTER",
									["Name"] = "maintain_range",
									["Level"] = 1,
								}, -- [3]
								{
									["Name"] = "targettarget",
									["Type"] = "UNITISUNIT",
								}, -- [4]
								{
									["Name"] = "5116",
									["Type"] = "SPELLCD",
								}, -- [5]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1ToXQH9jBX8w",
									["Level"] = 1,
								}, -- [6]
								["n"] = 6,
							},
							["GUID"] = "TMW:icon:1TVSqR9grYi3",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						},
						[49] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1T4P1xnQKUWR",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "combat_toggle",
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
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "13715",
							["GUID"] = "TMW:icon:1T4P1xnQKUWR",
						},
						[34] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["DurationMaxEnabled"] = true,
							["Type"] = "buff",
							["Unit"] = "target",
							["ClockGCD"] = true,
							["OnlyMine"] = true,
							["ShowTimerText"] = true,
							["DurationMax"] = 1.5,
							["Name"] = "2974; 14267; 14268",
							["Conditions"] = {
								{
									["Type"] = "MANAUSABLE",
									["Name"] = "2974",
									["Operator"] = ">=",
								}, -- [1]
								{
									["Type"] = "COUNTER",
									["Name"] = "melee_range",
									["Level"] = 1,
								}, -- [2]
								{
									["Icon"] = "TMW:icon:1TVSIOW0oWeD",
									["Type"] = "ICON",
								}, -- [3]
								{
									["Name"] = "maintain_range",
									["Type"] = "COUNTER",
								}, -- [4]
								["n"] = 4,
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1TVSqg4jQ45b",
						},
						[50] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1T4P1xniOGqa",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "target_toggle",
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
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "1130",
							["GUID"] = "TMW:icon:1T4P1xniOGqa",
						},
						[35] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["ClockGCD"] = true,
							["GUID"] = "TMW:icon:1TVSqyJmaHeI",
							["ShowTimerText"] = true,
							["Name"] = "2973",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(2973)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "MANAUSABLE",
									["Name"] = "2973",
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "COUNTER",
									["Name"] = "melee_range",
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["Type"] = "cooldown",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						},
						[51] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1T4P1xnF_P8f",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "target_toggle",
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
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "1130",
							["GUID"] = "TMW:icon:1T4P1xnF_P8f",
						},
						[15] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Rotation",
									},
								},
							},
							["CustomTex"] = "NONE",
							["Enabled"] = true,
						},
						[30] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Rotation 2",
									},
								},
							},
							["CustomTex"] = "NONE",
							["Enabled"] = true,
						},
						[36] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ShowTimerText"] = true,
							["GUID"] = "TMW:icon:1TVSrBJJfETs",
							["Type"] = "swingtimer",
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "melee_range",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "6603",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						},
						[52] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1TRnVZQs2rOa",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "heal/dps_toggle",
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
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "133",
							["GUID"] = "TMW:icon:1TRnVZQs2rOa",
						},
						[60] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Toggles",
									},
								},
							},
							["Enabled"] = true,
							["CustomTex"] = "NONE",
							["GUID"] = "TMW:icon:1TT6FY9daRvb",
						},
						[91] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1TRoURgXVpaz",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "aoe_check",
								}, -- [1]
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Icon"] = "TMW:icon:1TRoURgXVpaz",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "aoe_check",
								}, -- [2]
								["n"] = 2,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"4", -- [2]
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "local inRange = 0\nfor i = 1, 15 do\n    if UnitExists('nameplate' .. i) and IsSpellInRange('Arcane Explosion', 'nameplate' .. i) == 1 then\n        inRange = inRange + 1\n    end\nend\nif inRange > 2 then    \n    \n    return true\nend",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "LEVEL",
									["Level"] = 20,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Name"] = "aoe_toggle",
									["Type"] = "COUNTER",
								}, -- [3]
								["n"] = 3,
							},
							["CustomTex"] = "10",
							["GUID"] = "TMW:icon:1TRoURgXVpaz",
						},
						[88] = {
							["Conditions"] = {
								{
									["Name"] = "local ammoSlot = GetInventorySlotInfo(\"AmmoSlot\");\nlocal ammoCount = GetInventoryItemCount(\"player\", ammoSlot);\nif ((ammoCount == 1) and (not GetInventoryItemTexture(\"player\", ammoSlot))) then\n    ammoCount = 0;\n    \n    if ammoCount = 0 then\n        return true\n    end\n    \nend;",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
						},
						[93] = {
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "13165; 14318; 14319; 14320; 14321; 14322; 25296",
							["OnlyMine"] = true,
							["GUID"] = "TMW:icon:1TVSIOWoVz8k",
						},
						[95] = {
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "20043; 20190; 13165; 14318; 14319; 14320; 14321; 14322; 25296; 13161; 5118; 13159; 13163",
							["OnlyMine"] = true,
							["GUID"] = "TMW:icon:1TVSIOWrar8Y",
						},
						[37] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["DurationMaxEnabled"] = true,
							["GUID"] = "TMW:icon:1TVSrFdTPYOk",
							["ShowTimerText"] = true,
							["ClockGCD"] = true,
							["Name"] = "19434",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Image"] = "5676",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["OnConditionConditions"] = {
										{
											["Operator"] = "<",
											["Level"] = 10,
											["Type"] = "HEALTH",
											["Unit"] = "target",
										}, -- [1]
										{
											["Name"] = "spell = IsSpellKnown(5676)\n\nreturn spell",
											["Type"] = "LUA",
										}, -- [2]
										["n"] = 2,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [1]
								["n"] = 1,
							},
							["DurationMax"] = 1.5,
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "PTSINTAL",
									["Name"] = "19434",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Type"] = "COUNTER",
									["Name"] = "auto_shot",
									["Level"] = 1,
								}, -- [2]
								{
									["Name"] = "melee_range",
									["Type"] = "COUNTER",
								}, -- [3]
								["n"] = 3,
							},
							["Type"] = "cooldown",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						},
						[45] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Predict",
									},
								},
							},
							["CustomTex"] = "NONE",
							["Enabled"] = true,
						},
						[53] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1TRnVZQtHJGK",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "heal/dps_toggle",
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
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "116",
							["GUID"] = "TMW:icon:1TRnVZQtHJGK",
						},
						[79] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["GUID"] = "TMW:icon:1TVSIOWDccaT",
							["ShowTimerText"] = true,
							["Name"] = "781",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Name"] = "targettarget",
											["Type"] = "UNITISUNIT",
										}, -- [1]
										{
											["Type"] = "GROUP2",
											["Checked"] = true,
											["BitFlags"] = 1,
										}, -- [2]
										["n"] = 2,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(781)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "COUNTER",
									["Name"] = "melee_range",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "ICON",
									["AndOr"] = "OR",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["Icon"] = "TMW:icon:1TVSIOWJ1T0I",
								}, -- [3]
								["n"] = 3,
							},
							["Type"] = "cooldown",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						},
						[75] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "Predict Help",
									},
								},
							},
							["CustomTex"] = "NONE",
							["Enabled"] = true,
						},
						[97] = {
							["Enabled"] = true,
							["CLEUEvents"] = {
								["RANGE_DAMAGE"] = true,
							},
							["Name"] = "75",
							["CLEUDur"] = 1,
							["Type"] = "cleu",
							["Events"] = {
								{
									["Type"] = "Counter",
									["Event"] = "OnShow",
									["Counter"] = "auto_shot",
								}, -- [1]
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "auto_shot",
											["Level"] = 2,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "OnCondition",
									["Counter"] = "auto_shot",
								}, -- [2]
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Type"] = "COMBAT",
											["Name"] = "auto_shot",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "auto_shot",
								}, -- [3]
								["n"] = 3,
							},
						},
						[77] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ShowTimerText"] = true,
							["Type"] = "conditionicon",
							["Name"] = "2643",
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(2974)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								{
									["Type"] = "LUA",
									["Name"] = "spell = IsSpellKnown(14267)\n\nreturn spell",
									["AndOr"] = "OR",
								}, -- [2]
								{
									["Type"] = "LUA",
									["Name"] = "spell = IsSpellKnown(14268)\n\nreturn spell",
									["AndOr"] = "OR",
								}, -- [3]
								["n"] = 3,
							},
							["CustomTex"] = "2974",
							["GUID"] = "TMW:icon:1TVSIOW0oWeD",
						},
					},
					["Point"] = {
						["y"] = -7.30746799045408,
						["x"] = 4.18984222412109,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TRk_aZypIqd",
					["Columns"] = 2,
					["Name"] = "Top Bar",
					["SettingsPerView"] = {
						["icon"] = {
							["SpacingX"] = 65,
						},
					},
					["Scale"] = 1.0863,
					["Conditions"] = {
						{
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						["n"] = 8,
					},
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TVSIOWDccaT", -- [1]
								"TMW:icon:1TVSIOWJ1T0I", -- [2]
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TVSqJ8ycRuW", -- [1]
								"TMW:icon:1TVSqR9grYi3", -- [2]
								"TMW:icon:1TVSqg4jQ45b", -- [3]
								"TMW:icon:1TVSqyJmaHeI", -- [4]
								"TMW:icon:1TVSrBJJfETs", -- [5]
								"TMW:icon:1TVSrFdTPYOk", -- [6]
								"TMW:icon:1TVSrNWYFamc", -- [7]
								"TMW:icon:1TVSIOUd0NXr", -- [8]
								"TMW:icon:1TVSIOUeNL9L", -- [9]
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [2]
					},
					["Point"] = {
						["y"] = -2.45231879086471e-05,
						["relativeTo"] = "TMW:group:1TRW5crzGrfW",
						["point"] = "BOTTOM",
						["relativePoint"] = "BOTTOM",
						["x"] = 1.56344934325808e-05,
					},
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TRW5crzGrfW",
					["Columns"] = 1,
					["Name"] = "Main Meta",
					["Scale"] = 1.5,
					["Conditions"] = {
						{
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						["n"] = 8,
					},
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ffffff00",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Name"] = "2973",
											["Type"] = "CURRENTSPELL",
										}, -- [1]
										{
											["Type"] = "CURRENTSPELL",
											["Name"] = "14260",
											["AndOr"] = "OR",
										}, -- [2]
										{
											["Type"] = "CURRENTSPELL",
											["Name"] = "14261",
											["AndOr"] = "OR",
										}, -- [3]
										{
											["Type"] = "CURRENTSPELL",
											["Name"] = "14262",
											["AndOr"] = "OR",
										}, -- [4]
										{
											["Type"] = "CURRENTSPELL",
											["Name"] = "14263",
											["AndOr"] = "OR",
										}, -- [5]
										{
											["Type"] = "CURRENTSPELL",
											["Name"] = "14264",
											["AndOr"] = "OR",
										}, -- [6]
										{
											["Type"] = "CURRENTSPELL",
											["Name"] = "14265",
											["AndOr"] = "OR",
										}, -- [7]
										{
											["Type"] = "CURRENTSPELL",
											["Name"] = "14266",
											["AndOr"] = "OR",
										}, -- [8]
										["n"] = 8,
									},
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								["n"] = 2,
							},
							["Icons"] = {
								"TMW:icon:1TVSlzDpfz8W", -- [1]
								"TMW:icon:1TVSkh271Uiv", -- [2]
								"TMW:icon:1TVSglioC2HZ", -- [3]
								"TMW:icon:1TVSeFFt8WOP", -- [4]
								"TMW:icon:1TVSYbg_QJjC", -- [5]
								"TMW:icon:1TVSXCaYiB0t", -- [6]
								"TMW:icon:1TVSIOSMkJrY", -- [7]
								"TMW:icon:1TVSNL2581Hf", -- [8]
								"TMW:icon:1TT8M1YQC7C2", -- [9]
								"TMW:icon:1TT6tqd5wK83", -- [10]
							},
							["GUID"] = "TMW:icon:1TT6FY4b9DCn",
						}, -- [1]
					},
					["Point"] = {
						["y"] = -97.4739888509115,
						["x"] = -1.26411946614583,
					},
				}, -- [3]
				{
					["View"] = "bar",
					["Columns"] = 1,
					["GUID"] = "TMW:group:1TRksRXJhTqd",
					["Scale"] = 0.805015742778778,
					["Rows"] = 4,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "value",
							["Events"] = {
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Animation"] = "ICONBORDER",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"[((Value / ValueMax) * 100):Round:Percent]", -- [1]
										"", -- [2]
									},
								},
							},
							["CustomTex"] = "NONE",
						}, -- [1]
						{
							["BackdropColor"] = "ff000000",
							["Type"] = "meta",
							["BackdropColor_Enable"] = true,
							["Icons"] = {
								"TMW:icon:1To6LX9wT1uA", -- [1]
								"TMW:icon:1To6LX9zRfuK", -- [2]
							},
							["EnableStacks"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"", -- [2]
									},
								},
							},
							["Enabled"] = true,
							["TimerBar_CompleteColor"] = "ff000000",
							["TimerBar_EnableColors"] = true,
							["OnlyInBags"] = true,
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "value",
							["TimerBar_MiddleColor"] = "ff9b8214",
							["TimerBar_CompleteColor"] = "ff2c9b14",
							["Unit"] = "pet",
							["PowerType"] = -1,
							["Events"] = {
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["Fade"] = false,
									["Thickness"] = 3,
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Animation"] = "ICONBORDER",
								}, -- [1]
								{
									["Thickness"] = 3,
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["OnConditionConditions"] = {
										{
											["Type"] = "COMBAT",
											["Name"] = "border_toggle",
											["Unit"] = "pet",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Animation"] = "ICONBORDER",
								}, -- [2]
								["n"] = 2,
							},
							["TimerBar_StartColor"] = "ffb00000",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"[(Value / ValueMax * 100):Round:Percent]", -- [1]
										"      [Name(unit=\"pet\"):Cyan]", -- [2]
									},
								},
							},
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
							["TimerBar_EnableColors"] = true,
							["CustomTex"] = "NONE",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["TimerBar_MiddleColor"] = "ff9b8214",
							["TimerBar_CompleteColor"] = "ffb00000",
							["Unit"] = "pet",
							["PowerType"] = -1,
							["Events"] = {
								{
									["Thickness"] = 3,
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONBORDER",
									["OnlyShown"] = true,
									["AnimColor"] = "ffffff00",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Type"] = "EXISTS",
											["Level"] = 1,
											["Name"] = "border_toggle",
											["Unit"] = "pet",
										}, -- [1]
										{
											["Type"] = "ALIVE",
											["Level"] = 1,
											["AndOr"] = "OR",
											["Unit"] = "pet",
										}, -- [2]
										["n"] = 2,
									},
								}, -- [1]
								["n"] = 1,
							},
							["TimerBar_StartColor"] = "ffb00000",
							["SettingsPerView"] = {
								["bar"] = {
									["TextLayout"] = "bar1",
									["Texts"] = {
										"", -- [1]
										"      REVIVE/CALL PET", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "EXISTS",
									["Level"] = 1,
									["Unit"] = "pet",
								}, -- [1]
								{
									["Type"] = "ALIVE",
									["AndOr"] = "OR",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["Unit"] = "pet",
								}, -- [2]
								{
									["Name"] = "spell = IsSpellKnown(883)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [3]
								["n"] = 3,
							},
							["TimerBar_EnableColors"] = true,
							["CustomTex"] = "883",
						}, -- [4]
					},
					["TextureName"] = "Solid",
					["BackdropColor"] = "ff000000",
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
					["Name"] = "Bars",
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 170,
							["Icon"] = false,
							["SizeY"] = 22,
						},
					},
					["ShrinkGroup"] = true,
					["Conditions"] = {
						{
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						["n"] = 8,
					},
					["BackdropColor_Enable"] = true,
					["Point"] = {
						["y"] = 8.96281651823714e-05,
						["relativeTo"] = "TMW:group:1TRW5crzGrfW",
						["point"] = "TOP",
						["relativePoint"] = "BOTTOM",
						["x"] = -8.92121632755042e-05,
					},
				}, -- [4]
				{
					["GUID"] = "TMW:group:1TRnYiiWZwGk",
					["Columns"] = 7,
					["Scale"] = 0.92,
					["Icons"] = {
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["OnlyInBags"] = true,
							["ShowTimerText"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [1]
								["n"] = 1,
							},
							["Type"] = "cooldown",
							["Name"] = "1510",
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(1510)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
							["OnlyEquipped"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["OnlyInBags"] = true,
							["ShowTimerText"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [1]
								["n"] = 1,
							},
							["Type"] = "cooldown",
							["Name"] = "13795",
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(13795)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
							["OnlyEquipped"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [2]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["OnlyInBags"] = true,
							["ShowTimerText"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [1]
								["n"] = 1,
							},
							["Type"] = "cooldown",
							["Name"] = "5384",
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(5384)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
							["OnlyEquipped"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [3]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["OnlyInBags"] = true,
							["ShowTimerText"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [1]
								["n"] = 1,
							},
							["Type"] = "cooldown",
							["Name"] = "19503",
							["Conditions"] = {
								{
									["Type"] = "PTSINTAL",
									["Name"] = "19503",
									["Operator"] = "~=",
								}, -- [1]
								["n"] = 1,
							},
							["OnlyEquipped"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [4]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["OnlyInBags"] = true,
							["ShowTimerText"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [1]
								["n"] = 1,
							},
							["Type"] = "cooldown",
							["Name"] = "19263",
							["Conditions"] = {
								{
									["Type"] = "PTSINTAL",
									["Name"] = "19263",
									["Operator"] = "~=",
								}, -- [1]
								["n"] = 1,
							},
							["OnlyEquipped"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [5]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["OnlyInBags"] = true,
							["ShowTimerText"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [1]
								["n"] = 1,
							},
							["Type"] = "cooldown",
							["Name"] = "19574",
							["Conditions"] = {
								{
									["Type"] = "PTSINTAL",
									["Name"] = "19574",
									["Operator"] = "~=",
								}, -- [1]
								["n"] = 1,
							},
							["OnlyEquipped"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [6]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["OnlyInBags"] = true,
							["ShowTimerText"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [1]
								["n"] = 1,
							},
							["Type"] = "cooldown",
							["Name"] = "3045",
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(3045)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
							["OnlyEquipped"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [7]
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
					["Name"] = "Bottom Bar",
					["ShrinkGroup"] = true,
					["Conditions"] = {
						{
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						["n"] = 8,
					},
					["Point"] = {
						["y"] = -0.000505423965076154,
						["relativeTo"] = "TMW:group:1TRksRXJhTqd",
						["point"] = "TOP",
						["relativePoint"] = "BOTTOM",
						["x"] = 0.00143467317442142,
					},
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
					["Rows"] = 8,
					["TimerBar_CompleteColor"] = "ff008fff",
					["Locked"] = true,
					["TimerBar_EnableColors"] = true,
					["Columns"] = 1,
					["BackdropColor_Enable"] = true,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["TimerBar_CompleteColor"] = "ff886332",
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
							["TimerBar_EnableColors"] = true,
							["Conditions"] = {
								{
									["Icon"] = "TMW:icon:1T1lwuRfZ3C7",
									["Type"] = "ICON",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "NONE",
							["BarDisplay_Invert"] = true,
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["TimerBar_CompleteColor"] = "ff463f5e",
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
							["TimerBar_EnableColors"] = true,
							["CustomTex"] = "NONE",
							["BarDisplay_Invert"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 46\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 47\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\n\n",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "border_toggle",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnlyShown"] = true,
									["AnimColor"] = "ff00fff1",
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
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 48\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 49\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\n\n",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "combat_toggle",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnlyShown"] = true,
									["AnimColor"] = "ff00fff1",
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
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 50\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 51\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\n\n",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "target_toggle",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnlyShown"] = true,
									["AnimColor"] = "ff00fff1",
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
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["TimerBar_CompleteColor"] = "ff463f5e",
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
							["TimerBar_EnableColors"] = true,
							["CustomTex"] = "NONE",
							["BarDisplay_Invert"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [6]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"[Class(unit=\"player\")]", -- [2]
									},
								},
							},
							["BarDisplay_Reverse"] = true,
							["BarDisplay_Invert"] = true,
						}, -- [7]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 54\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 55\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\n\n",
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "maintain_range",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["AnimColor"] = "af00c0ff",
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
										"[\"Use Slows\":Yellow]", -- [1]
										"Attempt to Maintain Range", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["TimerBar_CompleteColor"] = "005dff55",
							["CustomTex"] = "NONE",
							["BarDisplay_Invert"] = true,
						}, -- [8]
						{
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "heal/dps_toggle",
											["Level"] = 1,
										}, -- [1]
										{
											["Type"] = "MOUSEOVER",
										}, -- [2]
										["n"] = 2,
									},
									["Event"] = "WCSP",
									["Animation"] = "ICONFLASH",
								}, -- [1]
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["AnimColor"] = "9400d4ff",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Name"] = "heal/dps_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										{
											["Type"] = "MOUSEOVER",
										}, -- [2]
										["n"] = 2,
									},
								}, -- [2]
								{
									["Type"] = "Lua",
									["Lua"] = "DEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 52\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\nDEFAULT_CHAT_FRAME.editBox:SetText(\"/tmw toggle 1 53\")\nChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)\n\n\n",
									["Event"] = "OnLeftClick",
								}, -- [3]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Name"] = "heal/dps_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [4]
								{
									["Animation"] = "ICONFLASH",
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "9400d4ff",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "heal/dps_toggle",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [5]
								["n"] = 5,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										" [\"Fire\":Red] / [\"Frost\":Cyan] Rotation", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["TimerBar_CompleteColor"] = "005dff55",
							["CustomTex"] = "NONE",
							["BarDisplay_Invert"] = true,
						}, -- [9]
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
					["GUID"] = "TMW:group:1T4PJbRYY3Gh",
					["Conditions"] = {
						{
							["Type"] = "COUNTER",
							["Name"] = "menu_open",
							["Level"] = 1,
						}, -- [1]
						["n"] = 1,
					},
					["BackdropColor"] = "00333333",
					["ShrinkGroup"] = true,
				}, -- [6]
				{
					["GUID"] = "TMW:group:1T1lA4Tqg1qw",
					["Strata"] = "LOW",
					["Columns"] = 2,
					["Scale"] = 1.36504948139191,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Counter",
									["Event"] = "OnLeftClick",
									["Counter"] = "menu_open",
								}, -- [1]
								{
									["Type"] = "Counter",
									["Event"] = "OnRightClick",
									["Counter"] = "menu_open",
								}, -- [2]
								{
									["Type"] = "Counter",
									["Counter"] = "menu_open",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Level"] = 2,
											["Name"] = "menu_open",
											["Operator"] = ">=",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Frequency"] = 0.2,
								}, -- [3]
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "settings_help",
								}, -- [4]
								{
									["Type"] = "Counter",
									["CounterAmt"] = 0,
									["CounterOperation"] = "=",
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Counter"] = "settings_help",
								}, -- [5]
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [6]
								["n"] = 6,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["CustomTex"] = "20593",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["ShowTimerText"] = true,
							["CustomTex"] = "Attack",
							["FakeHidden"] = true,
							["OnlyIfCounting"] = true,
							["Events"] = {
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["CounterAmt"] = 0,
									["Event"] = "OnHide",
									["Counter"] = "menu_open",
								}, -- [1]
								{
									["Type"] = "Counter",
									["CounterOperation"] = "=",
									["CounterAmt"] = 0,
									["Event"] = "OnHide",
									["Counter"] = "menu_open_c",
								}, -- [2]
								{
									["Type"] = "Counter",
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
									["Event"] = "OnCondition",
									["Counter"] = "menu_open_c",
								}, -- [3]
								["n"] = 3,
							},
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
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["AndOr"] = "OR",
									["Name"] = "menu_open_c",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDurEnabled"] = true,
							["ConditionDur"] = 5,
						}, -- [2]
					},
					["LayoutDirection"] = 4,
					["EnabledProfiles"] = {
						["Maverin - Area 52"] = false,
					},
					["Name"] = "Cooldown Menu Button",
					["EnabledSpecs"] = {
						[259] = false,
						[260] = false,
					},
					["Point"] = {
						["y"] = 25.5816574684556,
						["x"] = 11.5128307342529,
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
					},
				}, -- [7]
				{
					["GUID"] = "TMW:group:1TVT63sQgMqo",
					["Strata"] = "HIGH",
					["Columns"] = 1,
					["Name"] = "Aspects",
					["Scale"] = 0.600000023841858,
					["Conditions"] = {
						{
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						["n"] = 8,
					},
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["Alpha"] = 1,
									["Fade"] = false,
									["Image"] = "13159",
									["Period"] = 0,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Checked"] = true,
											["AndOr"] = "OR",
											["Icon"] = "TMW:icon:1TVSIOWoVz8k",
											["Name"] = "border_toggle",
										}, -- [1]
										{
											["Icon"] = "TMW:icon:1TVSIOWrar8Y",
											["Type"] = "ICON",
										}, -- [2]
										["n"] = 2,
									},
									["Event"] = "WCSP",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Image"] = "13161",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["OnConditionConditions"] = {
										{
											["Checked"] = true,
											["Type"] = "BUFFDUR",
											["Name"] = "13161",
											["Operator"] = "~=",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["Type"] = "Animations",
									["Image"] = "13165",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Checked"] = true,
											["Name"] = "14318",
											["AndOr"] = "OR",
											["Icon"] = "TMW:icon:1TVSIOWoVz8k",
											["Operator"] = "~=",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [3]
								{
									["Type"] = "Animations",
									["Image"] = "13163",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["OnConditionConditions"] = {
										{
											["Type"] = "BUFFDUR",
											["Checked"] = true,
											["Name"] = "13163",
											["AndOr"] = "OR",
											["Icon"] = "TMW:icon:1TVSIOWoVz8k",
											["Operator"] = "~=",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [4]
								{
									["Type"] = "Animations",
									["Image"] = "5118",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["OnConditionConditions"] = {
										{
											["Checked"] = true,
											["Type"] = "BUFFDUR",
											["Name"] = "5118",
											["Operator"] = "~=",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [5]
								{
									["Type"] = "Animations",
									["Image"] = "20043",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["OnConditionConditions"] = {
										{
											["Type"] = "ICON",
											["Checked"] = true,
											["Name"] = "14318",
											["AndOr"] = "OR",
											["Icon"] = "TMW:icon:1TVSIOWpyLe9",
											["Operator"] = "~=",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [6]
								{
									["Type"] = "Animations",
									["Image"] = "13159",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["OnConditionConditions"] = {
										{
											["Type"] = "BUFFDUR",
											["Checked"] = true,
											["Name"] = "13159",
											["AndOr"] = "OR",
											["Icon"] = "TMW:icon:1TVSIOWoVz8k",
											["Operator"] = "~=",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [7]
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["Image"] = "13159",
									["OnConditionConditions"] = {
										{
											["Type"] = "BUFFDUR",
											["Checked"] = true,
											["Name"] = "13159",
											["AndOr"] = "OR",
											["Icon"] = "TMW:icon:1TVSIOWoVz8k",
											["Operator"] = "~=",
										}, -- [1]
										["n"] = 1,
									},
									["Alpha"] = 1,
									["Event"] = "WCSP",
								}, -- [8]
								["n"] = 8,
							},
							["CustomTex"] = "NONE",
						}, -- [1]
					},
					["Point"] = {
						["relativeTo"] = "TMW:group:1TRW5crzGrfW",
						["point"] = "BOTTOM",
						["relativePoint"] = "TOP",
					},
				}, -- [8]
				{
					["View"] = "bar",
					["Columns"] = 1,
					["Scale"] = 1.59580385684967,
					["Icons"] = {
						{
							["BackdropColor"] = "00333333",
							["Type"] = "conditionicon",
							["BackdropColor_Enable"] = true,
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"Version 1.0.6", -- [1]
										"[\"Hunter\":Yellow]", -- [2]
									},
								},
							},
							["TimerBar_CompleteColor"] = "0000ff00",
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "settings_help",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
							["TimerBar_EnableColors"] = true,
							["Enabled"] = true,
						}, -- [1]
					},
					["Name"] = "Version",
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 128.9,
							["Icon"] = false,
						},
					},
					["Locked"] = true,
					["GUID"] = "TMW:group:1TlsU424Yf48",
					["Point"] = {
						["y"] = -83.1354304445333,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
				}, -- [9]
				{
					["View"] = "bar",
					["Strata"] = "HIGH",
					["Columns"] = 20,
					["Scale"] = 1.14,
					["Icons"] = {
						{
							["StackMin"] = 25,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffa30000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [1]
						{
							["StackMin"] = 50,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffa30000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [2]
						{
							["StackMin"] = 75,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffa30000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [3]
						{
							["StackMin"] = 100,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffa30000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [4]
						{
							["StackMin"] = 125,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffa30000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [5]
						{
							["StackMin"] = 150,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffa30000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [6]
						{
							["StackMin"] = 175,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffa30000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [7]
						{
							["StackMin"] = 200,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffa30000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [8]
						{
							["StackMin"] = 225,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffa30000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [9]
						{
							["StackMin"] = 250,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffa30000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [10]
						{
							["StackMin"] = 275,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffa30000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [11]
						{
							["StackMin"] = 300,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffa30000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [12]
						{
							["StackMin"] = 325,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffa30000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [13]
						{
							["StackMin"] = 350,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffa30000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [14]
						{
							["StackMin"] = 375,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffbf0000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [15]
						{
							["StackMin"] = 400,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffbf0000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [16]
						{
							["StackMin"] = 425,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffbf0000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [17]
						{
							["StackMin"] = 450,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffbf0000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [18]
						{
							["StackMin"] = 475,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffbf0000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [19]
						{
							["StackMin"] = 500,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffcf0000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [20]
					},
					["Name"] = "Ammo 1",
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 1.8,
							["BorderInset"] = false,
							["Icon"] = false,
							["SizeY"] = 10,
						},
					},
					["Conditions"] = {
						{
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						["n"] = 8,
					},
					["GUID"] = "TMW:group:1To6C6Z742Ke",
					["Point"] = {
						["y"] = -42,
						["relativeTo"] = "TMW:group:1TRW5crzGrfW",
						["x"] = -5,
						["relativePoint"] = "LEFT",
					},
				}, -- [10]
				{
					["View"] = "bar",
					["Strata"] = "HIGH",
					["Columns"] = 20,
					["Scale"] = 1.14,
					["Icons"] = {
						{
							["StackMin"] = 525,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "fff00000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [1]
						{
							["StackMin"] = 550,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "fff00000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [2]
						{
							["StackMin"] = 575,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "fff00000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [3]
						{
							["StackMin"] = 600,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "fff00000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [4]
						{
							["StackMin"] = 625,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffff0000",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [5]
						{
							["StackMin"] = 650,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffff0800",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [6]
						{
							["StackMin"] = 675,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffff1800",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [7]
						{
							["StackMin"] = 700,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffff2800",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [8]
						{
							["StackMin"] = 725,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffff3700",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [9]
						{
							["StackMin"] = 750,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffff4a00",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [10]
						{
							["StackMin"] = 775,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffff5d00",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [11]
						{
							["StackMin"] = 800,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffff6c00",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [12]
						{
							["StackMin"] = 825,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffff7d00",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [13]
						{
							["StackMin"] = 850,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffff9900",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [14]
						{
							["StackMin"] = 875,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffffb100",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [15]
						{
							["StackMin"] = 900,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffffc500",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [16]
						{
							["StackMin"] = 925,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffffd800",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [17]
						{
							["StackMin"] = 950,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "fffff300",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [18]
						{
							["StackMin"] = 975,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "fffff300",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [19]
						{
							["StackMin"] = 1000,
							["Type"] = "item",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ffffff00",
							["EnableStacks"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["StackMinEnabled"] = true,
							["BarDisplay_Invert"] = true,
							["OnlyInBags"] = true,
						}, -- [20]
					},
					["Name"] = "Ammo2",
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 1.8,
							["Icon"] = false,
							["SizeY"] = 10,
						},
					},
					["Locked"] = true,
					["Conditions"] = {
						{
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						["n"] = 8,
					},
					["GUID"] = "TMW:group:1To6LXAC9Pm=",
					["Point"] = {
						["relativeTo"] = "TMW:group:1To6C6Z742Ke",
						["point"] = "LEFT",
						["relativePoint"] = "RIGHT",
					},
				}, -- [11]
				{
					["View"] = "bar",
					["Columns"] = 2,
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 67.0383911132813,
						},
					},
					["Scale"] = 1.11061465740204,
					["GUID"] = "TMW:group:1To6c=dO874e",
					["Icons"] = {
						{
							["StackMin"] = 200,
							["Type"] = "item",
							["GUID"] = "TMW:icon:1To6LX9wT1uA",
							["BackdropColor"] = "ff000000",
							["StackMax"] = 1000,
							["TimerBar_CompleteColor"] = "ff000000",
							["EnableStacks"] = true,
							["FakeHidden"] = true,
							["Enabled"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"", -- [2]
									},
								},
							},
							["BackdropColor_Enable"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
							["OnlyInBags"] = true,
						}, -- [1]
						{
							["BackdropColor"] = "ff000000",
							["Type"] = "item",
							["GUID"] = "TMW:icon:1To6LX9zRfuK",
							["StackMax"] = 200,
							["TimerBar_CompleteColor"] = "ff000000",
							["StackMaxEnabled"] = true,
							["FakeHidden"] = true,
							["EnableStacks"] = true,
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"[\"LOW AMMO\":Yellow] [Stacks:Hide(0)]", -- [1]
										"", -- [2]
									},
								},
							},
							["BackdropColor_Enable"] = true,
							["Enabled"] = true,
							["TimerBar_EnableColors"] = true,
							["OnlyInBags"] = true,
						}, -- [2]
					},
					["Point"] = {
						["y"] = -118.407198257969,
						["x"] = 0.613753437995911,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
				}, -- [12]
				{
					["GUID"] = "TMW:group:1To6q47skjGf",
					["Strata"] = "HIGH",
					["Columns"] = 1,
					["SettingsPerView"] = {
						["icon"] = {
							["BorderIcon"] = 4,
							["BorderInset"] = true,
						},
					},
					["Scale"] = 0.59,
					["Conditions"] = {
						{
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						["n"] = 8,
					},
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "2512; 2516; 4960; 2514; 8067; 2515; 2519; 5568; 3029; 8068; 3030; 3033; 3031; 8069; 3464; 3465; 9399; 10579; 10512; 11285; 11284; 10513; 11630; 19316; 19317; 15997; 18042; 12654; 13377",
							["OnlyInBags"] = true,
						}, -- [1]
					},
					["Point"] = {
						["y"] = -0.999934032665234,
						["relativeTo"] = "TMW:group:1To6C6Z742Ke",
						["point"] = "RIGHT",
						["relativePoint"] = "LEFT",
						["x"] = -2.28601756468449,
					},
				}, -- [13]
				{
					["View"] = "bar",
					["Strata"] = "HIGH",
					["Columns"] = 1,
					["Scale"] = 0.25,
					["Icons"] = {
						{
							["ShowTimer"] = true,
							["TimerBar_MiddleColor"] = "ffffc800",
							["TimerBar_CompleteColor"] = "ffffc800",
							["ClockGCD"] = true,
							["BarDisplay_BarGCD"] = true,
							["TimerBar_StartColor"] = "ffffc800",
							["TimerBar_EnableColors"] = true,
							["Enabled"] = true,
							["Type"] = "cooldown",
							["BarDisplay_Invert"] = true,
							["ShowTimerText"] = true,
							["Name"] = 75,
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Image"] = "1510",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "aoe_check",
											["Level"] = 1,
										}, -- [1]
										{
											["Name"] = "spell = IsSpellKnown(1510)\n\nreturn spell",
											["Type"] = "LUA",
										}, -- [2]
										{
											["Name"] = "1510",
											["Type"] = "SPELLCD",
										}, -- [3]
										["n"] = 3,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Name"] = "melee_range",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "5019",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						}, -- [1]
					},
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 528.4,
							["Icon"] = false,
							["SizeY"] = 12,
						},
					},
					["Locked"] = true,
					["Conditions"] = {
						{
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						["n"] = 8,
					},
					["GUID"] = "TMW:group:1ToTf=FXnCas",
					["Point"] = {
						["y"] = -50,
						["relativeTo"] = "TMW:group:1TRW5crzGrfW",
						["point"] = "TOP",
						["relativePoint"] = "BOTTOM",
					},
				}, -- [14]
				{
					["GUID"] = "TMW:group:1ToW0Zn8i3m8",
					["Strata"] = "HIGH",
					["Columns"] = 1,
					["Scale"] = 0.59,
					["Locked"] = true,
					["Conditions"] = {
						{
							["PrtsBefore"] = 3,
							["Type"] = "REACT",
							["Level"] = 1,
							["Unit"] = "target",
						}, -- [1]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "target_toggle",
						}, -- [2]
						{
							["PrtsBefore"] = 1,
							["Type"] = "COMBAT",
							["AndOr"] = "OR",
						}, -- [3]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 2,
							["Name"] = "combat_toggle",
						}, -- [4]
						{
							["Type"] = "COUNTER",
							["Name"] = "target_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["Level"] = 1,
						}, -- [5]
						{
							["PrtsBefore"] = 2,
							["Type"] = "COMBAT",
						}, -- [6]
						{
							["Type"] = "COUNTER",
							["PrtsAfter"] = 1,
							["Name"] = "combat_toggle",
						}, -- [7]
						{
							["Type"] = "COUNTER",
							["Name"] = "combat_toggle",
							["PrtsBefore"] = 1,
							["AndOr"] = "OR",
							["PrtsAfter"] = 4,
							["Level"] = 1,
						}, -- [8]
						["n"] = 8,
					},
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Thickness"] = 3,
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [1]
								{
									["Type"] = "Animations",
									["Image"] = "28059",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["OnConditionConditions"] = {
										{
											["Type"] = "HAPPINESS",
											["BitFlags"] = 4,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["Type"] = "Animations",
									["Image"] = "28084",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["OnConditionConditions"] = {
										{
											["Type"] = "HAPPINESS",
											["BitFlags"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [3]
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["Image"] = "28084",
									["OnConditionConditions"] = {
										{
											["Type"] = "HAPPINESS",
											["BitFlags"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Alpha"] = 1,
									["Event"] = "WCSP",
								}, -- [4]
								{
									["Type"] = "Animations",
									["Image"] = "23214",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["OnConditionConditions"] = {
										{
											["Type"] = "HAPPINESS",
											["BitFlags"] = 2,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [5]
								["n"] = 5,
							},
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
							["CustomTex"] = "NONE",
						}, -- [1]
					},
					["Point"] = {
						["y"] = -30,
						["relativeTo"] = "TMW:group:1To6q47skjGf",
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
					},
				}, -- [15]
				{
					["View"] = "bar",
					["Columns"] = 1,
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 336.525421142578,
							["Icon"] = false,
						},
					},
					["Scale"] = 0.25,
					["GUID"] = "TMW:group:1ToXtohxkhmd",
					["Icons"] = {
						{
							["BackdropColor"] = "00333333",
							["Type"] = "conditionicon",
							["TimerBar_MiddleColor"] = "00ffff00",
							["ConditionDur"] = 5,
							["BackdropColor_Enable"] = true,
							["TimerBar_CompleteColor"] = "0000ff00",
							["TimerBar_EnableColors"] = true,
							["SettingsPerView"] = {
								["bar"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"Happiness has [\"DECREASED!\":Red]", -- [1]
										"Happiness has [\"DECREASED!\":Red]", -- [2]
									},
								},
							},
							["OnlyIfCounting"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["Event"] = "OnHide",
									["Animation"] = "ICONFADE",
								}, -- [1]
								["n"] = 1,
							},
							["TimerBar_StartColor"] = "00ff0000",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "HAPPINESS",
									["BitFlags"] = 3,
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1ToXXbNIIbiY",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["ConditionDur"] = 5,
							["ConditionDurEnabled"] = true,
							["OnlyIfCounting"] = true,
						}, -- [2]
					},
					["Point"] = {
						["y"] = -17.114990234375,
						["x"] = 1089.48962402344,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
				}, -- [16]
				{
					["View"] = "bar",
					["Scale"] = 1.25617873668671,
					["Columns"] = 1,
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 292.663726806641,
							["Icon"] = false,
						},
					},
					["Locked"] = true,
					["GUID"] = "TMW:group:1ToXu0LcLIOZ",
					["Icons"] = {
						{
							["BackdropColor"] = "00333333",
							["Type"] = "meta",
							["BackdropColor_Enable"] = true,
							["Icons"] = {
								"TMW:icon:1ToXXbNIIbiY", -- [1]
							},
							["Enabled"] = true,
						}, -- [1]
					},
					["Point"] = {
						["y"] = -165,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
				}, -- [17]
				{
					["GUID"] = "TMW:group:1ToaOwcAiwGJ",
					["Columns"] = 1,
					["Scale"] = 1.97506868839264,
					["Locked"] = true,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Thickness"] = 3,
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
									["AnimColor"] = "ff000000",
									["OnConditionConditions"] = {
										{
											["Name"] = "border_toggle",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [1]
								{
									["Type"] = "Animations",
									["Image"] = "28059",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["OnConditionConditions"] = {
										{
											["Type"] = "HAPPINESS",
											["BitFlags"] = 4,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [2]
								{
									["Type"] = "Animations",
									["Image"] = "28084",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["OnConditionConditions"] = {
										{
											["Type"] = "HAPPINESS",
											["BitFlags"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [3]
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["Image"] = "28084",
									["OnConditionConditions"] = {
										{
											["Type"] = "HAPPINESS",
											["BitFlags"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["Alpha"] = 1,
									["Event"] = "WCSP",
								}, -- [4]
								{
									["Type"] = "Animations",
									["Image"] = "23214",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Alpha"] = 1,
									["OnConditionConditions"] = {
										{
											["Type"] = "HAPPINESS",
											["BitFlags"] = 2,
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Fade"] = false,
								}, -- [5]
								["n"] = 5,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["AndOr"] = "OR",
									["Name"] = "pet",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "COMBAT",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "NONE",
						}, -- [1]
					},
					["Point"] = {
						["y"] = 114.372060823582,
					},
				}, -- [18]
				{
					["GUID"] = "TMW:group:1ToaQe8RWB82",
					["Columns"] = 1,
					["Scale"] = 0.710862457752228,
					["Locked"] = true,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"  [HappyText] ", -- [1]
										"[HappyText] ", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["AndOr"] = "OR",
									["Name"] = "pet",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "COMBAT",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "NONE",
						}, -- [1]
					},
					["Point"] = {
						["y"] = -9.74870521118185e-05,
						["relativeTo"] = "TMW:group:1ToaOwcAiwGJ",
						["point"] = "TOP",
						["relativePoint"] = "BOTTOM",
						["x"] = 2.33982563919343,
					},
				}, -- [19]
			},
			["NumGroups"] = 19,
		},
		["Hunter"] = {
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Scale"] = 1.0008,
					["Rows"] = 3,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Serpent Sting",
							["Conditions"] = {
								{
									["Type"] = "MANA_ABS",
									["Level"] = 300,
									["Operator"] = ">",
								}, -- [1]
								{
									["Operator"] = "<=",
									["Level"] = 35,
									["Type"] = "LIBRANGECHECK",
									["Unit"] = "target",
								}, -- [2]
								{
									["Unit"] = "target",
									["Level"] = 5,
									["Type"] = "LIBRANGECHECK",
									["Operator"] = ">=",
								}, -- [3]
								{
									["Level"] = 1,
									["Type"] = "CREATURETYPE",
									["Name"] = "Elemental; Undead",
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Serpent Sting",
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
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
							["Name"] = "Hunter's Mark",
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
							["ShowTimerText"] = true,
							["Unit"] = "target",
						}, -- [2]
						{
							["GUID"] = "TMW:icon:1V6lsULwY3_Y",
							["Type"] = "cooldown",
							["Name"] = "Arcane Shot",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Arcane Shot",
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
						}, -- [3]
						{
							["GUID"] = "TMW:icon:1V6noP8ARoel",
							["Type"] = "buff",
							["Name"] = "Aspect of the Hawk",
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Level"] = 70,
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
						}, -- [4]
						{
							["Enabled"] = true,
							["Type"] = "reactive",
							["Name"] = "Mongoose Bite",
							["Conditions"] = {
								{
									["Name"] = "Mongoose Bite",
									["Type"] = "SPELLCD",
								}, -- [1]
								{
									["Unit"] = "target",
									["Level"] = 5,
									["Type"] = "LIBRANGECHECK",
									["Operator"] = "<=",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1Y4IE=LQhFW4",
						}, -- [5]
						{
							["GUID"] = "TMW:icon:1YS2u64Alj4P",
							["Type"] = "cooldown",
							["Name"] = "Multi-Shot",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Multi-Shot",
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
						}, -- [6]
						{
							["GUID"] = "TMW:icon:1YS2u64Csf0H",
							["Type"] = "cooldown",
							["Name"] = "Steady Shot",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Steady Shot",
									["Level"] = 1,
								}, -- [1]
								{
									["Operator"] = "~=",
									["Type"] = "BUFFDUR",
									["Name"] = "Serpent Sting",
									["Unit"] = "target",
								}, -- [2]
								["n"] = 2,
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
						}, -- [7]
						{
							["GUID"] = "TMW:icon:1YYUluwZXp0V",
							["Type"] = "reactive",
							["Name"] = "Kill Command",
							["Enabled"] = true,
							["RangeCheck"] = true,
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
						}, -- [8]
						{
							["GUID"] = "TMW:icon:1ZB8mNf2cjSi",
							["Type"] = "buff",
							["Name"] = "Aspect of the Viper",
							["Conditions"] = {
								{
									["Type"] = "MANA",
									["Level"] = 10,
									["Operator"] = "<=",
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
						}, -- [9]
						[20] = {
							["GUID"] = "TMW:icon:1VjwkIsn7fZp",
							["Type"] = "buff",
							["Name"] = "Frenzy Effect",
							["Enabled"] = true,
							["ShowTimerText"] = true,
							["CustomTex"] = "19615",
							["Unit"] = "pet",
						},
						[21] = {
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "EITHER",
							["Unit"] = "target",
							["Name"] = "Enraged",
							["ManaCheck"] = true,
							["RangeCheck"] = true,
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
						},
						[18] = {
							["ManaCheck"] = true,
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
									["Level"] = 70,
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
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1X=OmHlbqz67",
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
						[19] = {
							["Enabled"] = true,
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["Name"] = "Crystal Gaze",
							["BuffOrDebuff"] = "HARMFUL",
							["GUID"] = "TMW:icon:1VjwkIslWpyf",
							["CustomTex"] = "3635",
							["Unit"] = "pet",
						},
						[60] = {
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "22795",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 55,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1ZB9QFehlUaz",
						},
						[59] = {
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
						},
					},
					["Name"] = "SPELLS",
					["Locked"] = true,
					["Alpha"] = 0,
					["Point"] = {
						["y"] = -4.996173281900221,
						["x"] = -0.0002605930177353105,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["OnlyInCombat"] = true,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["OnlyInCombat"] = true,
					["Name"] = "OTHER",
					["Point"] = {
						["y"] = -20,
						["x"] = -230,
					},
					["Scale"] = 1.5,
					["Columns"] = 1,
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
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TeVDtajUwqa",
					["Name"] = "ROTATION CENTER",
					["Point"] = {
						["y"] = -100,
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
								"TMW:icon:1ZB9QFehlUaz", -- [1]
								"TMW:icon:1ZB9QFefrfi_", -- [2]
								"TMW:icon:1V6noP8ARoel", -- [3]
								"TMW:icon:1ZB8mNf2cjSi", -- [4]
								"TMW:icon:1X=OmHlbqz67", -- [5]
								"TMW:icon:1TeVAjjXQ0WB", -- [6]
								"TMW:icon:1YYUluwZXp0V", -- [7]
								"TMW:icon:1V6lsULwY3_Y", -- [8]
								"TMW:icon:1YS2u64Alj4P", -- [9]
								"TMW:icon:1YS2u64Csf0H", -- [10]
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
									["Type"] = "CURRENTSPELL",
									["Name"] = "Volley",
									["Level"] = 1,
								}, -- [5]
								{
									["Name"] = "Feign Death",
									["Type"] = "BUFFDUR",
								}, -- [6]
								["n"] = 6,
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
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1X=OmHlbqz67", -- [1]
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
							["Icons"] = {
								"TMW:icon:1ZB9QFehlUaz", -- [1]
								"TMW:icon:1ZB9QFefrfi_", -- [2]
								"TMW:icon:1V6noP8ARoel", -- [3]
								"TMW:icon:1ZB8mNf2cjSi", -- [4]
								"TMW:icon:1X=OmHlbqz67", -- [5]
								"TMW:icon:1TeVAjjXQ0WB", -- [6]
								"TMW:icon:1YYUluwZXp0V", -- [7]
								"TMW:icon:1V6lsULwY3_Y", -- [8]
								"TMW:icon:1YS2u64Alj4P", -- [9]
								"TMW:icon:1YS2u64Csf0H", -- [10]
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
									["Type"] = "CURRENTSPELL",
									["Name"] = "Volley",
									["Level"] = 1,
								}, -- [5]
								{
									["Name"] = "Feign Death",
									["Type"] = "BUFFDUR",
								}, -- [6]
								["n"] = 6,
							},
						}, -- [1]
					},
					["OnlyInCombat"] = true,
				}, -- [4]
			},
			["Locked"] = true,
			["Version"] = 92500,
			["NumGroups"] = 4,
			["TextureName"] = "Glamour2",
		},
		["Warrior"] = {
			["Version"] = 92500,
			["Locked"] = true,
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
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend",
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
							["ManaCheck"] = true,
							["Type"] = "reactive",
							["Name"] = "Heroic Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["PrtsBefore"] = 1,
									["Level"] = 20,
									["Operator"] = ">=",
									["Unit"] = "target",
								}, -- [1]
								{
									["Name"] = "Defensive Stance",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Type"] = "STANCE",
								}, -- [2]
								{
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend",
									["Type"] = "LUA",
								}, -- [3]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Heroic Strike",
									["Level"] = 1,
								}, -- [4]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 40,
									["Operator"] = ">=",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1TQv_Lti1RyX",
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Demoralizing Shout",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1TWZdpV26rm5",
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
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [4]
								{
									["PrtsBefore"] = 1,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Demoralizing Shout",
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Demoralizing Shout",
									["Unit"] = "target",
									["Level"] = 5,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
								}, -- [6]
								{
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\"..i, 3) and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 0 then\n    return true\nelse\n    return false\nend",
									["Type"] = "LUA",
								}, -- [7]
								{
									["Name"] = "Sweeping Strikes",
									["Type"] = "BUFFDUR",
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
						}, -- [5]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["RangeCheck"] = true,
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
							["Conditions"] = {
								{
									["Type"] = "DEBUFFSTACKS",
									["Name"] = "Sunder Armor",
									["PrtsBefore"] = 2,
									["Level"] = 3,
									["Operator"] = "<",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sunder Armor",
									["Operator"] = "<=",
									["AndOr"] = "OR",
									["Level"] = 6,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [2]
								{
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend",
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
									["Operator"] = "<",
									["AndOr"] = "OR",
									["Level"] = 3,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sunder Armor",
									["PrtsBefore"] = 1,
									["Level"] = 6,
									["Operator"] = "<=",
									["Unit"] = "target",
								}, -- [7]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend",
								}, -- [8]
								["n"] = 8,
							},
							["HideIfNoUnits"] = true,
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
							["GUID"] = "TMW:icon:1TZvNvflXM0_",
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
							["ManaCheck"] = true,
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
							["GUID"] = "TMW:icon:1Xrn34GriOqy",
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
							["ManaCheck"] = true,
							["Type"] = "reactive",
							["Name"] = "Cleave",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["PrtsBefore"] = 1,
									["Level"] = 20,
									["Operator"] = ">=",
									["Unit"] = "target",
								}, -- [1]
								{
									["Name"] = "Defensive Stance",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Type"] = "STANCE",
								}, -- [2]
								{
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return true\nelse\n    return false\nend",
									["Type"] = "LUA",
								}, -- [3]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Cleave",
									["Level"] = 1,
								}, -- [4]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 40,
									["Operator"] = ">=",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1Y2=7t59vfSn",
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
							["GUID"] = "TMW:icon:1Xwc=6KNp27d",
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
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">",
								}, -- [2]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [3]
								{
									["PrtsBefore"] = 1,
									["Type"] = "LUA",
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return true\nelse\n    return false\nend",
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
							["ManaCheck"] = true,
							["Type"] = "reactive",
							["Name"] = "Heroic Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 2,
									["Type"] = "SPELLCD",
									["Name"] = "Whirlwind",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["PrtsAfter"] = 1,
									["Name"] = "Berserker Stance",
								}, -- [2]
								{
									["Type"] = "STANCE",
									["Name"] = "Berserker Stance; Battle Stance",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["AndOr"] = "OR",
								}, -- [3]
								{
									["PrtsBefore"] = 1,
									["Type"] = "SPELLCD",
									["Name"] = "Mortal Strike",
									["Operator"] = "~=",
								}, -- [4]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Bloodthirst",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [5]
								{
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend",
									["Type"] = "LUA",
								}, -- [6]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Heroic Strike",
									["Level"] = 1,
								}, -- [7]
								["n"] = 7,
							},
							["GUID"] = "TMW:icon:1XwhZnw4w0Sf",
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
						}, -- [12]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mortal Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Operator"] = ">",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
									["AndOr"] = "OR",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1XzwOSGxkHLD",
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
						}, -- [14]
						{
							["GUID"] = "TMW:icon:1Y2=7t6wEuO2",
							["Type"] = "reactive",
							["RangeCheck"] = true,
							["Name"] = "Cleave",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 2,
									["Type"] = "SPELLCD",
									["Name"] = "Whirlwind",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["PrtsAfter"] = 1,
									["Name"] = "Berserker Stance",
								}, -- [2]
								{
									["Type"] = "STANCE",
									["Name"] = "Berserker Stance",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Level"] = 1,
								}, -- [3]
								{
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return true\nelse\n    return false\nend",
									["Type"] = "LUA",
								}, -- [4]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Cleave",
									["Level"] = 1,
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
						}, -- [15]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Bloodthirst",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
									["AndOr"] = "OR",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1YEqZQbYmmFD",
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
						}, -- [16]
						{
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
						}, -- [17]
						{
							["GUID"] = "TMW:icon:1YO55KEUKaW4",
							["Type"] = "cooldown",
							["Name"] = "Sweeping Strikes",
							["Conditions"] = {
								{
									["Name"] = "Battle Stance; Berserker Stance",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return true\nelse\n    return false\nend",
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
						}, -- [18]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Thunder Clap",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1YWHZ7T27TKe",
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
									["Type"] = "DEBUFFDUR",
									["Name"] = "Thunder Clap",
									["Operator"] = "<=",
									["Level"] = 5,
									["AndOr"] = "OR",
									["Unit"] = "target",
								}, -- [3]
								{
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\"..i, 3) and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return true\nelse\n    return false\nend",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Type"] = "LUA",
								}, -- [4]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
								}, -- [6]
								{
									["Unit"] = "target",
									["Level"] = 1,
									["Type"] = "REACT",
									["Operator"] = "<=",
								}, -- [7]
								{
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\"..i, 3) and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 0 then\n    return true\nelse\n    return false\nend",
									["Type"] = "LUA",
								}, -- [8]
								{
									["Name"] = "Sweeping Strikes",
									["Type"] = "BUFFDUR",
								}, -- [9]
								["n"] = 9,
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
						}, -- [19]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Name"] = "Hamstring",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1TWYMfcUzmi6",
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
						}, -- [20]
						{
							["ManaCheck"] = true,
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
							["GUID"] = "TMW:icon:1Z55tRw3mJGc",
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
						}, -- [21]
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
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [22]
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
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [23]
						{
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
						}, -- [24]
						{
							["ManaCheck"] = true,
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
							["GUID"] = "TMW:icon:1Z7AzkxDmWSh",
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
						}, -- [25]
						{
							["ManaCheck"] = true,
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
							["GUID"] = "TMW:icon:1Z679nrqAgG4",
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
						}, -- [26]
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
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [27]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Commanding Shout",
							["Enabled"] = true,
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
						}, -- [28]
						{
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
						}, -- [29]
						{
							["ManaCheck"] = true,
							["Type"] = "reactive",
							["Name"] = "Heroic Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Glyph of Revenge",
									["Operator"] = "~=",
								}, -- [1]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Heroic Strike",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Cleave",
									["Level"] = 1,
								}, -- [3]
								{
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend",
									["Type"] = "LUA",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1Z8WLq4YSMiX",
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
						}, -- [30]
						{
							["GUID"] = "TMW:icon:1Z9CIRRFbqSA",
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
						}, -- [31]
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
							["Name"] = "Enrage",
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
							["Name"] = "Sweeping Strikes",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1TZve345g=GK",
								},
							},
							["ShowTimerText"] = true,
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
						nil, -- [13]
						nil, -- [14]
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838",
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
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Heroic Strike",
							["Conditions"] = {
								{
									["Name"] = "Heroic Strike",
									["Type"] = "CURRENTSPELL",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1Z8mFMG3Bv8u",
						}, -- [16]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Cleave",
							["Conditions"] = {
								{
									["Name"] = "Cleave",
									["Type"] = "CURRENTSPELL",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1Z8mFMG5TSmy",
						}, -- [17]
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
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "Major Healing Potion",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 15,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "ALIVE",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1X=ERE5kaXRD",
							["OnlyInBags"] = true,
						}, -- [19]
						{
							["GUID"] = "TMW:icon:1VagxKm_xQWz",
							["Type"] = "buff",
							["CBarOffs"] = 2,
							["ShowTimerText"] = true,
							["Name"] = "Renew",
							["ShowCBar"] = true,
							["Enabled"] = true,
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
								"TMW:icon:1Z7R_6NwuWuK", -- [1]
								"TMW:icon:1YXBo4F3g7mS", -- [2]
								"TMW:icon:1X=ERE5kaXRD", -- [3]
								"TMW:icon:1TWYSTcSCl0z", -- [4]
								"TMW:icon:1TZvNvgAkfmq", -- [5]
								"TMW:icon:1Xx3hMFQR0cV", -- [6]
								"TMW:icon:1Z8mFMG3Bv8u", -- [7]
								"TMW:icon:1Z8mFMG5TSmy", -- [8]
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
								"TMW:icon:1TZvNvflXM0_", -- [1]
								"TMW:icon:1X=ERE5iZ8VU", -- [2]
								"TMW:icon:1Z9jhZwz5hvH", -- [3]
								"TMW:icon:1Z7R_6NwuWuK", -- [4]
								"TMW:icon:1Z55tRw68qC=", -- [5]
								"TMW:icon:1Z7PEaKwPKnX", -- [6]
								"TMW:icon:1TWYMfcUzmi6", -- [7]
								"TMW:icon:1Z9CIRRFbqSA", -- [8]
								"TMW:icon:1YP2Xjgjriiu", -- [9]
								"TMW:icon:1YO55KEUKaW4", -- [10]
								"TMW:icon:1Z8WLq4YSMiX", -- [11]
								"TMW:icon:1TWZdpV26rm5", -- [12]
								"TMW:icon:1TQv_Ltf40Wl", -- [13]
								"TMW:icon:1Z7PEaK_TNq3", -- [14]
								"TMW:icon:1TQv_Lti1RyX", -- [15]
								"TMW:icon:1Y2=7t59vfSn", -- [16]
								"TMW:icon:1Xrn34GriOqy", -- [17]
								"TMW:icon:1YWHZ7T27TKe", -- [18]
								"TMW:icon:1Z55tRwA_pKn", -- [19]
								"TMW:icon:1TYYu4EDbfSz", -- [20]
								"TMW:icon:1TU=hLnlwyeY", -- [21]
								"TMW:icon:1TQv_LtTwAae", -- [22]
								"TMW:icon:1YEqZQbYmmFD", -- [23]
								"TMW:icon:1XzwOSGxkHLD", -- [24]
								"TMW:icon:1Xwc=6KNp27d", -- [25]
								"TMW:icon:1XwhZnw4w0Sf", -- [26]
								"TMW:icon:1Y2=7t6wEuO2", -- [27]
								"TMW:icon:1Z55tRw3mJGc", -- [28]
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
							["DurationMinEnabled"] = true,
							["DurationMin"] = 15,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
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
								"TMW:icon:1TZvNvflXM0_", -- [1]
								"TMW:icon:1X=ERE5iZ8VU", -- [2]
								"TMW:icon:1Z9jhZwz5hvH", -- [3]
								"TMW:icon:1Z7R_6NwuWuK", -- [4]
								"TMW:icon:1Z55tRw68qC=", -- [5]
								"TMW:icon:1Z7PEaKwPKnX", -- [6]
								"TMW:icon:1TWYMfcUzmi6", -- [7]
								"TMW:icon:1Z9CIRRFbqSA", -- [8]
								"TMW:icon:1YP2Xjgjriiu", -- [9]
								"TMW:icon:1YO55KEUKaW4", -- [10]
								"TMW:icon:1Z8WLq4YSMiX", -- [11]
								"TMW:icon:1TWZdpV26rm5", -- [12]
								"TMW:icon:1TQv_Ltf40Wl", -- [13]
								"TMW:icon:1Z7PEaK_TNq3", -- [14]
								"TMW:icon:1TQv_Lti1RyX", -- [15]
								"TMW:icon:1Y2=7t59vfSn", -- [16]
								"TMW:icon:1Xrn34GriOqy", -- [17]
								"TMW:icon:1YWHZ7T27TKe", -- [18]
								"TMW:icon:1Z55tRwA_pKn", -- [19]
								"TMW:icon:1TYYu4EDbfSz", -- [20]
								"TMW:icon:1TU=hLnlwyeY", -- [21]
								"TMW:icon:1TQv_LtTwAae", -- [22]
								"TMW:icon:1YEqZQbYmmFD", -- [23]
								"TMW:icon:1XzwOSGxkHLD", -- [24]
								"TMW:icon:1Xwc=6KNp27d", -- [25]
								"TMW:icon:1XwhZnw4w0Sf", -- [26]
								"TMW:icon:1Y2=7t6wEuO2", -- [27]
								"TMW:icon:1Z55tRw3mJGc", -- [28]
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
							["DurationMinEnabled"] = true,
							["DurationMin"] = 15,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
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
					["Name"] = "ROTATION TOPLEFT",
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
				}, -- [5]
			},
			["NumGroups"] = 5,
			["TextureName"] = "Glamour2",
		},
		["Paladin"] = {
			["Locked"] = true,
			["NumGroups"] = 4,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Scale"] = 1,
					["Rows"] = 3,
					["Alpha"] = 0,
					["Name"] = "Paladin Spells",
					["Locked"] = true,
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["Type"] = "cooldown",
							["Name"] = "Maul",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "STANCE",
									["Name"] = "Bear Form; Dire Bear Form",
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
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Maul\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend",
								}, -- [5]
								{
									["Level"] = 30,
									["Type"] = "RAGE_ABS",
									["AndOr"] = "OR",
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
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["OnlyMine"] = true,
							["Name"] = "Demoralizing Roar",
							["Type"] = "cooldown",
							["RangeCheck"] = true,
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
						{
							["GUID"] = "TMW:icon:1V6lsULwY3_Y",
							["Type"] = "cooldown",
							["Name"] = "Swipe (Bear)",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "STANCE",
									["Name"] = "Bear Form; Dire Bear Form",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Name"] = "Swipe",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Maul\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return true\nelse\n    return false\nend",
								}, -- [5]
								{
									["Type"] = "RAGE_ABS",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 40,
									["Operator"] = ">=",
								}, -- [6]
								{
									["Type"] = "CURRENTSPELL",
									["PrtsAfter"] = 1,
									["Name"] = "Maul",
								}, -- [7]
								["n"] = 7,
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
							["GUID"] = "TMW:icon:1V6noP8ARoel",
							["Type"] = "cooldown",
							["Name"] = "Barkskin",
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
							["BuffOrDebuff"] = "HARMFUL",
							["Conditions"] = {
								{
									["Level"] = 60,
									["Type"] = "HEALTH",
									["Name"] = "Bear Form; Cat Form",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "COMBAT",
								}, -- [2]
								{
									["Level"] = 1,
									["Type"] = "MOUNTED",
								}, -- [3]
								["n"] = 3,
							},
							["ManaCheck"] = true,
							["Unit"] = "target",
						}, -- [4]
						{
							["GUID"] = "TMW:icon:1Z69muUIlNiY",
							["Type"] = "cooldown",
							["Name"] = "Mangle (Cat)",
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
									["Unit"] = "target",
									["Level"] = 10,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
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
						}, -- [5]
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Survival Instincts",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Name"] = "Mangle (Bear)",
									["AndOr"] = "OR",
									["Level"] = 40,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "COMBAT",
								}, -- [2]
								{
									["Level"] = 1,
									["Type"] = "MOUNTED",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1Z69muUKqqKC",
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
							["GUID"] = "TMW:icon:1Z6o5cxM6Qma",
							["Type"] = "cooldown",
							["Name"] = "Mangle (Bear)",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Bear Form; Dire Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["Level"] = 10,
									["AndOr"] = "OR",
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
									["Level"] = 10,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "<=",
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
						}, -- [7]
						[49] = {
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Consecration",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 2 then\n    return true\nelse\n    return false\nend",
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
							["ManaCheck"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Wisdom",
									["Level"] = 2,
									["Unit"] = "target",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Light",
									["Level"] = 2,
									["Unit"] = "target",
									["Operator"] = "<=",
								}, -- [2]
								["n"] = 2,
							},
							["Enabled"] = true,
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
							["GUID"] = "TMW:icon:1YYs1I2bCNGy",
							["Type"] = "cooldown",
							["Name"] = "Claw",
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
									["Type"] = "COMBO",
									["Level"] = 4,
									["Operator"] = "<",
								}, -- [4]
								{
									["Name"] = "local red, green, blue, alpha = RotationFrame4:GetBackdropColor()\n\nif ceil(red) == 1 and ceil(green) == 1 and ceil(blue) == 1 then\n    return true\nend",
									["Type"] = "LUA",
								}, -- [5]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["PrtsBefore"] = 1,
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [6]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [7]
								["n"] = 7,
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
							["Type"] = "cooldown",
							["Name"] = "Judgement of Wisdom",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Wisdom",
									["Unit"] = "target",
									["Level"] = 2,
									["AndOr"] = "OR",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Light",
									["Level"] = 2,
									["Unit"] = "target",
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
						},
						[22] = {
							["GUID"] = "TMW:icon:1YYs1I2c_Meo",
							["Type"] = "cooldown",
							["Name"] = "Claw",
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
									["Type"] = "COMBO",
								}, -- [4]
								{
									["Name"] = "local red, green, blue, alpha = RotationFrame4:GetBackdropColor()\n\nif ceil(red) == 1 and ceil(green) == 1 and ceil(blue) == 1 then\n    return true\nend",
									["Type"] = "LUA",
								}, -- [5]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["PrtsBefore"] = 1,
									["Unit"] = "target",
									["Name"] = "Mangle (Cat)",
									["Operator"] = "~=",
								}, -- [6]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [7]
								["n"] = 7,
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
									["Unit"] = "target",
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Wisdom",
									["Operator"] = "~=",
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
						[23] = {
							["GUID"] = "TMW:icon:1YYv3MYeNeSM",
							["Type"] = "cooldown",
							["Name"] = "Shred",
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
									["Name"] = "local red, green, blue, alpha = RotationFrame4:GetBackdropColor()\n\nif ceil(red) == 0 and ceil(green) == 0 and ceil(blue) == 1 then\n    return true\nend",
									["Type"] = "LUA",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["PrtsBefore"] = 1,
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [5]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
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
								["n"] = 1,
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
						[24] = {
							["GUID"] = "TMW:icon:1YZamy7DqjiW",
							["Type"] = "cooldown",
							["Name"] = "Rake",
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
									["Type"] = "COMBO",
									["Level"] = 4,
									["Operator"] = "<",
								}, -- [4]
								{
									["Name"] = "Rake",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["PrtsBefore"] = 1,
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [6]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [7]
								{
									["Unit"] = "target",
									["Level"] = 1000,
									["Type"] = "HEALTH_ABS",
									["Operator"] = ">=",
								}, -- [8]
								["n"] = 8,
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
								["n"] = 1,
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
						[25] = {
							["GUID"] = "TMW:icon:1YaXVCdLMBa8",
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
									["Level"] = 3000,
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
						[50] = {
							["GUID"] = "TMW:icon:1Z6uOhVXfBCq",
							["Type"] = "cooldown",
							["Name"] = "Seal of Command",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Level"] = 10,
									["Type"] = "BUFFDUR",
									["Name"] = "Seal of Command",
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
						[26] = {
							["GUID"] = "TMW:icon:1YbFYj2F1X0v",
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
									["Level"] = 3000,
									["Type"] = "HEALTH_ABS",
									["Operator"] = "<=",
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
								{
									["Type"] = "COMBO",
									["Level"] = 4,
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
						[27] = {
							["GUID"] = "TMW:icon:1YbGRIr4FVqp",
							["Type"] = "cooldown",
							["Name"] = "Ravage",
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
									["Type"] = "BUFFDUR",
									["Name"] = "Prowl",
									["Operator"] = "~=",
								}, -- [4]
								["n"] = 4,
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
						[28] = {
							["GUID"] = "TMW:icon:1Z3Dak8Afvm1",
							["Type"] = "cooldown",
							["Name"] = "Pounce",
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
									["Type"] = "BUFFDUR",
									["Name"] = "Prowl",
									["Operator"] = "~=",
								}, -- [4]
								["n"] = 4,
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
						[43] = {
							["GUID"] = "TMW:icon:1YatF3BT0RKW",
							["Type"] = "cooldown",
							["Name"] = "Divine Storm",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Type"] = "DEBUFFDUR",
									["Name"] = "Judgement of Wisdom",
									["Operator"] = "~=",
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
						[29] = {
							["GUID"] = "TMW:icon:1Z4qW_DgW_ek",
							["Type"] = "cooldown",
							["Name"] = "Tiger's Fury",
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
		["Battlearm - Hydraxian Waterlords"] = {
			["Locked"] = true,
			["Version"] = 87601,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1VflYar6WQqi",
				}, -- [1]
			},
		},
		["Deathknight"] = {
			["Locked"] = true,
			["Version"] = 92500,
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
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blood Tap",
							["Enabled"] = true,
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
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["OnlyMine"] = true,
							["Name"] = "Icebound Fortitude",
							["Enabled"] = true,
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
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Horn of Winter",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Horn of Winter",
									["Type"] = "BUFFDUR",
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Name"] = "Horn of Winter",
									["AndOr"] = "OR",
									["Level"] = 5,
									["Operator"] = "<=",
								}, -- [2]
								["n"] = 2,
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
							["ManaCheck"] = true,
							["Type"] = "reactive",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Rune Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
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
									["Level"] = 1,
									["Type"] = "REACT",
									["Name"] = "Bear Form; Cat Form",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Rune Strike",
									["Level"] = 1,
								}, -- [4]
								["n"] = 4,
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
						[24] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Death Coil",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEFAULT_ABS",
									["Level"] = 60,
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Blood Strike",
							["RangeCheck"] = true,
							["Enabled"] = true,
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
						[27] = {
							["GUID"] = "TMW:icon:1YbGRIr4FVqp",
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
							["Name"] = "Blood Boil",
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 2 then\n    return true\nelse\n    return false\nend",
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Pestilence",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "LUA",
									["Name"] = "IsShiftKeyDown();",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Frost Fever",
									["Operator"] = "~=",
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Blood Plague",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [3]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Name"] = "Blood Plague",
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "~=",
									["Name"] = "Frost Fever",
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<=",
									["PrtsBefore"] = 1,
									["Level"] = 4,
									["Name"] = "Blood Plague",
									["Unit"] = "target",
								}, -- [6]
								{
									["Operator"] = "<=",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "Frost Fever",
									["Level"] = 4,
									["AndOr"] = "OR",
									["PrtsAfter"] = 2,
									["Unit"] = "target",
								}, -- [7]
								{
									["Operator"] = ">=",
									["Level"] = 3000,
									["Type"] = "HEALTH_ABS",
									["Unit"] = "target",
								}, -- [8]
								["n"] = 8,
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
						[43] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Faerie Fire (Feral)",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Bear Form; Cat Form",
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
									["Type"] = "LIBRANGECHECK",
									["Level"] = 8,
									["Operator"] = "<=",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Faerie Fire (Feral)",
									["Unit"] = "target",
								}, -- [5]
								{
									["Name"] = "Prowl",
									["Type"] = "BUFFDUR",
								}, -- [6]
								["n"] = 6,
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
									["BitFlags"] = 1,
									["Type"] = "GROUP2",
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
						[21] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Plague Strike",
							["Enabled"] = true,
							["RangeCheck"] = true,
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
									["Name"] = "Blood Plague",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
								}, -- [4]
								["n"] = 4,
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
									["Name"] = "Frost Fever",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
								}, -- [4]
								["n"] = 4,
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
						}, -- [1]
					},
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
							["Icons"] = {
								"TMW:icon:1V6lsULwY3_Y", -- [1]
								"TMW:icon:1TeVAjjavXC6", -- [2]
								"TMW:icon:1TeVAjjXQ0WB", -- [3]
								"TMW:icon:1Z4FFfpv6jKF", -- [4]
								"TMW:icon:1YbGRIr4FVqp", -- [5]
								"TMW:icon:1YYs1I2c_Meo", -- [6]
								"TMW:icon:1YYs1I2bCNGy", -- [7]
								"TMW:icon:1V6noP8ARoel", -- [8]
								"TMW:icon:1YZamy7DqjiW", -- [9]
								"TMW:icon:1YaXVCdLMBa8", -- [10]
								"TMW:icon:1Z3Dak8Afvm1", -- [11]
								"TMW:icon:1YYv3MYeNeSM", -- [12]
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
								{
									["Name"] = "return not IsAltKeyDown()",
									["Type"] = "LUA",
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
							["Icons"] = {
								"TMW:icon:1V6lsULwY3_Y", -- [1]
								"TMW:icon:1TeVAjjavXC6", -- [2]
								"TMW:icon:1TeVAjjXQ0WB", -- [3]
								"TMW:icon:1Z4FFfpv6jKF", -- [4]
								"TMW:icon:1YbGRIr4FVqp", -- [5]
								"TMW:icon:1YYs1I2c_Meo", -- [6]
								"TMW:icon:1YYs1I2bCNGy", -- [7]
								"TMW:icon:1V6noP8ARoel", -- [8]
								"TMW:icon:1YZamy7DqjiW", -- [9]
								"TMW:icon:1YaXVCdLMBa8", -- [10]
								"TMW:icon:1Z3Dak8Afvm1", -- [11]
								"TMW:icon:1YYv3MYeNeSM", -- [12]
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
								{
									["Name"] = "return not IsAltKeyDown()",
									["Type"] = "LUA",
								}, -- [5]
								["n"] = 5,
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
			},
		},
		["Testxv - Golemagg"] = {
			["Locked"] = true,
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1VWiCxYSqwKw",
				}, -- [1]
			},
		},
		["Pitchwise - Dreadnaught"] = {
			["Version"] = 91200,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1Xm47LbdEYcq",
				}, -- [1]
			},
		},
		["Jaroslav - Golemagg"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1VAdQEMGnK_K",
				}, -- [1]
			},
		},
		["Druid"] = {
			["Locked"] = true,
			["NumGroups"] = 4,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Scale"] = 1,
					["Rows"] = 3,
					["Alpha"] = 0,
					["Name"] = "Druid Spells",
					["Locked"] = true,
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
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Maul\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend",
								}, -- [5]
								{
									["AndOr"] = "OR",
									["Type"] = "RAGE_ABS",
									["Level"] = 30,
									["Operator"] = ">=",
								}, -- [6]
								{
									["Name"] = "Berserk",
									["Type"] = "BUFFDUR",
								}, -- [7]
								["n"] = 7,
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
									["Type"] = "EXISTS",
									["Name"] = "Swipe",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "LUA",
									["PrtsAfter"] = 1,
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Maul\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return true\nelse\n    return false\nend",
								}, -- [5]
								{
									["Type"] = "RAGE_ABS",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 40,
									["Operator"] = ">=",
								}, -- [6]
								{
									["Type"] = "CURRENTSPELL",
									["PrtsAfter"] = 1,
									["Name"] = "Maul",
								}, -- [7]
								["n"] = 7,
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
									["Level"] = 60,
									["Type"] = "HEALTH",
									["Name"] = "Bear Form; Cat Form",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "COMBAT",
								}, -- [2]
								{
									["Level"] = 1,
									["Type"] = "MOUNTED",
								}, -- [3]
								["n"] = 3,
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
									["Level"] = 40,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "COMBAT",
								}, -- [2]
								{
									["Level"] = 1,
									["Type"] = "MOUNTED",
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
									["AndOr"] = "OR",
									["Type"] = "BUFFDUR",
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
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [2]
								{
									["Unit"] = "target",
									["Type"] = "ALIVE",
								}, -- [3]
								{
									["Type"] = "COMBO",
									["Level"] = 4,
									["Operator"] = "<",
								}, -- [4]
								{
									["Name"] = "Rake",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["PrtsBefore"] = 1,
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [6]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [7]
								{
									["Unit"] = "target",
									["Level"] = 1000,
									["Type"] = "HEALTH_ABS",
									["Operator"] = ">=",
								}, -- [8]
								["n"] = 8,
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
							["GUID"] = "TMW:icon:1YaXVCdLMBa8",
							["Type"] = "cooldown",
							["Name"] = "Rip",
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
									["Operator"] = ">=",
								}, -- [2]
								{
									["Unit"] = "target",
									["Level"] = 3000,
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Ferocious Bite",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Unit"] = "target",
									["Level"] = 3000,
									["Type"] = "HEALTH_ABS",
									["Operator"] = "<=",
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
								{
									["Type"] = "COMBO",
									["Level"] = 4,
									["Operator"] = ">=",
								}, -- [6]
								["n"] = 6,
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
						[27] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Ravage",
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
									["Type"] = "BUFFDUR",
									["Name"] = "Prowl",
									["Operator"] = "~=",
								}, -- [4]
								["n"] = 4,
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
							["Name"] = "Pounce",
							["Enabled"] = true,
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
									["Type"] = "BUFFDUR",
									["Name"] = "Prowl",
									["Operator"] = "~=",
								}, -- [4]
								["n"] = 4,
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
									["Type"] = "ENERGY_ABS",
									["Level"] = 30,
									["Operator"] = "<=",
								}, -- [3]
								{
									["Name"] = "Berserk",
									["Type"] = "BUFFDUR",
								}, -- [4]
								["n"] = 4,
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
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [2]
								{
									["Unit"] = "target",
									["Type"] = "ALIVE",
								}, -- [3]
								{
									["Type"] = "LIBRANGECHECK",
									["Level"] = 8,
									["Operator"] = "<=",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Faerie Fire (Feral)",
									["Unit"] = "target",
								}, -- [5]
								{
									["Name"] = "Prowl",
									["Type"] = "BUFFDUR",
								}, -- [6]
								["n"] = 6,
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
									["BitFlags"] = 1,
									["Type"] = "GROUP2",
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
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [2]
								{
									["Unit"] = "target",
									["Type"] = "ALIVE",
								}, -- [3]
								{
									["Type"] = "COMBO",
									["Level"] = 4,
									["Operator"] = "<",
								}, -- [4]
								{
									["Name"] = "local red, green, blue, alpha = RotationFrame4:GetBackdropColor()\n\nif ceil(red) == 1 and ceil(green) == 1 and ceil(blue) == 1 then\n    return true\nend",
									["Type"] = "LUA",
								}, -- [5]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["PrtsBefore"] = 1,
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [6]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [7]
								["n"] = 7,
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
						[22] = {
							["GUID"] = "TMW:icon:1YYs1I2c_Meo",
							["Type"] = "cooldown",
							["Name"] = "Claw",
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
									["Type"] = "COMBO",
								}, -- [4]
								{
									["Name"] = "local red, green, blue, alpha = RotationFrame4:GetBackdropColor()\n\nif ceil(red) == 1 and ceil(green) == 1 and ceil(blue) == 1 then\n    return true\nend",
									["Type"] = "LUA",
								}, -- [5]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["PrtsBefore"] = 1,
									["Unit"] = "target",
									["Name"] = "Mangle (Cat)",
									["Operator"] = "~=",
								}, -- [6]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [7]
								["n"] = 7,
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
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [2]
								{
									["Unit"] = "target",
									["Type"] = "ALIVE",
								}, -- [3]
								{
									["Name"] = "local red, green, blue, alpha = RotationFrame4:GetBackdropColor()\n\nif ceil(red) == 0 and ceil(green) == 0 and ceil(blue) == 1 then\n    return true\nend",
									["Type"] = "LUA",
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Cat)",
									["PrtsBefore"] = 1,
									["Unit"] = "target",
									["Operator"] = "~=",
								}, -- [5]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Mangle (Bear)",
									["Unit"] = "target",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [6]
								["n"] = 6,
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
								"TMW:icon:1V6noP8ARoel", -- [4]
								"TMW:icon:1Z69muUKqqKC", -- [5]
								"TMW:icon:1YatF3BT0RKW", -- [6]
								"TMW:icon:1TeVAjjavXC6", -- [7]
								"TMW:icon:1Z6o5cxM6Qma", -- [8]
								"TMW:icon:1Z69muUIlNiY", -- [9]
								"TMW:icon:1V6lsULwY3_Y", -- [10]
								"TMW:icon:1TeVAjjXQ0WB", -- [11]
								"TMW:icon:1Z4qW_DgW_ek", -- [12]
								"TMW:icon:1YZamy7DqjiW", -- [13]
								"TMW:icon:1YYs1I2bCNGy", -- [14]
								"TMW:icon:1YYv3MYeNeSM", -- [15]
								"TMW:icon:1YaXVCdLMBa8", -- [16]
								"TMW:icon:1YbFYj2F1X0v", -- [17]
							},
							["Conditions"] = {
								{
									["Name"] = "return not IsAltKeyDown();",
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
								"TMW:icon:1V6noP8ARoel", -- [4]
								"TMW:icon:1Z69muUKqqKC", -- [5]
								"TMW:icon:1YatF3BT0RKW", -- [6]
								"TMW:icon:1TeVAjjavXC6", -- [7]
								"TMW:icon:1Z6o5cxM6Qma", -- [8]
								"TMW:icon:1Z69muUIlNiY", -- [9]
								"TMW:icon:1V6lsULwY3_Y", -- [10]
								"TMW:icon:1TeVAjjXQ0WB", -- [11]
								"TMW:icon:1Z4qW_DgW_ek", -- [12]
								"TMW:icon:1YZamy7DqjiW", -- [13]
								"TMW:icon:1YYs1I2bCNGy", -- [14]
								"TMW:icon:1YYv3MYeNeSM", -- [15]
								"TMW:icon:1YaXVCdLMBa8", -- [16]
								"TMW:icon:1YbFYj2F1X0v", -- [17]
							},
							["Conditions"] = {
								{
									["Name"] = "return not IsAltKeyDown();",
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
		["Moolatz - Golemagg"] = {
			["Version"] = 91200,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1XwcshcBUCEg",
				}, -- [1]
			},
		},
		["Augustin - Golemagg"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1VAdMpuRA5RP",
				}, -- [1]
			},
		},
		["Priest"] = {
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Scale"] = 1.5,
					["TextureName"] = "Details Flat",
					["Columns"] = 1,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1VjwkIsn7fZp", -- [1]
							},
							["Enabled"] = true,
						}, -- [1]
					},
					["Name"] = "Other",
					["Point"] = {
						["y"] = -20,
						["x"] = -230,
					},
				}, -- [1]
				{
					["Scale"] = 1,
					["Locked"] = true,
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Icons"] = {
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Type"] = "buff",
							["Name"] = "Serpent Sting",
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Conditions"] = {
								{
									["Type"] = "MANA_ABS",
									["Operator"] = ">",
									["Level"] = 100,
								}, -- [1]
								{
									["Type"] = "LIBRANGECHECK",
									["Unit"] = "target",
									["Operator"] = "<=",
									["Level"] = 35,
								}, -- [2]
								["n"] = 2,
							},
							["Enabled"] = true,
						}, -- [1]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["Name"] = "Hunter's Mark",
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 0.15,
								}, -- [2]
							},
							["Enabled"] = true,
						}, -- [2]
						{
							["Type"] = "cooldown",
							["Name"] = "Arcane Shot",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1V6lsULwY3_Y",
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "MANA_ABS",
									["Operator"] = ">",
									["Level"] = 100,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [3]
						{
							["Type"] = "buff",
							["Name"] = "Aspect of the Hawk",
							["GUID"] = "TMW:icon:1V6noP8ARoel",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Enabled"] = true,
						}, -- [4]
						[19] = {
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "pet",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["Name"] = "Crystal Gaze",
							["GUID"] = "TMW:icon:1VjwkIslWpyf",
							["Enabled"] = true,
						},
						[20] = {
							["BuffOrDebuff"] = "HARMFUL",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["Name"] = "Weakened Soul",
							["GUID"] = "TMW:icon:1VjwkIsn7fZp",
							["Enabled"] = true,
						},
					},
					["Name"] = "Hunter Spells",
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Alpha"] = 0,
				}, -- [2]
				{
					["Point"] = {
						["y"] = -88,
						["x"] = 4.06901041666667e-05,
					},
					["Scale"] = 1.5,
					["Locked"] = true,
					["OnlyInCombat"] = true,
					["Columns"] = 3,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1V6noP8ARoel", -- [1]
							},
						}, -- [1]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1V6lsULwY3_Y", -- [1]
							},
						}, -- [2]
					},
					["Name"] = "Hunter Rotation",
					["GUID"] = "TMW:group:1TeVDtajUwqa",
				}, -- [3]
			},
			["NumGroups"] = 3,
			["Version"] = 92500,
			["Locked"] = true,
		},
		["Klhjakhsgdjh - Golemagg"] = {
			["Locked"] = true,
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1V9nWrIIEiys",
				}, -- [1]
			},
		},
		["Mxym - Golemagg"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1V9lxa5qigKR",
				}, -- [1]
			},
		},
		["Battlearm - Golemagg"] = {
			["Version"] = 92400,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1Vbhru5eED7w",
				}, -- [1]
			},
		},
	},
}
