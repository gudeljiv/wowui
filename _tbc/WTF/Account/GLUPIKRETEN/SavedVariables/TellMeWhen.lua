
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
		["Moolatz - Golemagg"] = "Druid",
		["Testxv - Golemagg"] = "Testxv - Golemagg",
		["Dotwise - Golemagg"] = "Warrior",
		["Battlearm - Golemagg"] = "Battlearm - Golemagg",
		["Greenwise - Golemagg"] = "Warrior",
		["Jaroslav - Golemagg"] = "Druid",
		["Klhjakhsgdjh - Golemagg"] = "Klhjakhsgdjh - Golemagg",
		["Dmitar - Golemagg"] = "Dmitar - Golemagg",
		["Judawise - Golemagg"] = "Warrior",
		["Pitchwise - Dreadnaught"] = "Warrior",
		["Konac - Dreadnaught"] = "Priest",
		["Mxyzptlk - Golemagg"] = "Warlock",
		["Battlearm - Hydraxian Waterlords"] = "Battlearm - Hydraxian Waterlords",
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
	["Version"] = 91200,
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
			["Version"] = 91200,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1Vb7b4GP7kSB",
				}, -- [1]
			},
		},
		["Dmitar - Golemagg"] = {
			["Locked"] = true,
			["Version"] = 86907,
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
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TQvxnAfbGyU",
					["Scale"] = 1,
					["Name"] = "Warrior Spells",
					["Alpha"] = 0,
					["Locked"] = true,
					["Columns"] = 20,
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
									["Type"] = "BUFFDUR",
									["Level"] = 15,
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
							["GUID"] = "TMW:icon:1TU=hLnlwyeY",
							["Name"] = "Overpower",
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
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
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
							["ShowTimerText"] = true,
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
							["GUID"] = "TMW:icon:1TZvNvgAkfmq",
							["ShowTimerText"] = true,
						}, -- [2]
					},
					["TextureName"] = "Details Flat",
					["Name"] = "General Buffs/Debbufs",
					["Locked"] = true,
					["Columns"] = 20,
					["Alpha"] = 0,
				}, -- [4]
				{
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Scale"] = 1,
					["Name"] = "Hunter Spells",
					["Alpha"] = 0,
					["Locked"] = true,
					["Columns"] = 20,
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
							["OnlyMine"] = true,
							["Name"] = "Serpent Sting",
							["Enabled"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Type"] = "buff",
							["ShowTimerText"] = true,
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
					["Point"] = {
						["y"] = -75,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
				}, -- [5]
				{
					["GUID"] = "TMW:group:1TeVDtajUwqa",
					["Columns"] = 3,
					["Scale"] = 1.5,
					["Name"] = "Hunter Rotation",
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
					["Point"] = {
						["y"] = -88,
						["x"] = 4.06901041666667e-05,
					},
				}, -- [6]
				{
					["GUID"] = "TMW:group:1V6krZ0tqss=",
					["Columns"] = 1,
					["Scale"] = 1.5,
					["Name"] = "Warlock Rotation",
					["Point"] = {
						["y"] = -88,
					},
				}, -- [7]
			},
			["Version"] = 91200,
			["NumGroups"] = 7,
		},
		["Arms"] = {
			["Version"] = 91200,
			["TextureName"] = "Blizzard Raid Bar",
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
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "208086",
									["Unit"] = "target",
								}, -- [2]
								{
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">",
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
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
							["GUID"] = "TMW:icon:1RZ8uyGIHkyU",
							["FakeHidden"] = true,
						}, -- [2]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "227847",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "208086",
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
									["PrtsAfter"] = 1,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22391",
									["Level"] = 1,
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
									["PrtsAfter"] = 2,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22391",
									["Level"] = 1,
								}, -- [13]
								{
									["PrtsBefore"] = 1,
									["Type"] = "LASTCAST",
									["Name"] = "262161",
									["Level"] = 1,
								}, -- [14]
								{
									["PrtsAfter"] = 1,
									["Type"] = "LASTCAST",
									["Name"] = "167105",
									["Level"] = 1,
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
							["GUID"] = "TMW:icon:1Rg1PA0lcPyA",
							["FakeHidden"] = true,
						}, -- [3]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "167105",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
									["Type"] = "RAGE_ABS",
									["Level"] = 55,
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
							["GUID"] = "TMW:icon:1RGdpp2C6tbD",
							["FakeHidden"] = true,
						}, -- [4]
						{
							["GUID"] = "TMW:icon:1RTBzFiJhwQj",
							["ShowTimer"] = true,
							["ClockGCD"] = true,
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
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
									["Type"] = "SPELLCD",
									["Level"] = 1,
									["Name"] = "12294",
									["Operator"] = "<",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 30,
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
									["AndOr"] = "OR",
									["PrtsBefore"] = 1,
									["Level"] = 2,
									["Name"] = "272866",
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["AndOr"] = "OR",
									["Level"] = 2,
									["Name"] = "272867",
									["Unit"] = "target",
								}, -- [7]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Name"] = "272870",
									["AndOr"] = "OR",
									["Level"] = 2,
									["PrtsAfter"] = 3,
									["Unit"] = "target",
								}, -- [8]
								{
									["Icon"] = "TMW:icon:1RTD2ohayX3V",
									["Type"] = "ICON",
								}, -- [9]
								["n"] = 9,
							},
							["DurationMax"] = 2,
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
							["ClockGCD"] = true,
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
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
									["PrtsAfter"] = 1,
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["Unit"] = "target",
								}, -- [4]
								{
									["Icon"] = "TMW:icon:1RTD2m1wLgWu",
									["Type"] = "ICON",
								}, -- [5]
								["n"] = 5,
							},
							["DurationMax"] = 2,
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
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
							["GUID"] = "TMW:icon:1RGe00HwCayk",
							["FakeHidden"] = true,
						}, -- [7]
						{
							["GUID"] = "TMW:icon:1RGeD0uAObsB",
							["ShowTimer"] = true,
							["ClockGCD"] = true,
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]",
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Checked"] = true,
									["Type"] = "BUFFSTACKS",
									["Name"] = "7384",
									["Level"] = 2,
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
							["DurationMax"] = 2,
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
							["Type"] = "cooldown",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 2,
									["Name"] = "208086",
									["Operator"] = ">",
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
									["PrtsAfter"] = 2,
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["Level"] = 1,
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
							["GUID"] = "TMW:icon:1RTBzNx11CSK",
							["FakeHidden"] = true,
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
							["Type"] = "cooldown",
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
							["FakeHidden"] = true,
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
							["Type"] = "cooldown",
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
									["Unit"] = "target",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
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
							["FakeHidden"] = true,
						}, -- [11]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "163201",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
									["Unit"] = "target",
									["Level"] = 20,
									["PrtsAfter"] = 1,
									["Operator"] = "<",
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
									["Unit"] = "target",
									["Level"] = 35,
									["PrtsAfter"] = 3,
									["Operator"] = "<",
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
							["GUID"] = "TMW:icon:1RGdpp2IFjGf",
							["FakeHidden"] = true,
						}, -- [12]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "1680",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">",
								}, -- [4]
								{
									["Type"] = "SPELLCD",
									["Level"] = 1,
									["Name"] = "12294",
									["Operator"] = ">",
								}, -- [5]
								{
									["PrtsAfter"] = 1,
									["Type"] = "COUNTER",
									["Name"] = "testofmight",
									["Level"] = 1,
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
									["PrtsAfter"] = 1,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22391",
									["Level"] = 1,
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
									["AndOr"] = "OR",
									["PrtsBefore"] = 1,
									["Level"] = 65,
									["PrtsAfter"] = 3,
									["Operator"] = ">",
								}, -- [12]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 30,
									["PrtsAfter"] = 2,
									["Operator"] = ">",
								}, -- [13]
								{
									["Name"] = "execute",
									["Type"] = "COUNTER",
								}, -- [14]
								["n"] = 14,
							},
							["GUID"] = "TMW:icon:1RGdpp2dIykT",
							["FakeHidden"] = true,
						}, -- [13]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "1464",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">",
								}, -- [4]
								{
									["Type"] = "SPELLCD",
									["Level"] = 1,
									["Name"] = "12294",
									["Operator"] = ">",
								}, -- [5]
								{
									["PrtsAfter"] = 1,
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
									["PrtsAfter"] = 1,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22391",
									["Level"] = 1,
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
									["AndOr"] = "OR",
									["PrtsBefore"] = 1,
									["Level"] = 65,
									["PrtsAfter"] = 4,
									["Operator"] = ">",
								}, -- [12]
								{
									["Name"] = "execute",
									["Type"] = "COUNTER",
								}, -- [13]
								["n"] = 13,
							},
							["GUID"] = "TMW:icon:1RGeIgsJQX0r",
							["FakeHidden"] = true,
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
							["Type"] = "swingtimer",
							["FakeHidden"] = true,
							["CustomTex"] = "8386",
							["GUID"] = "TMW:icon:1RJiuYRHNBx2",
						}, -- [15]
						{
							["GUID"] = "TMW:icon:1RJiuYRLZrXP",
							["ShowTimer"] = true,
							["DurationMaxEnabled"] = true,
							["FakeHidden"] = true,
							["Events"] = {
								{
									["Period"] = 1,
									["Type"] = "Animations",
									["Event"] = "WCSP",
									["Animation"] = "ICONFLASH",
								}, -- [1]
								["n"] = 1,
							},
							["DurationMax"] = 1,
							["Type"] = "swingtimer",
							["CustomTex"] = "8386",
							["Enabled"] = true,
						}, -- [16]
						{
							["ShowTTText"] = true,
							["Type"] = "buff",
							["Name"] = "7384",
							["Enabled"] = true,
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RGeD0uM4U3o",
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
							["Type"] = "cooldown",
							["ClockGCD"] = true,
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1RL=eAHTYJcw",
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
									["Checked"] = true,
									["Type"] = "DEBUFFDUR",
									["Name"] = "208086",
									["Unit"] = "target",
								}, -- [2]
								{
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">",
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
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
							["GUID"] = "TMW:icon:1RL=eAHVfoHi",
							["FakeHidden"] = true,
						}, -- [23]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "227847",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Level"] = 2,
									["Name"] = "208086",
									["Operator"] = ">",
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
							["GUID"] = "TMW:icon:1RTCMxEg4qi8",
							["FakeHidden"] = true,
						}, -- [24]
						{
							["GUID"] = "TMW:icon:1RTCN7EH5rEt",
							["ShowTimer"] = true,
							["ClockGCD"] = true,
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
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
									["Type"] = "SPELLCD",
									["Level"] = 1.5,
									["Name"] = "12294",
									["Operator"] = "<",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 30,
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
									["AndOr"] = "OR",
									["PrtsBefore"] = 1,
									["Level"] = 2,
									["Name"] = "272866",
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["AndOr"] = "OR",
									["Level"] = 2,
									["Name"] = "272867",
									["Unit"] = "target",
								}, -- [7]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Name"] = "272870",
									["AndOr"] = "OR",
									["Level"] = 2,
									["PrtsAfter"] = 3,
									["Unit"] = "target",
								}, -- [8]
								{
									["Icon"] = "TMW:icon:1RTD2ohayX3V",
									["Type"] = "ICON",
								}, -- [9]
								["n"] = 9,
							},
							["DurationMax"] = 2,
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
							["ClockGCD"] = true,
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
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
									["PrtsAfter"] = 1,
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["Unit"] = "target",
								}, -- [4]
								["n"] = 4,
							},
							["DurationMax"] = 2,
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
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
							["GUID"] = "TMW:icon:1RL=eAHYlywP",
							["FakeHidden"] = true,
						}, -- [27]
						{
							["GUID"] = "TMW:icon:1RL=eAHaq80u",
							["ShowTimer"] = true,
							["ClockGCD"] = true,
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]",
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Checked"] = true,
									["Type"] = "BUFFSTACKS",
									["Name"] = "7384",
									["Level"] = 2,
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
							["DurationMax"] = 2,
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
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
							["GUID"] = "TMW:icon:1Ra7fP21bk42",
							["FakeHidden"] = true,
						}, -- [29]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "228920",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["PrtsBefore"] = 2,
									["Level"] = 2,
									["Name"] = "208086",
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "HEALTH",
									["Unit"] = "target",
									["Level"] = 20,
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["Unit"] = "target",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Level"] = 20,
									["Operator"] = "<=",
								}, -- [3]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 30,
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
							["GUID"] = "TMW:icon:1RTCPcVTM2Je",
							["FakeHidden"] = true,
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
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Name"] = "298357",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1RL=eAHZoKRG",
							["FakeHidden"] = true,
						}, -- [31]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "163201",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
									["Unit"] = "target",
									["Level"] = 20,
									["PrtsAfter"] = 1,
									["Operator"] = "<",
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
									["Unit"] = "target",
									["Level"] = 35,
									["PrtsAfter"] = 3,
									["Operator"] = "<",
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
							["GUID"] = "TMW:icon:1RL=eAHWk5Yo",
							["FakeHidden"] = true,
						}, -- [32]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "1680",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
							["GUID"] = "TMW:icon:1RL=eAHbqFqW",
							["FakeHidden"] = true,
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
							["Type"] = "swingtimer",
							["FakeHidden"] = true,
							["CustomTex"] = "8386",
							["GUID"] = "TMW:icon:1RL=eAHcqhaW",
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
									["Unit"] = "target",
									["Level"] = 2,
									["Name"] = "208086",
									["Operator"] = "<",
								}, -- [2]
								{
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">",
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
							["GUID"] = "TMW:icon:1RTBxKd2Ohfq",
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
									["Type"] = "RAGE_ABS",
									["Level"] = 30,
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
							["FakeHidden"] = true,
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
							["ClockGCD"] = true,
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
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
									["Type"] = "SPELLCD",
									["Level"] = 3.5,
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
									["Type"] = "MHSWING",
									["Level"] = 2,
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
							["DurationMax"] = 2,
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
							["ClockGCD"] = true,
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]", -- [2]
									},
								},
							},
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
									["Type"] = "MHSWING",
									["Level"] = 2,
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
									["PrtsAfter"] = 1,
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["Unit"] = "target",
								}, -- [6]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGdpp2Rvc8H",
									["Level"] = 1,
								}, -- [7]
								["n"] = 7,
							},
							["DurationMax"] = 2,
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
							["GUID"] = "TMW:icon:1RTBxKd5Ox2K",
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
							["FakeHidden"] = true,
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
							["ClockGCD"] = true,
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "12294",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks(icon=\"TMW:icon:1RGeD0uM4U3o\"):Hide(0):Percent]",
									},
								},
							},
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
									["Type"] = "SPELLCD",
									["Level"] = 1.5,
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
									["Type"] = "MHSWING",
									["Level"] = 2,
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
									["PrtsAfter"] = 1,
									["Type"] = "COUNTER",
									["Name"] = "execute",
									["Unit"] = "target",
								}, -- [7]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGeD0uAObsB",
									["Level"] = 1,
								}, -- [8]
								["n"] = 8,
							},
							["DurationMax"] = 2,
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
							["ClockGCD"] = true,
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "7384",
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
									["Type"] = "RAGE_ABS",
									["Level"] = 35,
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
							["DurationMax"] = 2,
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
							["Type"] = "cooldown",
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
									["Unit"] = "target",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [4]
								{
									["Unit"] = "target",
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Name"] = "208086",
									["AndOr"] = "OR",
									["Level"] = 2,
									["PrtsAfter"] = 2,
									["Operator"] = "<",
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
							["FakeHidden"] = true,
						}, -- [48]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "163201",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
									["Type"] = "MHSWING",
									["Level"] = 2,
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
									["Unit"] = "target",
									["Level"] = 20,
									["PrtsAfter"] = 1,
									["Operator"] = "<",
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
									["Unit"] = "target",
									["Level"] = 35,
									["PrtsAfter"] = 3,
									["Operator"] = "<",
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
							["GUID"] = "TMW:icon:1RTBxKd8OIaD",
							["FakeHidden"] = true,
						}, -- [49]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "1680",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">",
								}, -- [4]
								{
									["Type"] = "SPELLCD",
									["Level"] = 1,
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
									["PrtsAfter"] = 1,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22391",
									["Level"] = 1,
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
									["AndOr"] = "OR",
									["PrtsBefore"] = 1,
									["Level"] = 40,
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
							["GUID"] = "TMW:icon:1RTBxKd9OUM_",
							["FakeHidden"] = true,
						}, -- [50]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Name"] = "1464",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">",
								}, -- [4]
								{
									["Type"] = "SPELLCD",
									["Level"] = 1,
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
									["PrtsAfter"] = 1,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22391",
									["Level"] = 1,
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
									["AndOr"] = "OR",
									["PrtsBefore"] = 1,
									["Level"] = 40,
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
							["GUID"] = "TMW:icon:1RTBxKdANcIS",
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
									["Name"] = "21667",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["Type"] = "cooldown",
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
							["ShowTimerText"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
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
							["Type"] = "cooldown",
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
							["Type"] = "buff",
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Name"] = "22397",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								["n"] = 2,
							},
							["ShowTimerText"] = true,
							["Enabled"] = true,
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
							["ShowTimerText"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
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
							["Type"] = "cooldown",
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
							["Type"] = "buff",
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Name"] = "22399",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								["n"] = 2,
							},
							["ShowTimerText"] = true,
							["Enabled"] = true,
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
							["ShowTimerText"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Name"] = "21667",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								["n"] = 2,
							},
							["Type"] = "cooldown",
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
									["Name"] = "22391",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["Type"] = "cooldown",
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
							["ShowTimerText"] = true,
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Name"] = "22391",
									["Type"] = "TALENTLEARNED",
								}, -- [2]
								["n"] = 2,
							},
							["Type"] = "cooldown",
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
							["GUID"] = "TMW:icon:1TCHfoi=WAuc",
							["Enabled"] = true,
						}, -- [72]
						[83] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["FakeHidden"] = true,
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
							["GUID"] = "TMW:icon:1RTC8jAsrdvG",
						},
						[85] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["FakeHidden"] = true,
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
							["GUID"] = "TMW:icon:1RTC8jApfn=I",
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
							["FakeHidden"] = true,
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
							["GUID"] = "TMW:icon:1RTC8jAyqkvm",
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
							["FakeHidden"] = true,
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
							["GUID"] = "TMW:icon:1RTC8jAvrtK1",
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
						[137] = {
							["GUID"] = "TMW:icon:1Rg0QjxDyopx",
							["ShowTimer"] = true,
							["Name"] = "6673",
							["Enabled"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1Rg0QjxDyopx",
											["Type"] = "ICON",
										}, -- [1]
										["n"] = 1,
									},
									["Event"] = "WCSP",
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Type"] = "buff",
							["FakeHidden"] = true,
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
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
						[136] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "46924; 227847",
							["Type"] = "buff",
							["DurationMin"] = 1,
							["DurationMinEnabled"] = true,
							["GUID"] = "TMW:icon:1RL=eAD8Kmw0",
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
							["FakeHidden"] = true,
							["CustomTex"] = "152277",
							["GUID"] = "TMW:icon:1RYjOKqPrqZ0",
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
							["FakeHidden"] = true,
							["CustomTex"] = "107574",
							["GUID"] = "TMW:icon:1RYjOK3OUw0_",
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
							["FakeHidden"] = true,
							["CustomTex"] = "167105",
							["GUID"] = "TMW:icon:1RZA9mRp2XSl",
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
							["FakeHidden"] = true,
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
							["GUID"] = "TMW:icon:1RTD2m1wLgWu",
						},
						[133] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["ClockGCD"] = true,
							["Name"] = "403",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 0.8,
									["Animation"] = "ICONALPHAFLASH",
									["Infinite"] = true,
									["AnimColor"] = "ff000000",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Icon"] = "TMW:icon:1QpP_HqMELD0",
											["Type"] = "ICON",
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
									["AndOr"] = "OR",
									["Level"] = 2,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [3]
								["n"] = 3,
							},
							["CustomTex"] = "163446",
							["GUID"] = "TMW:icon:1QpP_HqMELD0",
						},
						[86] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["FakeHidden"] = true,
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
							["GUID"] = "TMW:icon:1Rg1obpBJO85",
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
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "143612",
							["Enabled"] = true,
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
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "88163",
							["Enabled"] = true,
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
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "204219",
							["Enabled"] = true,
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
						[138] = {
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Name"] = "280735",
							["ClockGCD"] = true,
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
									["Unit"] = "target",
									["PrtsBefore"] = 2,
									["Level"] = 20,
									["PrtsAfter"] = 1,
									["Operator"] = "<",
								}, -- [1]
								{
									["PrtsBefore"] = 1,
									["Type"] = "TALENTLEARNED",
									["Name"] = "22380",
									["AndOr"] = "OR",
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["Unit"] = "target",
									["Level"] = 35,
									["PrtsAfter"] = 2,
									["Operator"] = "<",
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
							["CustomTex"] = "5308",
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
							["FakeHidden"] = true,
							["CustomTex"] = "275529",
							["GUID"] = "TMW:icon:1RZ8bU8Z1jLS",
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
							["FakeHidden"] = true,
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
							["GUID"] = "TMW:icon:1RTD2ohayX3V",
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
							["FakeHidden"] = true,
							["CustomTex"] = "46924",
							["GUID"] = "TMW:icon:1RYjPWe1zjh4",
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
					["Point"] = {
						["y"] = -57.32825844569,
						["relativeTo"] = "TMW:group:1Ov1GPZDfFXX",
						["point"] = "TOP",
						["relativePoint"] = "TOP",
						["x"] = 0.00032635226234065,
					},
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
									["Animation"] = "ICONBORDER",
									["Infinite"] = true,
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
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
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
									["Animation"] = "ICONBORDER",
									["Infinite"] = true,
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
									["Animation"] = "ICONBORDER",
									["Infinite"] = true,
								}, -- [1]
								["n"] = 1,
							},
							["BarDisplay_Invert"] = true,
							["TimerBar_EnableColors"] = true,
							["Enabled"] = true,
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
									["Animation"] = "ICONBORDER",
									["Infinite"] = true,
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
							["BackdropColor"] = "ffff6500",
							["BackdropColor_Enable"] = true,
							["TimerBar_EnableColors"] = true,
							["TimerBar_CompleteColor"] = "0000ff00",
						}, -- [4]
						{
							["BackdropColor"] = "ff402200",
							["Type"] = "buff",
							["TimerBar_MiddleColor"] = "ffac5d00",
							["Enabled"] = true,
							["BackdropColor_Enable"] = true,
							["TimerBar_CompleteColor"] = "ffac5d00",
							["TimerBar_StartColor"] = "ffac5d00",
							["ShowTTText"] = true,
							["OnlyMine"] = true,
							["Name"] = "190456",
							["SettingsPerView"] = {
								["bar"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[AuraSource AuraSource]", -- [2]
									},
								},
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
									["Animation"] = "ICONBORDER",
									["Infinite"] = true,
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[73] = true,
									},
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
							["Type"] = "VEHICLE",
							["Level"] = 1,
						}, -- [9]
						["n"] = 9,
					},
					["EnabledSpecs"] = {
						[72] = false,
						[73] = false,
					},
					["GUID"] = "TMW:group:1QoUgaC7I4Vd",
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
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
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
							["Type"] = "VEHICLE",
							["Level"] = 1,
						}, -- [9]
						["n"] = 9,
					},
					["EnabledSpecs"] = {
						[72] = false,
						[73] = false,
					},
					["Name"] = "Main Rotation (Meta)",
				}, -- [4]
				{
					["GUID"] = "TMW:group:1QvCPR5qcfPC",
					["Strata"] = "LOW",
					["Point"] = {
						["x"] = -0.00019878718566014,
						["relativeTo"] = "TMW:group:1QoUgaC7I4Vd",
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
							["Name"] = "6552",
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
							["Type"] = "cooldown",
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
							["Type"] = "VEHICLE",
							["Level"] = 1,
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
							["BarDisplay_Invert"] = true,
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
							["TimerBar_CompleteColor"] = "ff886332",
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
							["BarDisplay_Invert"] = true,
							["CustomTex"] = "NONE",
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["CustomTex"] = "NONE",
							["TimerBar_EnableColors"] = true,
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
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
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
									["Animation"] = "ICONFLASH",
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
										"AoE/Single", -- [1]
										"Blade Storm", -- [2]
									},
								},
							},
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
									["Animation"] = "ICONFLASH",
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
										"AoE", -- [1]
										"Ravager", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
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
									["Animation"] = "ICONFLASH",
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
										"Single", -- [1]
										"Avatar", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
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
									["Animation"] = "ICONFLASH",
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
										"Single", -- [1]
										"Colossus Smash/Warbreaker", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
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
									["Animation"] = "ICONFLASH",
									["Type"] = "Animations",
									["Period"] = 0,
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "7f00ff1d",
									["OnConditionConditions"] = {
										{
											["Name"] = "testofmight",
											["Type"] = "COUNTER",
										}, -- [1]
										["n"] = 1,
									},
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
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
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
					["GUID"] = "TMW:group:1T3cKuwHQNun",
					["Name"] = "Cooldown Menu",
					["SettingsPerView"] = {
						["bar"] = {
							["BorderBar"] = 2,
							["SizeX"] = 245.04655456543,
							["Icon"] = false,
						},
					},
					["BackdropColor"] = "00333333",
					["Conditions"] = {
						{
							["Type"] = "COUNTER",
							["Name"] = "menu_open",
							["Level"] = 1,
						}, -- [1]
						["n"] = 1,
					},
					["ShrinkGroup"] = true,
					["TimerBar_EnableColors"] = true,
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
							["ShowTimerText"] = true,
							["CustomTex"] = "Attack",
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
							["Enabled"] = true,
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
							["ShowTimerText"] = true,
							["Name"] = "260708",
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
							["Events"] = {
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ffffff00",
									["Event"] = "OnDuration",
									["Operator"] = "<=",
									["PassingCndt"] = true,
									["OnlyShown"] = true,
									["CndtJustPassed"] = true,
									["Value"] = 1,
									["Animation"] = "ICONALPHAFLASH",
								}, -- [1]
								{
									["Type"] = "Animations",
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["AnimColor"] = "ffffff00",
									["Event"] = "OnDuration",
									["Operator"] = "<=",
									["PassingCndt"] = true,
									["OnlyShown"] = true,
									["CndtJustPassed"] = true,
									["Value"] = 1,
									["Animation"] = "ICONBORDER",
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
									["Animation"] = "ICONBORDER",
									["Infinite"] = true,
								}, -- [3]
								["n"] = 3,
							},
							["Conditions"] = {
								{
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
								}, -- [1]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1RGeD16XRQTK",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["BackdropColor"] = "00ff6500",
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
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["TimerBar_StartColor"] = "ffffda00",
							["Events"] = {
								{
									["Type"] = "Animations",
									["CndtJustPassed"] = true,
									["AnimColor"] = "ffffff00",
									["Event"] = "OnDuration",
									["Operator"] = ">",
									["PassingCndt"] = true,
									["OnlyShown"] = true,
									["Animation"] = "ICONBORDER",
									["Infinite"] = true,
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
									["Animation"] = "ICONBORDER",
									["Infinite"] = true,
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
							["Name"] = "260708",
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
							["Enabled"] = true,
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
							["Type"] = "VEHICLE",
							["Level"] = 1,
						}, -- [9]
						["n"] = 9,
					},
					["BackdropColor"] = "ff000000",
					["View"] = "bar",
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
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
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
									["Type"] = "UNITSPEC",
									["BitFlags"] = {
										[71] = true,
									},
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
							["Type"] = "VEHICLE",
							["Level"] = 1,
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
			["WarnInvalids"] = false,
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
							["GUID"] = "TMW:icon:1TQv_Lti1RyX",
							["CooldownCheck"] = true,
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
			["NumGroups"] = 5,
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
			["Version"] = 91200,
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
							["GUID"] = "TMW:icon:1TVSlzDpfz8W",
							["ShowTimerText"] = true,
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
							["Name"] = "1130; 14323; 14324; 14325",
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
							["Type"] = "buff",
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
							["Name"] = "5116",
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
							["Type"] = "buff",
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
							["Name"] = "2974; 14267; 14268",
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
							["GUID"] = "TMW:icon:1TVSeFFt8WOP",
							["FakeHidden"] = true,
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
							["Name"] = "1495",
							["Type"] = "reactive",
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
							["GUID"] = "TMW:icon:1TVSIOSMkJrY",
							["FakeHidden"] = true,
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
							["Name"] = "19434",
							["Type"] = "cooldown",
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
							["Type"] = "buff",
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
							["Name"] = "1978; 13549; 13550; 13551; 13552; 13553; 13554; 13555; 25295",
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
							["GUID"] = "TMW:icon:1TT8M1YQC7C2",
							["ShowTimerText"] = true,
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
							["Name"] = "3044",
							["Type"] = "cooldown",
						}, -- [10]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["GUID"] = "TMW:icon:1TT6tqd5wK83",
							["Type"] = "cooldown",
							["FakeHidden"] = true,
							["ClockGCD"] = true,
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
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["DurationMaxEnabled"] = true,
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
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["ShowTimerText"] = true,
							["DurationMax"] = 4.5,
							["DurationMinEnabled"] = true,
							["DurationMin"] = 3,
							["Name"] = "1978; 13549; 13550; 13551; 13552; 13553; 13554; 13555; 25295",
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
							["GUID"] = "TMW:icon:1T4P1u1jl30C",
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "21913",
							["Enabled"] = true,
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
							["GUID"] = "TMW:icon:1TT71vNC3VXL",
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "19507",
							["Enabled"] = true,
						},
						[76] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ShowTimerText"] = true,
							["GUID"] = "TMW:icon:1TVSIOVxdUiM",
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
							["Type"] = "conditionicon",
						},
						[39] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["DurationMaxEnabled"] = true,
							["GUID"] = "TMW:icon:1TVSIOUd0NXr",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
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
							["ShowTimerText"] = true,
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
							["Name"] = "3044",
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
							["OnlyMine"] = true,
							["Enabled"] = true,
							["Unit"] = "target",
						},
						[94] = {
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "20043; 20190",
							["GUID"] = "TMW:icon:1TVSIOWpyLe9",
							["OnlyMine"] = true,
						},
						[32] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["GUID"] = "TMW:icon:1TVSqJ8ycRuW",
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["DurationMaxEnabled"] = true,
							["DurationMinEnabled"] = true,
							["Unit"] = "target",
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
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1TVSlzDpfz8W",
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["ShowTimerText"] = true,
							["DurationMax"] = 4.5,
							["Name"] = "1130; 14323; 14324; 14325",
							["DurationMin"] = 3,
							["ClockGCD"] = true,
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
							["ShowTimerText"] = true,
							["BarDisplay_BarGCD"] = true,
							["Name"] = 75,
							["FakeHidden"] = true,
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
							["GUID"] = "TMW:icon:1T4P1xmoGuCz",
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "13715",
							["Enabled"] = true,
						},
						[80] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["ShowTimerText"] = true,
							["GUID"] = "TMW:icon:1TVSIOWJ1T0I",
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["Name"] = "spell = IsSpellKnown(5116)\n\nreturn spell",
									["Type"] = "LUA",
								}, -- [1]
								["n"] = 1,
							},
							["Name"] = "5116",
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
									["Unit"] = "target",
									["Level"] = 5,
									["Type"] = "LIBRANGECHECK",
									["Operator"] = "<=",
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
							["GUID"] = "TMW:icon:1TVSqR9grYi3",
							["Unit"] = "target",
							["ClockGCD"] = true,
							["OnlyMine"] = true,
							["ShowTimerText"] = true,
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
							["Name"] = "5116",
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
							["GUID"] = "TMW:icon:1TVSqg4jQ45b",
							["Unit"] = "target",
							["ClockGCD"] = true,
							["OnlyMine"] = true,
							["ShowTimerText"] = true,
							["DurationMax"] = 1.5,
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
							["Name"] = "2974; 14267; 14268",
							["Type"] = "buff",
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
							["GUID"] = "TMW:icon:1T4P1xniOGqa",
							["Conditions"] = {
								{
									["Name"] = "settings_toggle",
									["Type"] = "COUNTER",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "1130",
							["Enabled"] = true,
						},
						[35] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["ClockGCD"] = true,
							["GUID"] = "TMW:icon:1TVSqyJmaHeI",
							["ShowTimerText"] = true,
							["Type"] = "cooldown",
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
							["Name"] = "2973",
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
							["GUID"] = "TMW:icon:1TT6FY9daRvb",
							["CustomTex"] = "NONE",
							["Enabled"] = true,
						},
						[77] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["FakeHidden"] = true,
							["ShowTimerText"] = true,
							["GUID"] = "TMW:icon:1TVSIOW0oWeD",
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
							["Type"] = "conditionicon",
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
						[97] = {
							["Enabled"] = true,
							["CLEUEvents"] = {
								["RANGE_DAMAGE"] = true,
							},
							["Name"] = "75",
							["CLEUDur"] = 1,
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
							["Type"] = "cleu",
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
						[37] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["DurationMaxEnabled"] = true,
							["GUID"] = "TMW:icon:1TVSrFdTPYOk",
							["Type"] = "cooldown",
							["ClockGCD"] = true,
							["Events"] = {
								{
									["Image"] = "5676",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Unit"] = "target",
											["Level"] = 10,
											["Type"] = "HEALTH",
											["Operator"] = "<",
										}, -- [1]
										{
											["Name"] = "spell = IsSpellKnown(5676)\n\nreturn spell",
											["Type"] = "LUA",
										}, -- [2]
										["n"] = 2,
									},
									["Alpha"] = 1,
									["Fade"] = false,
								}, -- [1]
								["n"] = 1,
							},
							["ShowTimerText"] = true,
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
							["Name"] = "19434",
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
							["Type"] = "cooldown",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONBORDER",
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
									["AnimColor"] = "ff000000",
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
									["Icon"] = "TMW:icon:1TVSIOWJ1T0I",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["Name"] = "781",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
						},
						[95] = {
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "20043; 20190; 13165; 14318; 14319; 14320; 14321; 14322; 25296; 13161; 5118; 13159; 13163",
							["GUID"] = "TMW:icon:1TVSIOWrar8Y",
							["OnlyMine"] = true,
						},
						[93] = {
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "13165; 14318; 14319; 14320; 14321; 14322; 25296",
							["GUID"] = "TMW:icon:1TVSIOWoVz8k",
							["OnlyMine"] = true,
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
							["GUID"] = "TMW:icon:1TRoURgXVpaz",
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
							["Enabled"] = true,
						},
					},
					["Scale"] = 0.600000023841858,
					["Rows"] = 7,
					["Alpha"] = 0,
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
					["Point"] = {
						["y"] = -97.4739888509115,
						["x"] = -1.26411946614583,
					},
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
					["Name"] = "Main Meta",
				}, -- [3]
				{
					["View"] = "bar",
					["Columns"] = 1,
					["Point"] = {
						["y"] = 8.96281651823714e-05,
						["relativeTo"] = "TMW:group:1TRW5crzGrfW",
						["point"] = "TOP",
						["relativePoint"] = "BOTTOM",
						["x"] = -8.92121632755042e-05,
					},
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
							["CustomTex"] = "NONE",
							["Conditions"] = {
								{
									["Unit"] = "pet",
									["Type"] = "EXISTS",
								}, -- [1]
								{
									["Unit"] = "pet",
									["Type"] = "ALIVE",
								}, -- [2]
								["n"] = 2,
							},
							["TimerBar_EnableColors"] = true,
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"[(Value / ValueMax * 100):Round:Percent]", -- [1]
										"      [Name(unit=\"pet\"):Cyan]", -- [2]
									},
								},
							},
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
									["OnConditionConditions"] = {
										{
											["Level"] = 1,
											["Type"] = "EXISTS",
											["Name"] = "border_toggle",
											["Unit"] = "pet",
										}, -- [1]
										{
											["Level"] = 1,
											["Type"] = "ALIVE",
											["AndOr"] = "OR",
											["Unit"] = "pet",
										}, -- [2]
										["n"] = 2,
									},
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["OnlyShown"] = true,
									["AnimColor"] = "ffffff00",
									["Event"] = "WCSP",
									["Animation"] = "ICONBORDER",
								}, -- [1]
								["n"] = 1,
							},
							["TimerBar_StartColor"] = "ffb00000",
							["CustomTex"] = "883",
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "EXISTS",
									["Level"] = 1,
									["Unit"] = "pet",
								}, -- [1]
								{
									["Type"] = "ALIVE",
									["Level"] = 1,
									["AndOr"] = "OR",
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
							["SettingsPerView"] = {
								["bar"] = {
									["TextLayout"] = "bar1",
									["Texts"] = {
										"", -- [1]
										"      REVIVE/CALL PET", -- [2]
									},
								},
							},
						}, -- [4]
					},
					["TextureName"] = "Solid",
					["BackdropColor_Enable"] = true,
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
							["Icon"] = false,
							["SizeX"] = 170,
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
					["BackdropColor"] = "ff000000",
					["GUID"] = "TMW:group:1TRksRXJhTqd",
				}, -- [4]
				{
					["GUID"] = "TMW:group:1TRnYiiWZwGk",
					["Columns"] = 7,
					["Scale"] = 0.92,
					["Icons"] = {
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Events"] = {
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
								}, -- [1]
								["n"] = 1,
							},
							["ShowTimerText"] = true,
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
							["OnlyInBags"] = true,
						}, -- [1]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Events"] = {
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
								}, -- [1]
								["n"] = 1,
							},
							["ShowTimerText"] = true,
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
							["OnlyInBags"] = true,
						}, -- [2]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Events"] = {
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
								}, -- [1]
								["n"] = 1,
							},
							["ShowTimerText"] = true,
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
							["OnlyInBags"] = true,
						}, -- [3]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Events"] = {
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
								}, -- [1]
								["n"] = 1,
							},
							["ShowTimerText"] = true,
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
							["OnlyInBags"] = true,
						}, -- [4]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Events"] = {
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
								}, -- [1]
								["n"] = 1,
							},
							["ShowTimerText"] = true,
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
							["OnlyInBags"] = true,
						}, -- [5]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Events"] = {
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
								}, -- [1]
								["n"] = 1,
							},
							["ShowTimerText"] = true,
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
							["OnlyInBags"] = true,
						}, -- [6]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Events"] = {
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
								}, -- [1]
								["n"] = 1,
							},
							["ShowTimerText"] = true,
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
							["OnlyInBags"] = true,
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
							["BarDisplay_Invert"] = true,
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
							["BarDisplay_Reverse"] = true,
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
							["BarDisplay_Invert"] = true,
							["CustomTex"] = "NONE",
							["TimerBar_EnableColors"] = true,
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
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["OnlyShown"] = true,
									["AnimColor"] = "ff00fff1",
									["Event"] = "WCSP",
									["Animation"] = "ICONFLASH",
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
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["OnlyShown"] = true,
									["AnimColor"] = "ff00fff1",
									["Event"] = "WCSP",
									["Animation"] = "ICONFLASH",
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
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["OnlyShown"] = true,
									["AnimColor"] = "ff00fff1",
									["Event"] = "WCSP",
									["Animation"] = "ICONFLASH",
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
							["BarDisplay_Invert"] = true,
							["CustomTex"] = "NONE",
							["TimerBar_EnableColors"] = true,
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
									["OnConditionConditions"] = {
										{
											["Type"] = "MOUSEOVER",
										}, -- [1]
										["n"] = 1,
									},
									["AnimColor"] = "af00c0ff",
									["Event"] = "WCSP",
									["Animation"] = "ICONFLASH",
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
							["BarDisplay_Invert"] = true,
							["CustomTex"] = "NONE",
							["TimerBar_EnableColors"] = true,
							["TimerBar_CompleteColor"] = "005dff55",
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
									["AnimColor"] = "9400d4ff",
									["Event"] = "WCSP",
									["Animation"] = "ICONFLASH",
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
									["AnchorTo"] = "IconModule_TimerBar_BarDisplayTimerBar",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONFLASH",
									["OnConditionConditions"] = {
										{
											["Type"] = "COUNTER",
											["Name"] = "heal/dps_toggle",
											["Level"] = 1,
										}, -- [1]
										["n"] = 1,
									},
									["AnimColor"] = "9400d4ff",
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
							["BarDisplay_Invert"] = true,
							["CustomTex"] = "NONE",
							["TimerBar_EnableColors"] = true,
							["TimerBar_CompleteColor"] = "005dff55",
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
					["GUID"] = "TMW:group:1T4PJbRYY3Gh",
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
							["ConditionDurEnabled"] = true,
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
							["CustomTex"] = "Attack",
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
					["Point"] = {
						["relativeTo"] = "TMW:group:1TRW5crzGrfW",
						["point"] = "BOTTOM",
						["relativePoint"] = "TOP",
					},
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
									["Image"] = "13161",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Name"] = "13161",
											["Type"] = "BUFFDUR",
											["Checked"] = true,
											["Operator"] = "~=",
										}, -- [1]
										["n"] = 1,
									},
									["Alpha"] = 1,
									["Fade"] = false,
								}, -- [2]
								{
									["Image"] = "13165",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Event"] = "WCSP",
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
									["Alpha"] = 1,
									["Fade"] = false,
								}, -- [3]
								{
									["Image"] = "13163",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Event"] = "WCSP",
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
									["Alpha"] = 1,
									["Fade"] = false,
								}, -- [4]
								{
									["Image"] = "5118",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["Name"] = "5118",
											["Type"] = "BUFFDUR",
											["Checked"] = true,
											["Operator"] = "~=",
										}, -- [1]
										["n"] = 1,
									},
									["Alpha"] = 1,
									["Fade"] = false,
								}, -- [5]
								{
									["Image"] = "20043",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Event"] = "WCSP",
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
									["Alpha"] = 1,
									["Fade"] = false,
								}, -- [6]
								{
									["Image"] = "13159",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Event"] = "WCSP",
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
									["Fade"] = false,
								}, -- [7]
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
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
									["Image"] = "13159",
								}, -- [8]
								["n"] = 8,
							},
							["CustomTex"] = "NONE",
						}, -- [1]
					},
					["Name"] = "Aspects",
				}, -- [8]
				{
					["View"] = "bar",
					["Columns"] = 1,
					["Scale"] = 1.59580385684967,
					["Icons"] = {
						{
							["BackdropColor"] = "00333333",
							["Type"] = "conditionicon",
							["Enabled"] = true,
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"Version 1.0.6", -- [1]
										"[\"Hunter\":Yellow]", -- [2]
									},
								},
							},
							["TimerBar_EnableColors"] = true,
							["BackdropColor_Enable"] = true,
							["TimerBar_CompleteColor"] = "0000ff00",
							["Conditions"] = {
								{
									["Type"] = "COUNTER",
									["Name"] = "settings_help",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
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
					["Point"] = {
						["y"] = -83.1354304445333,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["GUID"] = "TMW:group:1TlsU424Yf48",
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
							["OnlyInBags"] = true,
						}, -- [20]
					},
					["Name"] = "Ammo 1",
					["SettingsPerView"] = {
						["bar"] = {
							["Icon"] = false,
							["BorderInset"] = false,
							["SizeX"] = 1.8,
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
					["Point"] = {
						["y"] = -42,
						["relativeTo"] = "TMW:group:1TRW5crzGrfW",
						["x"] = -5,
						["relativePoint"] = "LEFT",
					},
					["GUID"] = "TMW:group:1To6C6Z742Ke",
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
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
							["BarDisplay_Invert"] = true,
							["StackMinEnabled"] = true,
							["TimerBar_EnableColors"] = true,
							["OnlyInBags"] = true,
						}, -- [20]
					},
					["Name"] = "Ammo2",
					["SettingsPerView"] = {
						["bar"] = {
							["Icon"] = false,
							["SizeX"] = 1.8,
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
					["Point"] = {
						["relativeTo"] = "TMW:group:1To6C6Z742Ke",
						["point"] = "LEFT",
						["relativePoint"] = "RIGHT",
					},
					["GUID"] = "TMW:group:1To6LXAC9Pm=",
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
					["Point"] = {
						["y"] = -118.407198257969,
						["x"] = 0.613753437995911,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
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
							["Enabled"] = true,
							["BackdropColor_Enable"] = true,
							["TimerBar_EnableColors"] = true,
							["OnlyInBags"] = true,
						}, -- [2]
					},
					["GUID"] = "TMW:group:1To6c=dO874e",
				}, -- [12]
				{
					["GUID"] = "TMW:group:1To6q47skjGf",
					["Strata"] = "HIGH",
					["Columns"] = 1,
					["SettingsPerView"] = {
						["icon"] = {
							["BorderInset"] = true,
							["BorderIcon"] = 4,
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
							["Name"] = 75,
							["ShowTimerText"] = true,
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
									["Image"] = "1510",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Event"] = "WCSP",
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
									["Alpha"] = 1,
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
							["Icon"] = false,
							["SizeX"] = 528.4,
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
					["Point"] = {
						["y"] = -50,
						["relativeTo"] = "TMW:group:1TRW5crzGrfW",
						["point"] = "TOP",
						["relativePoint"] = "BOTTOM",
					},
					["GUID"] = "TMW:group:1ToTf=FXnCas",
				}, -- [14]
				{
					["GUID"] = "TMW:group:1ToW0Zn8i3m8",
					["Strata"] = "HIGH",
					["Columns"] = 1,
					["Point"] = {
						["y"] = -30,
						["relativeTo"] = "TMW:group:1To6q47skjGf",
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
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
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Thickness"] = 3,
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
								}, -- [1]
								{
									["Image"] = "28059",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["BitFlags"] = 4,
											["Type"] = "HAPPINESS",
										}, -- [1]
										["n"] = 1,
									},
									["Alpha"] = 1,
									["Fade"] = false,
								}, -- [2]
								{
									["Image"] = "28084",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["BitFlags"] = 1,
											["Type"] = "HAPPINESS",
										}, -- [1]
										["n"] = 1,
									},
									["Alpha"] = 1,
									["Fade"] = false,
								}, -- [3]
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["BitFlags"] = 1,
											["Type"] = "HAPPINESS",
										}, -- [1]
										["n"] = 1,
									},
									["Alpha"] = 1,
									["Image"] = "28084",
								}, -- [4]
								{
									["Image"] = "23214",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["BitFlags"] = 2,
											["Type"] = "HAPPINESS",
										}, -- [1]
										["n"] = 1,
									},
									["Alpha"] = 1,
									["Fade"] = false,
								}, -- [5]
								["n"] = 5,
							},
							["Conditions"] = {
								{
									["Unit"] = "pet",
									["Type"] = "EXISTS",
								}, -- [1]
								{
									["Unit"] = "pet",
									["Type"] = "ALIVE",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "NONE",
						}, -- [1]
					},
					["Locked"] = true,
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
					["Point"] = {
						["y"] = -17.114990234375,
						["x"] = 1089.48962402344,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Icons"] = {
						{
							["BackdropColor"] = "00333333",
							["Type"] = "conditionicon",
							["TimerBar_MiddleColor"] = "00ffff00",
							["GUID"] = "TMW:icon:1ToXXbNIIbiY",
							["BackdropColor_Enable"] = true,
							["TimerBar_CompleteColor"] = "0000ff00",
							["ConditionDurEnabled"] = true,
							["TimerBar_StartColor"] = "00ff0000",
							["OnlyIfCounting"] = true,
							["ConditionDur"] = 5,
							["SettingsPerView"] = {
								["bar"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"Happiness has [\"DECREASED!\":Red]", -- [1]
										"Happiness has [\"DECREASED!\":Red]", -- [2]
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["BitFlags"] = 3,
									["Type"] = "HAPPINESS",
								}, -- [1]
								["n"] = 1,
							},
							["TimerBar_EnableColors"] = true,
							["Events"] = {
								{
									["Type"] = "Animations",
									["Event"] = "OnHide",
									["Animation"] = "ICONFADE",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["ConditionDur"] = 5,
							["ConditionDurEnabled"] = true,
							["OnlyIfCounting"] = true,
						}, -- [2]
					},
					["GUID"] = "TMW:group:1ToXtohxkhmd",
				}, -- [16]
				{
					["View"] = "bar",
					["Point"] = {
						["y"] = -165,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Columns"] = 1,
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 292.663726806641,
							["Icon"] = false,
						},
					},
					["Scale"] = 1.25617873668671,
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
					["Locked"] = true,
				}, -- [17]
				{
					["GUID"] = "TMW:group:1ToaOwcAiwGJ",
					["Columns"] = 1,
					["Scale"] = 1.97506868839264,
					["Point"] = {
						["y"] = 114.372060823582,
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
								}, -- [1]
								{
									["Image"] = "28059",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["BitFlags"] = 4,
											["Type"] = "HAPPINESS",
										}, -- [1]
										["n"] = 1,
									},
									["Alpha"] = 1,
									["Fade"] = false,
								}, -- [2]
								{
									["Image"] = "28084",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["BitFlags"] = 1,
											["Type"] = "HAPPINESS",
										}, -- [1]
										["n"] = 1,
									},
									["Alpha"] = 1,
									["Fade"] = false,
								}, -- [3]
								{
									["Type"] = "Animations",
									["Animation"] = "ICONBORDER",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["BitFlags"] = 1,
											["Type"] = "HAPPINESS",
										}, -- [1]
										["n"] = 1,
									},
									["Alpha"] = 1,
									["Image"] = "28084",
								}, -- [4]
								{
									["Image"] = "23214",
									["Type"] = "Animations",
									["Period"] = 0,
									["Animation"] = "ICONOVERLAYIMG",
									["Event"] = "WCSP",
									["OnConditionConditions"] = {
										{
											["BitFlags"] = 2,
											["Type"] = "HAPPINESS",
										}, -- [1]
										["n"] = 1,
									},
									["Alpha"] = 1,
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
									["AndOr"] = "OR",
									["Type"] = "UNITISUNIT",
									["Name"] = "pet",
									["Unit"] = "target",
								}, -- [1]
								{
									["Level"] = 1,
									["Type"] = "COMBAT",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "NONE",
						}, -- [1]
					},
					["Locked"] = true,
				}, -- [18]
				{
					["GUID"] = "TMW:group:1ToaQe8RWB82",
					["Columns"] = 1,
					["Scale"] = 0.710862457752228,
					["Point"] = {
						["y"] = -9.74870521118185e-05,
						["relativeTo"] = "TMW:group:1ToaOwcAiwGJ",
						["point"] = "TOP",
						["relativePoint"] = "BOTTOM",
						["x"] = 2.33982563919343,
					},
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
									["AndOr"] = "OR",
									["Type"] = "UNITISUNIT",
									["Name"] = "pet",
									["Unit"] = "target",
								}, -- [1]
								{
									["Level"] = 1,
									["Type"] = "COMBAT",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "NONE",
						}, -- [1]
					},
					["Locked"] = true,
				}, -- [19]
			},
			["NumGroups"] = 19,
		},
		["Hunter"] = {
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
							["ManaCheck"] = true,
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
							["ManaCheck"] = true,
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
							["GUID"] = "TMW:icon:1YS2u64Alj4P",
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
							["Name"] = "Steady Shot",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Steady Shot",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1YS2u64Csf0H",
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
							["Type"] = "reactive",
							["Name"] = "Kill Command",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["GUID"] = "TMW:icon:1YYUluwZXp0V",
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
						[18] = {
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Unit"] = "pet",
							["Name"] = "Mend Pet",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1Y9UVC8yK0C2",
									["Texts"] = {
										"[PercentHP(unit=\"pet\"):Percent:HPColor]", -- [1]
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
								nil, -- [3]
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
						[20] = {
							["GUID"] = "TMW:icon:1VjwkIsn7fZp",
							["Type"] = "buff",
							["Name"] = "Frenzy Effect",
							["Enabled"] = true,
							["ShowTimerText"] = true,
							["CustomTex"] = "19615",
							["Unit"] = "pet",
						},
					},
					["Columns"] = 20,
					["OnlyInCombat"] = true,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Point"] = {
						["y"] = -20,
						["x"] = -230,
					},
					["Name"] = "OTHER",
					["Scale"] = 1.5,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1VjwkIslWpyf", -- [1]
								"TMW:icon:1VjwkIsn7fZp", -- [2]
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
								"TMW:icon:1X=OmHlbqz67", -- [1]
								"TMW:icon:1YYUluwZXp0V", -- [2]
								"TMW:icon:1YS2u64Alj4P", -- [3]
								"TMW:icon:1YS2u64Csf0H", -- [4]
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
					["Columns"] = 1,
					["Scale"] = 0.4,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1X=OmHlbqz67", -- [1]
								"TMW:icon:1YYUluwZXp0V", -- [2]
								"TMW:icon:1YS2u64Alj4P", -- [3]
								"TMW:icon:1YS2u64Csf0H", -- [4]
							},
							["Conditions"] = {
								{
									["Level"] = 1,
									["Type"] = "MOUNTED",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [1]
					},
					["Name"] = "ROTATION TOPLEFT",
					["Locked"] = true,
					["Conditions"] = {
						{
							["Level"] = 1,
							["Type"] = "MOUNTED",
						}, -- [1]
						["n"] = 1,
					},
					["Point"] = {
						["y"] = -0.00067138671875,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["OnlyInCombat"] = true,
				}, -- [4]
			},
			["Locked"] = true,
			["Version"] = 91200,
			["NumGroups"] = 4,
			["TextureName"] = "Glamour2",
		},
		["Warrior"] = {
			["Version"] = 91200,
			["Locked"] = true,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1TQvxnAfbGyU",
					["Columns"] = 20,
					["Scale"] = 1,
					["Rows"] = 2,
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
								{
									["Operator"] = ">=",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Unit"] = "target",
								}, -- [2]
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [3]
								{
									["Operator"] = ">=",
									["Level"] = 1000,
									["Type"] = "HEALTH_ABS",
									["Unit"] = "target",
								}, -- [4]
								["n"] = 4,
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
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["Name"] = "Battle Shout",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Level"] = 5,
									["Type"] = "BUFFDUR",
									["Name"] = "Battle Shout",
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
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
							["Enabled"] = true,
							["Type"] = "reactive",
							["Name"] = "Heroic Strike",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["PrtsBefore"] = 1,
									["Level"] = 20,
									["Operator"] = ">=",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["AndOr"] = "OR",
									["Name"] = "Defensive Stance",
									["PrtsAfter"] = 1,
								}, -- [2]
								{
									["PrtsBefore"] = 1,
									["Type"] = "SPELLCD",
									["Name"] = "Mortal Strike",
									["Operator"] = "~=",
								}, -- [3]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Bloodthirst",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [4]
								{
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend",
									["Type"] = "LUA",
								}, -- [5]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Heroic Strike",
									["Level"] = 1,
								}, -- [6]
								["n"] = 6,
							},
							["GUID"] = "TMW:icon:1TQv_Lti1RyX",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [3]
						{
							["Enabled"] = true,
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
								{
									["Name"] = "Battle Stance",
									["Type"] = "STANCE",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1TU=hLnlwyeY",
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
									["Unit"] = "target",
									["Type"] = "ALIVE",
								}, -- [1]
								{
									["Name"] = "Defensive Stance",
									["Type"] = "STANCE",
								}, -- [2]
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [3]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 10,
									["Operator"] = ">=",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1TWZdpV26rm5",
							["Unit"] = "target",
						}, -- [5]
						{
							["GUID"] = "TMW:icon:1TYYu4EDbfSz",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
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
							["Conditions"] = {
								{
									["Type"] = "DEBUFFSTACKS",
									["Name"] = "Sunder Armor",
									["PrtsBefore"] = 1,
									["Level"] = 2,
									["Operator"] = "<",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Name"] = "Sunder Armor",
									["Operator"] = "<=",
									["Level"] = 6,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [2]
								{
									["Unit"] = "target",
									["Type"] = "ALIVE",
								}, -- [3]
								{
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">=",
								}, -- [4]
								{
									["Operator"] = ">=",
									["Level"] = 1000,
									["Type"] = "HEALTH_ABS",
									["Unit"] = "target",
								}, -- [5]
								{
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend",
									["Type"] = "LUA",
								}, -- [6]
								["n"] = 6,
							},
							["HideIfNoUnits"] = true,
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
							["Enabled"] = true,
							["Type"] = "reactive",
							["Name"] = "Execute",
							["ManaCheck"] = true,
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
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [7]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Revenge",
							["ManaCheck"] = true,
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
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [8]
						{
							["Enabled"] = true,
							["Type"] = "reactive",
							["Name"] = "Cleave",
							["ManaCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["PrtsBefore"] = 1,
									["Level"] = 20,
									["Operator"] = ">=",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["AndOr"] = "OR",
									["Name"] = "Defensive Stance",
									["PrtsAfter"] = 1,
								}, -- [2]
								{
									["PrtsBefore"] = 1,
									["Type"] = "SPELLCD",
									["Name"] = "Mortal Strike",
									["Operator"] = "~=",
								}, -- [3]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Bloodthirst",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Operator"] = "~=",
								}, -- [4]
								{
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return true\nelse\n    return false\nend",
									["Type"] = "LUA",
								}, -- [5]
								{
									["Type"] = "CURRENTSPELL",
									["Name"] = "Cleave",
									["Level"] = 1,
								}, -- [6]
								["n"] = 6,
							},
							["GUID"] = "TMW:icon:1Y2=7t59vfSn",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
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
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">",
								}, -- [2]
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
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
							["Type"] = "reactive",
							["Name"] = "Heroic Strike",
							["ManaCheck"] = true,
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
								nil, -- [3]
								{
									["Alpha"] = 0,
								}, -- [4]
							},
						}, -- [12]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mortal Strike",
							["ManaCheck"] = true,
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
								nil, -- [3]
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
							["ManaCheck"] = true,
							["Type"] = "reactive",
							["Name"] = "Cleave",
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
							["GUID"] = "TMW:icon:1Y2=7t6wEuO2",
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
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
								nil, -- [3]
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
							["GUID"] = "TMW:icon:1YWHZ7T27TKe",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Thunder Clap",
							["Enabled"] = true,
							["RangeCheck"] = true,
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
									["Level"] = 6,
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Unit"] = "target",
									["Type"] = "EXISTS",
								}, -- [4]
								{
									["Unit"] = "target",
									["Type"] = "ALIVE",
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
						}, -- [19]
						{
							["GUID"] = "TMW:icon:1TWYMfcUzmi6",
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Name"] = "Hamstring",
							["Enabled"] = true,
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Operator"] = "~=",
									["Type"] = "MAINHAND",
								}, -- [1]
								{
									["Type"] = "RAGE",
									["Level"] = 80,
									["Operator"] = ">=",
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
						}, -- [20]
					},
					["Name"] = "SPELLS",
					["Locked"] = true,
					["Alpha"] = 0,
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
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
							["ShowTimerText"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
							["Name"] = "Blood Fury",
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
							["Enabled"] = true,
							["Name"] = "Recently Bandaged",
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
						[18] = {
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "Healthstone",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 20,
									["Operator"] = ">",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "5720",
							["GUID"] = "TMW:icon:1X=ERE5iZ8VU",
						},
						[19] = {
							["GUID"] = "TMW:icon:1X=ERE5kaXRD",
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
							["Enabled"] = true,
							["OnlyInBags"] = true,
						},
						[20] = {
							["GUID"] = "TMW:icon:1VagxKm_xQWz",
							["Type"] = "buff",
							["CBarOffs"] = 2,
							["Enabled"] = true,
							["Name"] = "Renew",
							["ShowCBar"] = true,
							["ShowTimerText"] = true,
						},
					},
					["Point"] = {
						["y"] = -65,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
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
								"TMW:icon:1YXBo4F3g7mS", -- [1]
								"TMW:icon:1X=ERE5kaXRD", -- [2]
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
								"TMW:icon:1YP2Xjgjriiu", -- [1]
								"TMW:icon:1YO4Qlh73rOw", -- [2]
								"TMW:icon:1YO55KEUKaW4", -- [3]
								"TMW:icon:1TQv_Ltf40Wl", -- [4]
								"TMW:icon:1TWZdpV26rm5", -- [5]
								"TMW:icon:1Xrn34GriOqy", -- [6]
								"TMW:icon:1TU=hLnlwyeY", -- [7]
								"TMW:icon:1TQv_LtTwAae", -- [8]
								"TMW:icon:1TZvNvflXM0_", -- [9]
								"TMW:icon:1TYYu4EDbfSz", -- [10]
								"TMW:icon:1YEqZQbYmmFD", -- [11]
								"TMW:icon:1XzwOSGxkHLD", -- [12]
								"TMW:icon:1YWHZ7T27TKe", -- [13]
								"TMW:icon:1Xwc=6KNp27d", -- [14]
								"TMW:icon:1TQv_Lti1RyX", -- [15]
								"TMW:icon:1XwhZnw4w0Sf", -- [16]
								"TMW:icon:1Y2=7t59vfSn", -- [17]
								"TMW:icon:1Y2=7t6wEuO2", -- [18]
								"TMW:icon:1TWYMfcUzmi6", -- [19]
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
								"TMW:icon:1YP2Xjgjriiu", -- [1]
								"TMW:icon:1YO4Qlh73rOw", -- [2]
								"TMW:icon:1YO55KEUKaW4", -- [3]
								"TMW:icon:1TQv_Ltf40Wl", -- [4]
								"TMW:icon:1TWZdpV26rm5", -- [5]
								"TMW:icon:1Xrn34GriOqy", -- [6]
								"TMW:icon:1TU=hLnlwyeY", -- [7]
								"TMW:icon:1TQv_LtTwAae", -- [8]
								"TMW:icon:1TZvNvflXM0_", -- [9]
								"TMW:icon:1TYYu4EDbfSz", -- [10]
								"TMW:icon:1YEqZQbYmmFD", -- [11]
								"TMW:icon:1XzwOSGxkHLD", -- [12]
								"TMW:icon:1YWHZ7T27TKe", -- [13]
								"TMW:icon:1Xwc=6KNp27d", -- [14]
								"TMW:icon:1TQv_Lti1RyX", -- [15]
								"TMW:icon:1XwhZnw4w0Sf", -- [16]
								"TMW:icon:1Y2=7t59vfSn", -- [17]
								"TMW:icon:1Y2=7t6wEuO2", -- [18]
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
					["SortPriorities"] = {
						{
							["Order"] = -1,
						}, -- [1]
					},
					["Name"] = "ROTATION TOPLEFT",
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
				}, -- [5]
			},
			["NumGroups"] = 5,
			["TextureName"] = "Glamour2",
		},
		["Paladin"] = {
			["Locked"] = true,
			["NumGroups"] = 5,
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
								"TMW:icon:1TQv_LtTwAae", -- [1]
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
					["Name"] = "ROTATION BUTTON",
					["SettingsPerView"] = {
						["icon"] = {
							["BorderInset"] = false,
							["BorderColor"] = "00000000",
						},
					},
					["Locked"] = true,
					["Columns"] = 1,
					["SortPriorities"] = {
						{
							["Order"] = -1,
						}, -- [1]
					},
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TQvxnAfbGyU",
					["Scale"] = 1,
					["Name"] = "SPELLS",
					["Alpha"] = 0,
					["Locked"] = true,
					["Columns"] = 20,
					["Icons"] = {
						{
							["ManaCheck"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Judgement",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1TQv_LtTwAae",
							["RangeCheck"] = true,
							["States"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								{
									["Alpha"] = 0.2,
								}, -- [4]
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
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "reactive",
							["Name"] = "Heroic Strike",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 30,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Type"] = "HEALTH",
									["PrtsBefore"] = 1,
									["Level"] = 20,
									["Unit"] = "target",
									["Operator"] = ">=",
								}, -- [2]
								{
									["PrtsAfter"] = 1,
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
									["AndOr"] = "OR",
								}, -- [3]
								["n"] = 3,
							},
							["GUID"] = "TMW:icon:1TQv_Lti1RyX",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Overpower",
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
							["GUID"] = "TMW:icon:1TU=hLnlwyeY",
							["ShowTimerText"] = true,
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
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Name"] = "Sunder Armor",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Stacks]",
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Unit"] = "target",
									["Level"] = 5,
									["Type"] = "DEBUFFSTACKS",
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["ShowTimerText"] = true,
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
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
								{
									["Type"] = "STANCE",
									["Name"] = "Defensive Stance",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1TZvNvflXM0_",
						}, -- [7]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Revenge",
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
						}, -- [8]
						{
							["Enabled"] = true,
							["Type"] = "reactive",
							["Name"] = "Cleave",
							["Conditions"] = {
								{
									["Type"] = "RAGE",
									["Level"] = 20,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">=",
								}, -- [2]
								["n"] = 2,
							},
						}, -- [9]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Whirlwind",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 30,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Name"] = "Berserker Stance",
									["Type"] = "STANCE",
								}, -- [2]
								{
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">",
								}, -- [3]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [4]
								{
									["Unit"] = "target",
									["Level"] = 10,
									["Type"] = "LIBRANGECHECK",
									["Operator"] = "<=",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1Xwc=6KNp27d",
						}, -- [10]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Victory Rush",
						}, -- [11]
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
								{
									["PrtsBefore"] = 2,
									["Type"] = "SPELLCD",
									["Name"] = "Whirlwind",
									["Operator"] = "~=",
								}, -- [2]
								{
									["Type"] = "STANCE",
									["PrtsAfter"] = 1,
									["Name"] = "Berserker Stance",
								}, -- [3]
								{
									["Type"] = "STANCE",
									["Name"] = "Berserker Stance",
									["Level"] = 1,
									["PrtsAfter"] = 1,
									["AndOr"] = "OR",
								}, -- [4]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Mortal Strike",
									["Operator"] = "~=",
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1XwhZnw4w0Sf",
						}, -- [12]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mortal Strike",
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 30,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Unit"] = "target",
									["Level"] = 20,
									["Type"] = "HEALTH",
									["Operator"] = ">",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1XzwOSGxkHLD",
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
								["n"] = 2,
							},
						}, -- [14]
						[20] = {
							["BuffOrDebuff"] = "HARMFUL",
							["GUID"] = "TMW:icon:1TWYMfcUzmi6",
						},
					},
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
				}, -- [2]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Columns"] = 1,
					["Point"] = {
						["y"] = -24.39078281325337,
						["x"] = -225.6130916101359,
					},
					["Scale"] = 1.5,
					["Name"] = "OTHER",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1X=ERE5kaXRD", -- [1]
								"TMW:icon:1Xx3hMFQR0cV", -- [2]
								"TMW:icon:1YIU6QIOOtfG", -- [3]
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
						{
							["GUID"] = "TMW:icon:1Xx3hMFQR0cV",
							["Type"] = "buff",
							["ShowTimerText"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Name"] = "Recently Bandaged",
							["Enabled"] = true,
						}, -- [3]
						[18] = {
							["Enabled"] = true,
							["Type"] = "item",
							["Name"] = "Healthstone",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 20,
									["Operator"] = ">",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "5720",
							["GUID"] = "TMW:icon:1X=ERE5iZ8VU",
						},
						[19] = {
							["GUID"] = "TMW:icon:1X=ERE5kaXRD",
							["Type"] = "item",
							["Name"] = "Major Healing Potion",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 15,
									["Operator"] = "<",
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
							["OnlyInBags"] = true,
						},
						[20] = {
							["GUID"] = "TMW:icon:1VagxKm_xQWz",
							["Type"] = "buff",
							["CBarOffs"] = 2,
							["ShowTimerText"] = true,
							["Name"] = "Renew",
							["ShowCBar"] = true,
							["Enabled"] = true,
						},
						[17] = {
							["GUID"] = "TMW:icon:1YIU6QIOOtfG",
							["Type"] = "buff",
							["Name"] = "Poison; Disease",
							["BuffOrDebuff"] = "HARMFUL",
							["ShowTimerText"] = true,
							["Enabled"] = true,
						},
					},
					["TextureName"] = "Details Flat",
					["Name"] = "BUFFS/DEBBUFS",
					["Locked"] = true,
					["Columns"] = 20,
					["Alpha"] = 0,
				}, -- [4]
				{
					["Enabled"] = false,
					["Columns"] = 1,
					["Scale"] = 1,
					["Locked"] = true,
					["GUID"] = "TMW:group:1V917nUku0KT",
					["Point"] = {
						["y"] = -140,
						["x"] = 42.500244140625,
					},
				}, -- [5]
			},
			["Version"] = 91200,
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
		["Battlearm - Golemagg"] = {
			["Locked"] = true,
			["Version"] = 91200,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1Vbhru5eED7w",
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
		["Jaroslav - Golemagg"] = {
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1VAdQEMGnK_K",
				}, -- [1]
			},
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
		["Druid"] = {
			["Version"] = 91200,
			["NumGroups"] = 4,
			["Groups"] = {
				{
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Scale"] = 1,
					["Rows"] = 3,
					["OnlyInCombat"] = true,
					["Locked"] = true,
					["GUID"] = "TMW:group:1TeVAjjUoOOh",
					["Columns"] = 20,
					["Icons"] = {
						{
							["Type"] = "cooldown",
							["Name"] = "Maul",
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
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Bear Form",
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
									["Type"] = "LUA",
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Swipe\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend",
								}, -- [4]
								{
									["Type"] = "LUA",
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Swipe\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return true\nelse\n    return false\nend",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
									["Level"] = 30,
								}, -- [6]
								["n"] = 6,
							},
						}, -- [1]
						{
							["OnlyMine"] = true,
							["Type"] = "cooldown",
							["Name"] = "Demoralizing Roar",
							["GUID"] = "TMW:icon:1TeVAjjavXC6",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Bear Form",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Unit"] = "target",
									["Name"] = "Demoralizing Roar",
								}, -- [2]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
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
							["RangeCheck"] = true,
							["Enabled"] = true,
						}, -- [2]
						{
							["Type"] = "cooldown",
							["Name"] = "Swipe",
							["Enabled"] = true,
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
							["RangeCheck"] = true,
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Bear Form",
								}, -- [1]
								{
									["Type"] = "EXISTS",
									["Unit"] = "target",
									["Name"] = "Swipe",
								}, -- [2]
								{
									["Type"] = "ALIVE",
									["Unit"] = "target",
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "LUA",
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Swipe\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return true\nelse\n    return false\nend",
								}, -- [4]
								{
									["Type"] = "LUA",
									["Name"] = "local inRange = 0\nfor i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Swipe\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
								}, -- [5]
								{
									["Type"] = "RAGE_ABS",
									["PrtsAfter"] = 1,
									["Operator"] = ">=",
									["Level"] = 50,
								}, -- [6]
								["n"] = 6,
							},
						}, -- [3]
						{
							["BuffOrDebuff"] = "HARMFUL",
							["Unit"] = "target",
							["Type"] = "cooldown",
							["Name"] = "Attack",
							["Enabled"] = true,
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
									["Type"] = "STANCE",
									["Name"] = "Bear Form; Cat Form",
								}, -- [3]
								["n"] = 3,
							},
						}, -- [4]
						[21] = {
							["Type"] = "cooldown",
							["Name"] = "Claw",
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1YYs1I2bCNGy",
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
									["Type"] = "COMBO",
									["Operator"] = "<",
									["PrtsBefore"] = 1,
									["Level"] = 5,
								}, -- [4]
								{
									["Type"] = "HEALTH_ABS",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
									["AndOr"] = "OR",
									["Operator"] = "<",
									["Level"] = 500,
								}, -- [5]
								{
									["Type"] = "LUA",
									["Name"] = "local red, green, blue, alpha = RotationFrame4:GetBackdropColor()\n\nif ceil(red) == 1 and ceil(green) == 1 and ceil(blue) == 1 then\n    return true\nend",
								}, -- [6]
								["n"] = 6,
							},
						},
						[22] = {
							["Type"] = "cooldown",
							["Name"] = "Rip",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1YYs1I2c_Meo",
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Operator"] = ">=",
									["Level"] = 5,
								}, -- [2]
								{
									["Type"] = "HEALTH_ABS",
									["Unit"] = "target",
									["Operator"] = ">=",
									["Name"] = "Cat Form",
									["Level"] = 500,
								}, -- [3]
								["n"] = 3,
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
							["Enabled"] = true,
						},
						[23] = {
							["Type"] = "cooldown",
							["Name"] = "Shred",
							["ManaCheck"] = true,
							["GUID"] = "TMW:icon:1YYv3MYeNeSM",
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
									["Type"] = "LUA",
									["Name"] = "local red, green, blue, alpha = RotationFrame4:GetBackdropColor()\n\nif ceil(red) == 0 and ceil(green) == 0 and ceil(blue) == 1 then\n    return true\nend",
								}, -- [4]
								["n"] = 4,
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
							["Enabled"] = true,
						},
						[24] = {
							["Type"] = "cooldown",
							["Name"] = "Rake",
							["Enabled"] = true,
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
									["Type"] = "COMBO",
									["Operator"] = "<",
									["Level"] = 5,
								}, -- [4]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Unit"] = "target",
									["Name"] = "Rake",
								}, -- [5]
								["n"] = 5,
							},
						},
						[41] = {
							["Type"] = "buff",
							["Name"] = "Mark of the Wild",
							["GUID"] = "TMW:icon:1YXd9eWHzTSH",
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
									["Type"] = "STANCE",
									["Name"] = "None",
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
						},
						[42] = {
							["Type"] = "buff",
							["Name"] = "Thorns",
							["GUID"] = "TMW:icon:1YXd9eWMwI0j",
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
									["Type"] = "STANCE",
									["Name"] = "None",
								}, -- [1]
								["n"] = 1,
							},
							["Enabled"] = true,
						},
					},
					["Name"] = "Druid Spells",
					["Alpha"] = 0,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1TWYPj24VzCn",
					["Scale"] = 1.5,
					["TextureName"] = "Details Flat",
					["Columns"] = 1,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Enabled"] = true,
						}, -- [1]
					},
					["Name"] = "Other",
					["Point"] = {
						["y"] = -20.00000522536274,
						["x"] = -229.9999934656047,
					},
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
								"TMW:icon:1TeVAjjavXC6", -- [1]
								"TMW:icon:1V6lsULwY3_Y", -- [2]
								"TMW:icon:1TeVAjjXQ0WB", -- [3]
								"TMW:icon:1YYv3MYeNeSM", -- [4]
								"TMW:icon:1YZamy7DqjiW", -- [5]
								"TMW:icon:1YYs1I2bCNGy", -- [6]
								"TMW:icon:1YYs1I2c_Meo", -- [7]
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
						}, -- [2]
					},
					["Name"] = "Rotation CENTER",
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
					["Columns"] = 1,
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1YXd9eWHzTSH", -- [1]
								"TMW:icon:1YXd9eWMwI0j", -- [2]
								"TMW:icon:1TeVAjjavXC6", -- [3]
								"TMW:icon:1V6lsULwY3_Y", -- [4]
								"TMW:icon:1TeVAjjXQ0WB", -- [5]
								"TMW:icon:1YYs1I2c_Meo", -- [6]
								"TMW:icon:1YYv3MYeNeSM", -- [7]
								"TMW:icon:1YZamy7DqjiW", -- [8]
								"TMW:icon:1YYs1I2bCNGy", -- [9]
							},
							["Enabled"] = true,
						}, -- [1]
						{
							["Type"] = "meta",
						}, -- [2]
					},
					["Name"] = "Rotation TOPLEFT",
					["GUID"] = "TMW:group:1YWtClNC=L8S",
				}, -- [4]
			},
			["Locked"] = true,
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
			["Locked"] = true,
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
					["Alpha"] = 0,
					["Point"] = {
						["y"] = -5,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Name"] = "Hunter Spells",
					["Scale"] = 1,
					["Columns"] = 20,
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
									["Level"] = 35,
									["Type"] = "LIBRANGECHECK",
									["Operator"] = "<=",
									["Unit"] = "target",
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
							["Name"] = "Hunter's Mark",
							["Enabled"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["States"] = {
								{
									["Alpha"] = 0,
								}, -- [1]
								{
									["Alpha"] = 0.15,
								}, -- [2]
							},
							["ShowTimerText"] = true,
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
							["Name"] = "Crystal Gaze",
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
							["ShowTimerText"] = true,
							["Unit"] = "pet",
						},
						[20] = {
							["GUID"] = "TMW:icon:1VjwkIsn7fZp",
							["Type"] = "buff",
							["Name"] = "Weakened Soul",
							["BuffOrDebuff"] = "HARMFUL",
							["Enabled"] = true,
							["ShowTimerText"] = true,
						},
					},
					["Locked"] = true,
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
			["Version"] = 91200,
			["NumGroups"] = 3,
		},
		["Moolatz - Golemagg"] = {
			["Version"] = 91200,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1XwcshcBUCEg",
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
		["Testxv - Golemagg"] = {
			["Locked"] = true,
			["Version"] = 86907,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1VWiCxYSqwKw",
				}, -- [1]
			},
		},
	},
}
