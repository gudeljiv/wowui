
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
},
{
["y"] = -2,
["x"] = -2,
["point"] = "TOPRIGHT",
["relativePoint"] = "TOPRIGHT",
},
["n"] = 2,
},
["StringName"] = "Binding/Label",
},
{
["Outline"] = "OUTLINE",
["Anchors"] = {
{
["y"] = 2,
["point"] = "BOTTOM",
["relativePoint"] = "TOP",
},
},
["DefaultText"] = "[Stacks:Hide(0)]",
["StringName"] = "Stacks",
},
{
["Outline"] = "OUTLINE",
["DefaultText"] = "[Duration:TMWFormatDuration]",
["StringName"] = "Duration",
},
["GUID"] = "TMW:textlayout:1YXC4srUja8k",
["Name"] = "STACKS & DURATION",
["n"] = 3,
},
["bar2"] = {
{
},
{
},
},
["TMW:textlayout:1Y9UVC8yK0C2"] = {
{
["DefaultText"] = "[PercentHP(unit=\"Pet\"):Percent:HPColor]  ",
["Justify"] = "RIGHT",
["Anchors"] = {
{
["point"] = "BOTTOMRIGHT",
["relativePoint"] = "BOTTOMRIGHT",
},
},
["Outline"] = "OUTLINE",
["StringName"] = "Number",
["ConstrainWidth"] = false,
["Size"] = 8,
},
["GUID"] = "TMW:textlayout:1Y9UVC8yK0C2",
["Name"] = "HPAbove",
},
["icon1"] = {
{
},
{
},
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
},
{
["y"] = -2,
["x"] = -2,
["point"] = "TOPRIGHT",
["relativePoint"] = "TOPRIGHT",
},
["n"] = 2,
},
["StringName"] = "Binding/Label",
},
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
},
},
["Size"] = 9,
},
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
},
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
["GUID"] = "TMW:group:1ceBNCTjBo0P",
["Scale"] = 1,
["Columns"] = 6,
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Type"] = "item",
["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838",
["OnlyInBags"] = true,
["Conditions"] = {
{
["Type"] = "HEALTH",
["Operator"] = "<=",
["Level"] = 35,
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1ZBi1G1Ik=8q",
["Enabled"] = true,
["CustomTex"] = "29203",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Type"] = "item",
["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
["OnlyInBags"] = true,
["Conditions"] = {
{
["Type"] = "HEALTH",
["Operator"] = "<=",
["Level"] = 60,
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1ZBi1G1LSN04",
["Enabled"] = true,
["CustomTex"] = "5720",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Name"] = "Global skills",
["Point"] = {
["y"] = -5,
["x"] = 400,
["point"] = "TOP",
["relativePoint"] = "TOP",
},
["Alpha"] = 0,
},
},
},
["Version"] = 110401,
["profileKeys"] = {
["Mxzq - Golemagg"] = "HUNTER",
["Battledog - Gehennas"] = "WARRIOR",
["Mxyz - Golemagg"] = "PRIEST",
["Vbank - Celebras"] = "WARRIOR",
["Dopesick - Stitches"] = "WARRIOR",
["Dopenac - Lone Wolf"] = "PRIEST",
["Battitude - Golemagg"] = "ROGUE",
["Dopecure - Stitches"] = "PRIEST",
["Dopemend - Lone Wolf"] = "PRIEST",
["Tandaram - Jin'do"] = "WARRIOR",
["Poklopac - Dreadnaught"] = "HUNTER",
["Dopesnare - Stitches"] = "HUNTER",
["Tudum - Ashbringer"] = "WARRIOR",
["Augustin - Golemagg"] = "MAGE",
["Tudum - Jin'do"] = "WARRIOR",
["Dopecoil - Lone Wolf"] = "SHAMAN",
["Vermin - Golemagg"] = "WARRIOR",
["Lonac - Stitches"] = "WARRIOR",
["Miqa - Golemagg"] = "PRIEST",
["Dopebolt - Lone Wolf"] = "MAGE",
["Moolatz - Dreadnaught"] = "DRUID",
["Handrmandr - Golemagg"] = "WARRIOR",
["Vermina - Golemagg"] = "PALADIN",
["Jutarnjedrvo - Lone Wolf"] = "SHAMAN",
["Doperage - Lone Wolf"] = "WARRIOR",
["Tadibey - Golemagg"] = "SHAMAN",
["Dopede - Stitches"] = "SHAMAN",
["Mxyzptlk - Golemagg"] = "WARLOCK",
["Kaonac - Jin'do"] = "PRIEST",
["Moolatz - Golemagg"] = "DRUID",
["Vermin - Zandalar Tribe"] = "WARRIOR",
["Dopedot - Lone Wolf"] = "WARLOCK",
["Dopetrap - Lone Wolf"] = "HUNTER",
["Battitude - Zandalar Tribe"] = "ROGUE",
["Dopeclaw - Lone Wolf"] = "DRUID",
["Vermins - Stitches"] = "WARRIOR",
["Wells - Jin'do"] = "DRUID",
["Vermin - Celebras"] = "WARRIOR",
["Battlearm - Gehennas"] = "WARRIOR",
["Battlenac - Zandalar Tribe"] = "PRIEST",
["Pitchwise - Ashbringer"] = "SHAMAN",
["Provokator - Jin'do"] = "HUNTER",
["Dopesnare - Lone Wolf"] = "HUNTER",
["Battlearm - Golemagg"] = "DEATHKNIGHT",
["Poklopac - Mirage Raceway"] = "HUNTER",
["Dopestab - Lone Wolf"] = "ROGUE",
["Dopeah - Stitches"] = "SHAMAN",
["Dopeclaw - Stitches"] = "DRUID",
["Battlenac - Celebras"] = "PRIEST",
["Mq - Celebras"] = "HUNTER",
},
["profiles"] = {
["Dopeclaw - Lone Wolf"] = {
["Version"] = 102000,
},
["WARRIOR"] = {
["Version"] = 110401,
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
["Rows"] = 3,
["Alpha"] = 0,
["Name"] = "SPELLS",
["Locked"] = true,
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
},
{
["PrtsBefore"] = 1,
["Type"] = "LUA",
["Name"] = "xAOE(8) == 1",
},
{
["Type"] = "LEVEL",
["Level"] = 20,
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = "<",
},
{
["PrtsBefore"] = 1,
["Type"] = "RAGE_ABS",
["Level"] = 45,
["Operator"] = ">",
},
{
["Type"] = "RAGE_ABS",
["PrtsBefore"] = 1,
["AndOr"] = "OR",
["Level"] = 45,
["Operator"] = ">",
},
{
["Type"] = "LUA",
["PrtsAfter"] = 1,
["Name"] = "xTTD < 20",
},
{
["Type"] = "LEVEL",
["AndOr"] = "OR",
["Level"] = 30,
["PrtsAfter"] = 1,
["Operator"] = "<=",
},
["n"] = 7,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["PrtsBefore"] = 3,
["Type"] = "LEVEL",
["Level"] = 20,
["Operator"] = ">=",
},
{
["Level"] = 45,
["Type"] = "RAGE_ABS",
["PrtsAfter"] = 1,
["Operator"] = ">",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Sweeping Strikes",
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = "~=",
},
{
["Type"] = "LEVEL",
["AndOr"] = "OR",
["Level"] = 30,
["PrtsAfter"] = 1,
["Operator"] = "<=",
},
{
["Name"] = "xAOE(8) > 1",
["Type"] = "LUA",
},
["n"] = 6,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
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
},
{
["AndOr"] = "OR",
["Type"] = "BUFFDUR",
["Name"] = "Battle Shout",
["Operator"] = "<=",
},
["n"] = 2,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
},
{
["Color"] = "ffffffff",
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["BuffOrDebuff"] = "HARMFUL",
["Unit"] = "target",
["Name"] = "Demoralizing Shout",
["Enabled"] = true,
["Conditions"] = {
{
["Name"] = "Defensive Stance; Berserker Stance; Battle Stance",
["Type"] = "STANCE",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Demoralizing Shout",
["Unit"] = "target",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Demoralizing Roar",
["Unit"] = "target",
},
{
["Name"] = "xInRange(2) and xTTD > 6 and xAOE(8) > 1",
["Type"] = "LUA",
},
{
["Name"] = "Sweeping Strikes",
["Type"] = "BUFFDUR",
},
["n"] = 5,
},
["GUID"] = "TMW:icon:1TWZdpV26rm5",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Commanding Shout",
["SettingsPerView"] = {
["icon"] = {
["TextLayout"] = "icon1",
},
},
["GUID"] = "TMW:icon:1c3jX2rNsAGN",
["Conditions"] = {
{
["Name"] = "Commanding Shout",
["Type"] = "BUFFDUR",
},
{
["AndOr"] = "OR",
["Type"] = "BUFFDUR",
["Name"] = "Commanding Shout",
["Operator"] = "<=",
},
["n"] = 2,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
},
{
["Color"] = "ffffffff",
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1TU=hLnlwyeY",
["Type"] = "cooldown",
["ShowTimerText"] = true,
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "REACTIVE",
["Checked"] = true,
["Name"] = "Overpower",
},
["n"] = 1,
},
["Name"] = "Overpower",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Whirlwind",
["Enabled"] = true,
["Conditions"] = {
{
["Name"] = "Berserker Stance",
["Type"] = "STANCE",
},
{
["Name"] = "xInRange(2)",
["Type"] = "LUA",
},
{
["Level"] = 1.5,
["Type"] = "SPELLCD",
["Name"] = "Whirlwind",
["Operator"] = "<=",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1Xwc=6KNp27d",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Color"] = "ffffffff",
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1TYYu4EDbfSz",
["Type"] = "cooldown",
["BuffOrDebuff"] = "HARMFUL",
["Unit"] = "target",
["HideIfNoUnits"] = true,
["Name"] = "Sunder Armor",
["SettingsPerView"] = {
["icon"] = {
["Texts"] = {
"",
"[Stacks:Hide(0)]",
},
},
},
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "DEBUFFSTACKS",
["Name"] = "Sunder Armor",
["PrtsBefore"] = 3,
["Level"] = 5,
["Unit"] = "target",
["Operator"] = "<",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Sunder Armor",
["AndOr"] = "OR",
["Operator"] = "<",
["Level"] = 7,
["PrtsAfter"] = 1,
["Unit"] = "target",
},
{
["Type"] = "LUA",
["Name"] = "xTTD > 20",
["Unit"] = "target",
["Level"] = 60,
["PrtsAfter"] = 1,
["Operator"] = ">",
},
{
["Type"] = "DEBUFFSTACKS",
["Name"] = "Sunder Armor",
["AndOr"] = "OR",
["Level"] = 1,
["Operator"] = "<",
["Unit"] = "target",
},
{
["Type"] = "RAGE",
["Level"] = 77,
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = ">",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Expose Armor",
["Unit"] = "target",
},
{
["Name"] = "not xImmune(\"Sunder Armor\")",
["Type"] = "LUA",
},
{
["Name"] = "xAOE(8) < 2",
["Type"] = "LUA",
},
["n"] = 8,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 1,
},
},
},
{
["GUID"] = "TMW:icon:1byi=FOzUEvn",
["Type"] = "cooldown",
["BuffOrDebuff"] = "HARMFUL",
["Unit"] = "target",
["Conditions"] = {
{
["Name"] = "Defensive Stance",
["Type"] = "STANCE",
},
{
["Name"] = "IsSpellKnownOrOverridesKnown(403195) and not xImmune(\"Sunder Armor\")",
["Type"] = "LUA",
},
{
["Name"] = "xAOE(8) < 2",
["Type"] = "LUA",
},
{
["Type"] = "RAGE",
["Level"] = 21,
["Operator"] = ">=",
},
{
["PrtsBefore"] = 1,
["Type"] = "LUA",
["Name"] = "xAOE(8) > 1",
["AndOr"] = "OR",
},
{
["Level"] = 50,
["Type"] = "RAGE",
["PrtsAfter"] = 1,
["Operator"] = ">=",
},
["n"] = 6,
},
["Name"] = "Sunder Armor",
["SettingsPerView"] = {
["icon"] = {
["Texts"] = {
"",
"[Stacks:Hide(0)]",
},
},
},
["RangeCheck"] = true,
["HideIfNoUnits"] = true,
["Enabled"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 1,
},
},
},
{
["Enabled"] = true,
["Type"] = "reactive",
["Name"] = "Execute",
["RangeCheck"] = true,
["IgnoreNomana"] = true,
["GUID"] = "TMW:icon:1TZvNvflXM0_",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["AndOr"] = "OR",
["Type"] = "STANCE",
["PrtsAfter"] = 1,
["Name"] = "Battle Stance; Berserker Stance",
},
{
["Level"] = 1,
["Type"] = "SPEC",
},
["n"] = 3,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "SPEC",
["Name"] = "DPS",
["Level"] = 2,
},
{
["Level"] = 20,
["Type"] = "HEALTH",
["Unit"] = "target",
["Operator"] = ">",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1ZQcfScLCzCQ",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Recklessness",
["Conditions"] = {
{
["Name"] = "Berserker Stance",
["Type"] = "STANCE",
},
{
["PrtsBefore"] = 1,
["Type"] = "BUFFDUR",
["Name"] = "Bloodlust",
["Operator"] = "~=",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Sated",
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = "~=",
},
{
["Type"] = "LEVEL",
["Level"] = -1,
["Unit"] = "target",
},
["n"] = 4,
},
["GUID"] = "TMW:icon:1ZYr3kQJ=Fa1",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Death Wish",
["Conditions"] = {
{
["Name"] = "Berserker Stance",
["Type"] = "STANCE",
},
{
["PrtsBefore"] = 1,
["Type"] = "BUFFDUR",
["Name"] = "Bloodlust",
["Operator"] = "~=",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Sated",
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = "~=",
},
{
["Type"] = "LEVEL",
["Level"] = -1,
["Unit"] = "target",
},
["n"] = 4,
},
["GUID"] = "TMW:icon:1ZYr3kQXDQKM",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Blood Fury",
["Conditions"] = {
{
["Level"] = 2,
["Type"] = "SPEC",
},
{
["PrtsBefore"] = 1,
["Type"] = "BUFFDUR",
["Name"] = "Bloodlust",
["Operator"] = "~=",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Sated",
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = "~=",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1ZYr3kQhGs06",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Sweeping Strikes",
["Conditions"] = {
{
["Name"] = "Battle Stance",
["Type"] = "STANCE",
},
{
["Name"] = "Sweeping Strikes",
["Type"] = "BUFFDUR",
},
{
["Level"] = 2,
["Type"] = "SPELLCD",
["Name"] = "Sweeping Strikes",
["Operator"] = "<=",
},
{
["Name"] = "xAOE(10) > 1",
["Type"] = "LUA",
},
["n"] = 4,
},
["GUID"] = "TMW:icon:1YO55KEUKaW4",
["States"] = {
{
},
{
["Alpha"] = 1,
},
{
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
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
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Thunder Clap",
["Level"] = 2,
["Operator"] = "<=",
["Unit"] = "target",
},
{
["Name"] = "Sweeping Strikes",
["Type"] = "BUFFDUR",
},
{
["Name"] = "xAOE(10) > 2",
["Type"] = "LUA",
},
{
["Type"] = "LUA",
["PrtsAfter"] = 1,
["Name"] = "xInRange(5)",
},
{
["PrtsBefore"] = 1,
["Type"] = "LUA",
["Name"] = "xAOE(10) > 3",
["AndOr"] = "OR",
},
{
["Type"] = "STANCE",
["PrtsAfter"] = 1,
["Name"] = "Battle Stance",
},
{
["PrtsBefore"] = 1,
["Type"] = "LUA",
["Name"] = "IsSpellKnownOrOverridesKnown(403219) and xInRange(5)",
["AndOr"] = "OR",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Thunder Clap",
["Level"] = 1.4,
["Unit"] = "target",
["Operator"] = "<=",
},
{
["PrtsAfter"] = 1,
},
["n"] = 10,
},
["GUID"] = "TMW:icon:1YWHZ7T27TKe",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1TWYMfcUzmi6",
["Type"] = "cooldown",
["Name"] = "Hamstring",
["Enabled"] = true,
["BuffOrDebuff"] = "HARMFUL",
["Conditions"] = {
{
["PrtsBefore"] = 1,
["Type"] = "ISPLAYER",
["Level"] = 1,
["Unit"] = "target",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Hamstring",
["Unit"] = "target",
},
{
["Name"] = "Battle Stance; Berserker Stance",
["Type"] = "STANCE",
},
{
["Level"] = 64,
["Type"] = "SPEED",
["Unit"] = "target",
["Operator"] = ">",
},
{
["Type"] = "INSTANCE2",
["PrtsAfter"] = 1,
["BitFlags"] = 7,
},
{
["Type"] = "LUA",
["Name"] = "xMHWF()",
["PrtsBefore"] = 1,
["AndOr"] = "OR",
["Operator"] = "~=",
},
{
["Level"] = 30,
["Type"] = "RAGE",
["PrtsAfter"] = 1,
["Operator"] = ">=",
},
["n"] = 7,
},
["RangeCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Name"] = "Defensive Stance",
["Type"] = "STANCE",
},
["n"] = 2,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1Z55tRw68qC=",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1Z55tRw8OaCM",
["Type"] = "cooldown",
["Name"] = "Shield Block",
["Enabled"] = true,
["Conditions"] = {
{
["Name"] = "Defensive Stance",
["Type"] = "STANCE",
},
{
["Name"] = "IsEquippedItemType(\"Shields\")",
["Type"] = "LUA",
},
["n"] = 2,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
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
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1Z55tRwA_pKn",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Name"] = "Shield Bash",
["Type"] = "SPELLCD",
["PrtsAfter"] = 1,
["Operator"] = "~=",
},
{
["PrtsBefore"] = 1,
["Type"] = "STANCE",
["Name"] = "Berserker Stance",
["AndOr"] = "OR",
},
{
["Name"] = "Pummel",
["Type"] = "SPELLCD",
["PrtsAfter"] = 1,
["Operator"] = "~=",
},
{
["PrtsBefore"] = 1,
["Type"] = "STANCE",
["Name"] = "Battle Stance",
["AndOr"] = "OR",
},
{
["Name"] = "IsEquippedItemType(\"Shields\")",
["Type"] = "LUA",
},
{
["Name"] = "Shield Bash",
["Type"] = "SPELLCD",
["PrtsAfter"] = 2,
["Operator"] = "~=",
},
{
["Type"] = "LUA",
["PrtsAfter"] = 1,
["Name"] = "xUnitCasting(\"target\")",
},
{
["PrtsBefore"] = 1,
["Type"] = "ISPLAYER",
["AndOr"] = "OR",
["Unit"] = "target",
},
{
["Level"] = 1,
["Type"] = "REACT",
["PrtsAfter"] = 1,
["Unit"] = "target",
},
{
["Type"] = "BUFFDUR",
["PrtsAfter"] = 1,
["Name"] = "Spell Reflection",
},
{
["AndOr"] = "OR",
["Type"] = "LUA",
["PrtsAfter"] = 1,
["Name"] = "xUnitCasting(\"target\")",
},
{
["Level"] = 1,
["Type"] = "SPEC",
},
["n"] = 13,
},
["GUID"] = "TMW:icon:1Z679nrqAgG4",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Name"] = "Defensive Stance",
["Type"] = "STANCE",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1Z7PEaKwPKnX",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
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
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1YEqZQbYmmFD",
["States"] = {
{
},
{
["Alpha"] = 1,
},
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1TQv_LtTwAae",
["Type"] = "cooldown",
["BuffOrDebuff"] = "HARMFUL",
["Unit"] = "target",
["OnlyMine"] = true,
["Name"] = "Rend",
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["AndOr"] = "OR",
["Name"] = "Rend",
["Level"] = 0.6,
["Operator"] = "<=",
["Unit"] = "target",
},
{
["PrtsBefore"] = 1,
["Type"] = "STANCE",
["Name"] = "Defensive Stance; Battle Stance",
},
{
["PrtsBefore"] = 1,
["Type"] = "STANCE",
["Name"] = "Berserker Stance",
["AndOr"] = "OR",
},
{
["Type"] = "LUA",
["PrtsAfter"] = 2,
["Name"] = "IsSpellKnownOrOverridesKnown(412507)",
},
{
["Level"] = 1,
["Type"] = "LUA",
["Name"] = "not xImmune(\"Rend\")",
["Unit"] = "target",
},
{
["Name"] = "xTTD > 8 or xTTD < 0",
["Type"] = "LUA",
},
["n"] = 6,
},
["RangeCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 1,
},
},
},
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
},
{
["Type"] = "CLASS2",
["BitFlags"] = 43,
["Unit"] = "target",
},
{
["Type"] = "STANCE",
["PrtsAfter"] = 1,
["Name"] = "Defensive Stance",
},
{
["AndOr"] = "OR",
["Type"] = "NAME",
["Name"] = "Lord Crispin Ference",
["Unit"] = "target",
},
["n"] = 4,
},
["GUID"] = "TMW:icon:1Z9CIRRFbqSA",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["ManaCheck"] = true,
["Type"] = "buff",
["Name"] = "Feared; Sap; Incapacitated; Bellowing Roar; Frightening Shout",
["Enabled"] = true,
["BuffOrDebuff"] = "HARMFUL",
["GUID"] = "TMW:icon:1Z7R_6NwuWuK",
["CustomTex"] = "18499",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Bloodrage",
["Conditions"] = {
{
["Type"] = "RAGE",
["Level"] = 50,
["Operator"] = "<",
},
{
["Type"] = "LUA",
["Name"] = "select(2,UnitPowerType(\"target\")) ~= \"MANA\"",
["Level"] = 10,
["Operator"] = ">",
["Unit"] = "target",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1ZsiQTrMcI1p",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Columns"] = 20,
["OnlyInCombat"] = true,
},
{
["GUID"] = "TMW:group:1TWYSTcQ410f",
["Point"] = {
["y"] = -95,
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
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1TZvNvgAkfmq",
["Type"] = "buff",
["ShowTimerText"] = true,
["SettingsPerView"] = {
["icon"] = {
["TextLayout"] = "TMW:textlayout:1TZve345g=GK",
},
},
["Name"] = "Enrage",
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1Xx3hMFQR0cV",
["Type"] = "buff",
["ShowTimerText"] = true,
["BuffOrDebuff"] = "HARMFUL",
["Name"] = "Recently Bandaged",
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Berserker Rage",
["RangeCheck"] = true,
["Conditions"] = {
{
["Level"] = 58,
["Type"] = "HEALTH",
["Name"] = "IsUsableSpell(\"Victory Rush\")",
["Operator"] = "<=",
},
{
["Name"] = "Bloodrage",
["Type"] = "BUFFDUR",
},
{
["Level"] = 3,
["Type"] = "SPELLCD",
["Name"] = "Enraged Regeneration",
["Operator"] = "<=",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1cg9VrgNGDm8",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Enraged Regeneration",
["RangeCheck"] = true,
["Conditions"] = {
{
["Level"] = 58,
["Type"] = "HEALTH",
["Name"] = "IsUsableSpell(\"Victory Rush\")",
["Operator"] = "<=",
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1cg9VrgO9=ed",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Quick Strike",
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "IsUsableSpell(\"Quick Strike\")",
["Type"] = "LUA",
},
{
["Level"] = 40,
["Type"] = "RAGE",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1bUScRbv99y1",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Victory Rush",
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "IsUsableSpell(\"Victory Rush\")",
["Type"] = "LUA",
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1bT8WARkiJ4z",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "buff",
["Name"] = "Poison",
["BuffOrDebuff"] = "HARMFUL",
["GUID"] = "TMW:icon:1bDy0FdwZICj",
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["TextureName"] = "Details Flat",
["Name"] = "GENERAL",
["Locked"] = true,
["Alpha"] = 0,
["Columns"] = 20,
["OnlyInCombat"] = true,
},
{
["GUID"] = "TMW:group:1TWYPj24VzCn",
["Columns"] = 1,
["Scale"] = 1.2,
["Icons"] = {
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1TZvNvgAkfmq",
"TMW:icon:1bDy0FdwZICj",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1TWYSTcSCl0z",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["TextureName"] = "Details Flat",
["Name"] = "OTHER PORTRAIT",
["Alpha"] = 0,
["Point"] = {
["y"] = -40.13746148713035,
["x"] = -287.8838390485849,
},
["OnlyInCombat"] = true,
},
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
"TMW:icon:1ZBi1G1Ik=8q",
"TMW:icon:1ZBi1G1LSN04",
"TMW:icon:1Z7R_6NwuWuK",
"TMW:icon:1cg9VrgNGDm8",
"TMW:icon:1cg9VrgO9=ed",
"TMW:icon:1YO55KEUKaW4",
"TMW:icon:1bT8WARkiJ4z",
"TMW:icon:1TU=hLnlwyeY",
"TMW:icon:1TWYMfcUzmi6",
"TMW:icon:1TQv_Ltf40Wl",
"TMW:icon:1c3jX2rNsAGN",
"TMW:icon:1TWZdpV26rm5",
"TMW:icon:1YWHZ7T27TKe",
"TMW:icon:1TQv_LtTwAae",
"TMW:icon:1TYYu4EDbfSz",
"TMW:icon:1TZvNvflXM0_",
"TMW:icon:1Z55tRwA_pKn",
"TMW:icon:1Xwc=6KNp27d",
"TMW:icon:1YEqZQbYmmFD",
"TMW:icon:1Xrn34GriOqy",
"TMW:icon:1XzwOSGxkHLD",
"TMW:icon:1byi=FOzUEvn",
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
},
{
["Unit"] = "target",
["Type"] = "EXISTS",
},
{
["Unit"] = "target",
["Type"] = "ALIVE",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
["n"] = 4,
},
["States"] = {
{
["Alpha"] = 0,
},
{
["Alpha"] = 1,
},
{
},
{
},
},
},
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
},
["n"] = 1,
},
["States"] = {
{
["Alpha"] = 0,
},
{
["Alpha"] = 1,
},
{
},
{
},
[100] = {
["Alpha"] = 1,
},
},
},
},
["Alpha"] = 0,
["TextureName"] = "Details Flat",
["LayoutDirection"] = 2,
["SortPriorities"] = {
{
["Order"] = -1,
},
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
},
["n"] = 1,
},
["Columns"] = 1,
["OnlyInCombat"] = true,
},
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
"TMW:icon:1ZBi1G1Ik=8q",
"TMW:icon:1ZBi1G1LSN04",
"TMW:icon:1Z7R_6NwuWuK",
"TMW:icon:1cg9VrgNGDm8",
"TMW:icon:1cg9VrgO9=ed",
"TMW:icon:1YO55KEUKaW4",
"TMW:icon:1bT8WARkiJ4z",
"TMW:icon:1TU=hLnlwyeY",
"TMW:icon:1TWYMfcUzmi6",
"TMW:icon:1TQv_Ltf40Wl",
"TMW:icon:1c3jX2rNsAGN",
"TMW:icon:1TWZdpV26rm5",
"TMW:icon:1YWHZ7T27TKe",
"TMW:icon:1TQv_LtTwAae",
"TMW:icon:1TYYu4EDbfSz",
"TMW:icon:1TZvNvflXM0_",
"TMW:icon:1Z55tRwA_pKn",
"TMW:icon:1Xwc=6KNp27d",
"TMW:icon:1YEqZQbYmmFD",
"TMW:icon:1Xrn34GriOqy",
"TMW:icon:1XzwOSGxkHLD",
"TMW:icon:1byi=FOzUEvn",
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
},
{
["Unit"] = "target",
["Type"] = "EXISTS",
},
{
["Unit"] = "target",
["Type"] = "ALIVE",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
["n"] = 4,
},
["States"] = {
{
["Alpha"] = 0,
},
{
["Alpha"] = 1,
},
{
},
{
},
},
},
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
},
["n"] = 1,
},
["States"] = {
{
["Alpha"] = 0,
},
{
["Alpha"] = 1,
},
{
},
{
},
[100] = {
["Alpha"] = 1,
},
},
},
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
},
},
["Columns"] = 1,
["OnlyInCombat"] = true,
},
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
},
{
["Unit"] = "target",
["Type"] = "EXISTS",
},
{
["Unit"] = "target",
["Type"] = "ALIVE",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
["n"] = 4,
},
["Icons"] = {
"TMW:icon:1TQv_Lti1RyX",
"TMW:icon:1Y2=7t59vfSn",
"TMW:icon:1ZYr3kQhGs06",
"TMW:icon:1Z7PEaKwPKnX",
"TMW:icon:1Z55tRw68qC=",
"TMW:icon:1ZsiQTrMcI1p",
"TMW:icon:1Z55tRw8OaCM",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["OnlyInCombat"] = true,
},
{
["View"] = "bar",
["Point"] = {
["y"] = 180,
["x"] = -0.0002386160893276733,
},
["Scale"] = 2.4,
["Icons"] = {
{
["Type"] = "luavalue",
["LuaCode"] = "IsUsableSpell(\"Victory Rush\")",
["SettingsPerView"] = {
["bar"] = {
["Texts"] = {
"[(Value / ValueMax * 100):Round:Percent]",
"[Value:Short \"/\" ValueMax:Short]",
},
},
},
["CustomTex"] = "Victory Rush",
["Icons"] = {
"TMW:icon:1bT8WARkiJ4z",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["TextureName"] = "xVerminClean",
["Name"] = "Victory Rush",
["SettingsPerView"] = {
["icon"] = {
["TextLayout"] = "TMW:textlayout:1YXC4srUja8k",
["BorderColor"] = "00000000",
},
["bar"] = {
["SizeX"] = 200,
},
},
["Locked"] = true,
["GUID"] = "TMW:group:1ZM=EKbLryuK",
["Columns"] = 1,
},
},
["NumGroups"] = 7,
["TextureName"] = "xVerminClean",
},
["ROGUE"] = {
["Locked"] = true,
["NumGroups"] = 5,
["Version"] = 110401,
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
["Name"] = "Sinister Strike",
["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "COMBO",
["Level"] = 5,
["Operator"] = "<=",
},
{
["Name"] = "not IsSpellKnownOrOverridesKnown(424785) and not IsSpellKnownOrOverridesKnown(399956)",
["Type"] = "LUA",
},
["n"] = 2,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1cer6m0=J70m",
["Type"] = "cooldown",
["Name"] = "Mutilate",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "COMBO",
["Level"] = 5,
["Operator"] = "<=",
},
{
["Name"] = "IsSpellKnownOrOverridesKnown(399956)",
["Type"] = "LUA",
},
["n"] = 2,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1cer6m0_Lhyb",
["Type"] = "cooldown",
["Name"] = "Saber Slash",
["ManaCheck"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "COMBO",
["Level"] = 5,
["Operator"] = "<=",
},
{
["Name"] = "IsSpellKnownOrOverridesKnown(424785)",
["Type"] = "LUA",
},
["n"] = 2,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Backstab",
["GUID"] = "TMW:icon:1ceynOOtaPeT",
["RangeCheck"] = true,
["Conditions"] = {
{
["PrtsBefore"] = 1,
["Type"] = "COMBO",
["Level"] = 5,
["Operator"] = "<=",
},
{
["Type"] = "LUA",
["PrtsAfter"] = 1,
["Name"] = "not IsSpellKnownOrOverridesKnown(424785) and not IsSpellKnownOrOverridesKnown(399956)",
},
{
["Type"] = "LUA",
["Name"] = "xTTD <= 30 and not IsSpellKnownOrOverridesKnown(424785) and not IsSpellKnownOrOverridesKnown(399956)",
["PrtsBefore"] = 1,
["AndOr"] = "OR",
["PrtsAfter"] = 1,
},
["n"] = 3,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Ambush",
["GUID"] = "TMW:icon:1cey=nVUgRO_",
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "BUFFDUR",
["Name"] = "Cutthroat",
["Operator"] = "~=",
},
{
["Type"] = "BUFFDUR",
["AndOr"] = "OR",
["Name"] = "Stealth",
["Operator"] = "~=",
},
["n"] = 2,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1cfYnjeGODKP",
["OnlyMine"] = true,
["Name"] = "Expose Armor",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "COMBO",
["Level"] = 2,
["Operator"] = ">=",
},
{
["Name"] = "not _G.UnitCastingInteruptible",
["Type"] = "LUA",
},
{
["Name"] = "IsSpellKnownOrOverridesKnown(8650)",
["Type"] = "LUA",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Expose Armor",
["Level"] = 2.5,
["Operator"] = "<=",
["Unit"] = "target",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Sunder Armor",
["Unit"] = "target",
},
["n"] = 5,
},
["Type"] = "cooldown",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1cey=nVdK_ap",
["OnlyMine"] = true,
["Name"] = "Between the Eyes",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "COMBO",
["Level"] = 4,
["Operator"] = ">=",
},
{
["Name"] = "not _G.UnitCastingInteruptible",
["Type"] = "LUA",
},
{
["PrtsBefore"] = 1,
["Type"] = "BUFFDUR",
["Name"] = "Slice and Dice",
["Operator"] = "~=",
},
{
["Name"] = "xTTD <= 30",
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Type"] = "LUA",
},
{
["Name"] = "IsSpellKnownOrOverridesKnown(400009)",
["Type"] = "LUA",
},
{
["Name"] = "xGetRange() >= 5",
["Type"] = "LUA",
},
["n"] = 6,
},
["Type"] = "cooldown",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1bdJCdXiCTSJ",
["OnlyMine"] = true,
["Name"] = "Slice and Dice",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "COMBO",
["Level"] = 1,
["Operator"] = ">=",
},
{
["Type"] = "BUFFDUR",
["Level"] = 4.9,
["Name"] = "Slice and Dice",
["Operator"] = "<=",
},
{
["Name"] = "not _G.UnitCastingInteruptible and xTTD > 40",
["Type"] = "LUA",
},
["n"] = 3,
},
["Type"] = "cooldown",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1TeVAjjavXC6",
["OnlyMine"] = true,
["Name"] = "Eviscerate",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "COMBO",
["Level"] = 4,
["Operator"] = ">=",
},
{
["Name"] = "not _G.UnitCastingInteruptible",
["Type"] = "LUA",
},
{
["PrtsBefore"] = 1,
["Type"] = "BUFFDUR",
["Name"] = "Slice and Dice",
["Operator"] = "~=",
},
{
["Name"] = "xTTD <= 30",
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Type"] = "LUA",
},
{
["Name"] = "IsSpellKnownOrOverridesKnown(424785) or IsSpellKnownOrOverridesKnown(399956)",
["Type"] = "LUA",
},
["n"] = 5,
},
["Type"] = "cooldown",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1cer6m1AqtWi",
["OnlyMine"] = true,
["Name"] = "Envenom",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "COMBO",
["Level"] = 4,
["Operator"] = ">=",
},
{
["Name"] = "not _G.UnitCastingInteruptible",
["Type"] = "LUA",
},
{
["PrtsBefore"] = 1,
["Type"] = "BUFFDUR",
["Name"] = "Slice and Dice",
["Operator"] = "~=",
},
{
["Name"] = "xTTD <= 30",
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Type"] = "LUA",
},
{
["Name"] = "IsSpellKnownOrOverridesKnown(399963)",
["Type"] = "LUA",
},
{
["Type"] = "DEBUFFSTACKS",
["Name"] = "Deadly Poison",
["Level"] = 4,
["Operator"] = ">=",
["Unit"] = "target",
},
["n"] = 6,
},
["Type"] = "cooldown",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["OnlyMine"] = true,
["Name"] = "Rupture",
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "COMBO",
["Level"] = 4,
["Operator"] = ">=",
},
{
["Name"] = "not _G.UnitCastingInteruptible",
["Type"] = "LUA",
},
{
["PrtsBefore"] = 1,
["Type"] = "BUFFDUR",
["Name"] = "Slice and Dice",
["Operator"] = "~=",
},
{
["Name"] = "xTTD <= 30",
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Type"] = "LUA",
},
{
["Name"] = "IsSpellKnownOrOverridesKnown(424785) or IsSpellKnownOrOverridesKnown(399956)",
["Type"] = "LUA",
},
["n"] = 5,
},
["Type"] = "cooldown",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Gouge",
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "_G.UnitCastingInteruptible and select(2, GetSpellCooldown('Kick')) ~= 0",
["Type"] = "LUA",
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1bdJCdXvpC0O",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1bfjTFwseiek",
["Type"] = "cooldown",
["Name"] = "Riposte",
["ManaCheck"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Riposte",
["Type"] = "REACTIVE",
},
["n"] = 1,
},
["Enabled"] = true,
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1bzTh96gkXSt",
["Type"] = "cooldown",
["Name"] = "Blade Flurry",
["Conditions"] = {
{
["Name"] = "xAOE(10) > 1",
["Type"] = "LUA",
},
["n"] = 1,
},
["Enabled"] = true,
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Name"] = "Rogue Spells",
["Locked"] = true,
["Columns"] = 20,
["Alpha"] = 0,
},
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
},
nil,
{
},
{
},
},
},
},
["TextureName"] = "Details Flat",
},
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
},
{
["Type"] = "ALIVE",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
{
["Type"] = "MOUNTED",
["Level"] = 1,
},
["n"] = 4,
},
["Icons"] = {
"TMW:icon:1ZBi1G1LSN04",
"TMW:icon:1ZBi1G1Ik=8q",
"TMW:icon:1cfYnjeGODKP",
"TMW:icon:1cey=nVUgRO_",
"TMW:icon:1ceynOOtaPeT",
"TMW:icon:1bdJCdXiCTSJ",
"TMW:icon:1cer6m1AqtWi",
"TMW:icon:1cey=nVdK_ap",
"TMW:icon:1TeVAjjavXC6",
"TMW:icon:1cer6m0=J70m",
"TMW:icon:1cer6m0_Lhyb",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1YXd9eWHzTSH",
"TMW:icon:1YXd9eWMwI0j",
"TMW:icon:1V6noP8ARoel",
"TMW:icon:1V6lsULwY3_Y",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["OnlyInCombat"] = true,
},
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
},
{
["Type"] = "ALIVE",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
{
["Type"] = "MOUNTED",
["Level"] = 1,
},
["n"] = 4,
},
["Icons"] = {
"TMW:icon:1ZBi1G1LSN04",
"TMW:icon:1ZBi1G1Ik=8q",
"TMW:icon:1cfYnjeGODKP",
"TMW:icon:1cey=nVUgRO_",
"TMW:icon:1ceynOOtaPeT",
"TMW:icon:1bdJCdXiCTSJ",
"TMW:icon:1cer6m1AqtWi",
"TMW:icon:1cey=nVdK_ap",
"TMW:icon:1TeVAjjavXC6",
"TMW:icon:1cer6m0=J70m",
"TMW:icon:1cer6m0_Lhyb",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Type"] = "meta",
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["OnlyInCombat"] = true,
},
{
["GUID"] = "TMW:group:1ZThAKUg1Y0w",
["Columns"] = 1,
["Locked"] = true,
["Scale"] = 0.4,
["Name"] = "Rotation OFFGCD",
["Icons"] = {
{
["Enabled"] = true,
["Type"] = "meta",
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Point"] = {
["y"] = -9.187387125994171e-05,
["x"] = 30,
["point"] = "TOPLEFT",
["relativePoint"] = "TOPLEFT",
},
},
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
["Type"] = "buff",
["Name"] = "Dampen Magic",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1TQv_Ltf40Wl",
["Type"] = "buff",
["Name"] = "Mana Shield",
["ShowTimerText"] = true,
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1TQv_Lti1RyX",
["Type"] = "cooldown",
["ShowTimerText"] = true,
["Name"] = "Frost Nova",
["CooldownCheck"] = true,
["Enabled"] = true,
["States"] = {
{
["Alpha"] = 0,
},
{
["Alpha"] = 1,
},
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1TU=hLnlwyeY",
["Type"] = "cooldown",
["ShowTimerText"] = true,
["Name"] = "Blink",
["Enabled"] = true,
["States"] = {
{
["Alpha"] = 0,
},
{
["Alpha"] = 1,
},
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "buff",
["Name"] = "Demoralizing Shout",
["States"] = {
{
["Alpha"] = 0,
},
{
["Alpha"] = 1,
},
{
},
{
},
},
["BuffOrDebuff"] = "HARMFUL",
["Conditions"] = {
{
["Name"] = "Defensive Stance",
["Type"] = "STANCE",
},
{
["Type"] = "RAGE_ABS",
["Level"] = 10,
["Operator"] = ">=",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1TWZdpV26rm5",
["Unit"] = "target",
},
{
["GUID"] = "TMW:icon:1TYYu4EDbfSz",
["Type"] = "buff",
["Name"] = "Sunder Armor",
["States"] = {
{
},
nil,
{
},
{
},
},
["BuffOrDebuff"] = "HARMFUL",
["Enabled"] = true,
["ShowTimerText"] = true,
["Unit"] = "target",
},
{
["Enabled"] = true,
["Type"] = "reactive",
["Name"] = "Execute",
["Conditions"] = {
{
["Type"] = "RAGE_ABS",
["Level"] = 15,
["Operator"] = ">=",
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1TZvNvflXM0_",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["BuffOrDebuff"] = "HARMFUL",
["GUID"] = "TMW:icon:1TWYMfcUzmi6",
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Locked"] = true,
["Columns"] = 20,
["Alpha"] = 0,
["Scale"] = 1,
},
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
["ShowTimerText"] = true,
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1TZvNvgAkfmq",
["Type"] = "buff",
["Name"] = "Enrage",
["SettingsPerView"] = {
["icon"] = {
["TextLayout"] = "TMW:textlayout:1TZve345g=GK",
},
},
["ShowTimerText"] = true,
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["TextureName"] = "Details Flat",
["Name"] = "General Buffs/Debbufs",
["Locked"] = true,
["Alpha"] = 0,
["Columns"] = 20,
},
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
"TMW:icon:1TQv_LtTwAae",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1TQv_Ltf40Wl",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1TQv_Lti1RyX",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1TU=hLnlwyeY",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1TWYSTcSCl0z",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["TextureName"] = "Details Flat",
},
},
["Locked"] = true,
["Version"] = 102601,
["NumGroups"] = 3,
["TextureName"] = "xVerminClean",
},
["Dopenac - Lone Wolf"] = {
["Version"] = 102401,
},
["Dopecure - Stitches"] = {
["Version"] = 101600,
},
["SHAMAN test"] = {
["Locked"] = true,
["Version"] = 101600,
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
},
{
["Name"] = "xInRange(30)",
["Type"] = "LUA",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1Zi_P9LYFYqt",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1a3BehKNMJeZ",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Fire Nova",
["Enabled"] = true,
["Conditions"] = {
{
["Name"] = "xInRange(2) and xAOE() > 1",
["Type"] = "LUA",
},
{
["Type"] = "TOTEM1",
["Operator"] = "~=",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1a3BehLSsHyB",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Rockbiter Weapon",
["Conditions"] = {
{
["Type"] = "MAINHAND",
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1az3vfr0teCJ",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Flametongue Weapon",
["Conditions"] = {
{
["Type"] = "MAINHAND",
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1Zi_P9NDuquZ",
["States"] = {
{
},
nil,
{
},
{
},
},
},
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
},
{
["Name"] = "Water Shield",
["Type"] = "BUFFDUR",
},
{
["Type"] = "MANA",
["Level"] = 50,
["Operator"] = ">",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1Zi=Lf3qDCmn",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Water Shield",
["Conditions"] = {
{
["Name"] = "Lightning Shield",
["Type"] = "BUFFDUR",
},
{
["Name"] = "Water Shield",
["Type"] = "BUFFDUR",
},
{
["Type"] = "MANA",
["Level"] = 50,
["Operator"] = "<=",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1a3v7YGRBZRQ",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Strength of Earth Totem",
["Conditions"] = {
{
["Name"] = "Strength of Earth",
["Type"] = "BUFFDUR",
},
{
["Name"] = "-- call of the elements\nnot IsSpellKnown(66842) and xInRange(2)",
["Type"] = "LUA",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1a3BehLXSU4P",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Searing Totem",
["Conditions"] = {
{
["Name"] = "Searing Totem",
["Type"] = "TOTEM1",
},
{
["Name"] = "-- call of the elements\nnot IsSpellKnown(66842) and xInRange(2) and xAOE() > 1",
["Type"] = "LUA",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1a3BehLVCfO3",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Healing Wave",
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 50,
["Operator"] = "<=",
},
{
["Type"] = "SPEED",
},
{
["Type"] = "CURRENTSPELL",
["Name"] = "Healing Wave",
["Level"] = 1,
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1Zhjpe9Lw_WF",
["States"] = {
{
},
nil,
{
},
{
},
},
},
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
},
{
["Type"] = "REACT",
["Level"] = 2,
["Unit"] = "mouseover",
},
["n"] = 2,
},
["CustomTex"] = "526",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
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
},
["n"] = 1,
},
["CustomTex"] = "5720",
["States"] = {
{
},
nil,
{
},
{
},
},
},
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
},
["n"] = 1,
},
["CustomTex"] = "29203",
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Name"] = "SHAMAN SPELLS",
["Locked"] = true,
["Alpha"] = 0,
["Columns"] = 20,
["OnlyInCombat"] = true,
},
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
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["TextureName"] = "Details Flat",
},
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
"TMW:icon:1ZhjptZBAxKW",
"TMW:icon:1ZBi1G1LSN04",
"TMW:icon:1a3BehMeWjaB",
"TMW:icon:1Zhjpe9Lw_WF",
"TMW:icon:1a3v7YGRBZRQ",
"TMW:icon:1Zi=Lf3qDCmn",
"TMW:icon:1az3vfr0teCJ",
"TMW:icon:1a3BehKNMJeZ",
"TMW:icon:1Zi_P9LYFYqt",
"TMW:icon:1a3BehLSsHyB",
"TMW:icon:1TeVAjjXQ0WB",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1YXd9eWHzTSH",
"TMW:icon:1YXd9eWMwI0j",
"TMW:icon:1V6noP8ARoel",
"TMW:icon:1V6lsULwY3_Y",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["OnlyInCombat"] = true,
},
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
},
{
["Type"] = "MOUNTED",
["Level"] = 1,
},
{
["Type"] = "EXISTS",
["Unit"] = "target",
},
{
["Type"] = "ALIVE",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
["n"] = 5,
},
["Icons"] = {
"TMW:icon:1ZhjptZBAxKW",
"TMW:icon:1ZBi1G1LSN04",
"TMW:icon:1a3BehMeWjaB",
"TMW:icon:1Zhjpe9Lw_WF",
"TMW:icon:1a3v7YGRBZRQ",
"TMW:icon:1Zi=Lf3qDCmn",
"TMW:icon:1az3vfr0teCJ",
"TMW:icon:1a3BehKNMJeZ",
"TMW:icon:1Zi_P9LYFYqt",
"TMW:icon:1a3BehLSsHyB",
"TMW:icon:1TeVAjjXQ0WB",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Type"] = "meta",
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["SortPriorities"] = {
{
["Order"] = -1,
},
},
},
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
"TMW:icon:1a3BehLVCfO3",
"TMW:icon:1a3BehLXSU4P",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["OnlyInCombat"] = true,
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
},
},
["Dopesnare - Stitches"] = {
["Version"] = 101600,
},
["Dopedot - Lone Wolf"] = {
["Version"] = 102000,
},
["Dopecoil - Lone Wolf"] = {
["Version"] = 102000,
},
["Lonac - Stitches"] = {
["Version"] = 101600,
},
["WARLOCK"] = {
["Locked"] = true,
["NumGroups"] = 5,
["Version"] = 102601,
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
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["TextureName"] = "Details Flat",
},
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
["Conditions"] = {
{
["Type"] = "CASTING",
["Name"] = "Drain Soul",
["Level"] = 2,
},
["n"] = 1,
},
["Icons"] = {
"TMW:icon:1ZFP_8OYz7Gr",
"TMW:icon:1ZFP_8OauieW",
"TMW:icon:1blF3DfRBbWh",
"TMW:icon:1blF3DfQQxSk",
"TMW:icon:1V6ky7UjmQN=",
"TMW:icon:1V6ky7UreCKN",
"TMW:icon:1V6ky7Uy=NmE",
"TMW:icon:1bkdnMOnseGz",
"TMW:icon:1bkHiYOOgU8I",
"TMW:icon:1YXBfKWFOMGr",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1V6ky7UreCKN",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1V6ky7Uy=NmE",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["LayoutDirection"] = 2,
["Name"] = "Rotation TOPLEFT",
["Locked"] = true,
["Conditions"] = {
{
["Type"] = "EXISTS",
["Unit"] = "target",
},
{
["Type"] = "ALIVE",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
["n"] = 3,
},
["Columns"] = 1,
["OnlyInCombat"] = true,
},
{
["GUID"] = "TMW:group:1V6ky7Uf4nZ5",
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
},
{
["Type"] = "CURRENTSPELL",
["Name"] = "Immolate",
["Level"] = 1,
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1V6ky7UjmQN=",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
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
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1V6ky7UreCKN",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
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
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1V6ky7Uy=NmE",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1YXBfKWFOMGr",
["Type"] = "cooldown",
["Name"] = "Shadow Bolt",
["ManaCheck"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "CURRENTSPELL",
["Name"] = "Shadow Bolt",
["Level"] = 1,
},
{
["Type"] = "SPEED",
},
{
["PrtsBefore"] = 1,
["Type"] = "LUA",
["Name"] = "not IsSpellKnownOrOverridesKnown(412758)",
},
{
["Type"] = "MANAUSABLE",
["Name"] = "Incinerate",
["Level"] = 1,
["PrtsAfter"] = 1,
["AndOr"] = "OR",
},
["n"] = 4,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Incinerate",
["GUID"] = "TMW:icon:1bkHiYOOgU8I",
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "CURRENTSPELL",
["Name"] = "Incinerate",
["Level"] = 1,
},
{
["Name"] = "IsSpellKnownOrOverridesKnown(412758)",
["Type"] = "LUA",
},
{
["Type"] = "SPEED",
},
["n"] = 3,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Chaos Bolt",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "CURRENTSPELL",
["Name"] = "Chaos Bolt",
["Level"] = 1,
},
{
["Type"] = "SPELLCD",
["Level"] = 1.6,
["Name"] = "Chaos Bolt",
["Operator"] = "<=",
},
{
["Name"] = "IsSpellKnownOrOverridesKnown(403629)",
["Type"] = "LUA",
},
{
["Type"] = "SPEED",
},
["n"] = 4,
},
["GUID"] = "TMW:icon:1bkdnMOnseGz",
["States"] = {
{
},
{
["Alpha"] = 1,
},
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Drain Soul",
["GUID"] = "TMW:icon:1blF3DfQQxSk",
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "ITEMINBAGS",
["Level"] = 6,
["Name"] = "Soul Shard",
["Operator"] = "<",
},
{
["Unit"] = "target",
["Level"] = 40,
["Type"] = "HEALTH",
["Operator"] = "<=",
},
{
["Name"] = "xBehindTarget()",
["Type"] = "LUA",
},
["n"] = 3,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Drain Life",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "DEBUFFDUR",
["Name"] = "Drain Life",
["Level"] = 1.2,
["Unit"] = "target",
["Operator"] = "<",
},
{
["Type"] = "HEALTH",
["Level"] = 99,
["Operator"] = "<=",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1blF3DfRBbWh",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "item",
["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
["States"] = {
{
},
nil,
{
},
{
},
},
["GUID"] = "TMW:icon:1ZFP_8OYz7Gr",
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 60,
["Operator"] = "<=",
},
["n"] = 1,
},
["CustomTex"] = "5720",
["OnlyInBags"] = true,
},
{
["Enabled"] = true,
["Type"] = "item",
["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905",
["States"] = {
{
},
nil,
{
},
{
},
},
["GUID"] = "TMW:icon:1ZFP_8OauieW",
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 30,
["Operator"] = "<=",
},
["n"] = 1,
},
["CustomTex"] = "29203",
["OnlyInBags"] = true,
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Name"] = "Warlock Spells",
["Locked"] = true,
["Columns"] = 20,
["Alpha"] = 0,
},
{
["GUID"] = "TMW:group:1YWt9BdVNgGm",
["Point"] = {
["y"] = -120,
["x"] = -5.450076092640056e-05,
},
["Scale"] = 1.5,
["Icons"] = {
{
["Enabled"] = true,
["Type"] = "meta",
["Conditions"] = {
{
["Type"] = "CASTING",
["Name"] = "Drain Soul",
["Level"] = 2,
},
["n"] = 1,
},
["Icons"] = {
"TMW:icon:1ZFP_8OYz7Gr",
"TMW:icon:1ZFP_8OauieW",
"TMW:icon:1blF3DfRBbWh",
"TMW:icon:1blF3DfQQxSk",
"TMW:icon:1V6ky7UjmQN=",
"TMW:icon:1V6ky7UreCKN",
"TMW:icon:1V6ky7Uy=NmE",
"TMW:icon:1bkdnMOnseGz",
"TMW:icon:1bkHiYOOgU8I",
"TMW:icon:1YXBfKWFOMGr",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1V6ky7UreCKN",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1V6ky7Uy=NmE",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["LayoutDirection"] = 2,
["Name"] = "Rotation CENTER",
["Locked"] = true,
["Conditions"] = {
{
["Type"] = "EXISTS",
["Unit"] = "target",
},
{
["Type"] = "ALIVE",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
["n"] = 3,
},
["Columns"] = 1,
["OnlyInCombat"] = true,
},
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
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["OnlyInCombat"] = true,
},
},
},
["Dopebolt - Lone Wolf"] = {
["Version"] = 102000,
},
["Battlenac - Celebras"] = {
["Version"] = 110401,
},
["Jutarnjedrvo - Lone Wolf"] = {
["Version"] = 102000,
},
["SHAMAN"] = {
["Locked"] = true,
["NumGroups"] = 5,
["Version"] = 110401,
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
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Lightning Bolt",
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "SPEED",
},
{
["Type"] = "MANA",
["Level"] = 70,
["Operator"] = ">=",
},
{
["Name"] = "xInRange(30)",
["Type"] = "LUA",
},
{
["Type"] = "CURRENTSPELL",
["Name"] = "Lightning Bolt",
["Level"] = 1,
},
{
["Name"] = "not xImmune(\"Lightning Bolt\")",
["Type"] = "LUA",
},
["n"] = 5,
},
["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1Zi_P9LYFYqt",
["Type"] = "cooldown",
["Name"] = "Flame Shock",
["ManaCheck"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Flame Shock",
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Unit"] = "target",
},
{
["Name"] = "xTTD > 6",
["Type"] = "LUA",
},
{
["Name"] = "not xImmune(\"Flame Shock\")",
["Type"] = "LUA",
},
["n"] = 3,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
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
},
{
["Name"] = "not xImmune(\"Earth Shock\")",
["Type"] = "LUA",
},
["n"] = 2,
},
["Enabled"] = true,
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1b_18Nq2vIuM",
["Type"] = "cooldown",
["Name"] = "Frost Shock",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "MANA",
["PrtsBefore"] = 1,
["Level"] = 15,
["Operator"] = "<=",
["Unit"] = "target",
},
{
["Type"] = "SPEED",
["Name"] = "not xImmune(\"Frost Shock\")",
["Unit"] = "target",
["Level"] = 69,
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = ">",
},
{
["Name"] = "not xImmune(\"Frost Shock\")",
["Type"] = "LUA",
},
{
["PrtsBefore"] = 1,
["Type"] = "MANA",
["Level"] = 60,
["Operator"] = ">=",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Shamanistic Rage",
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = "~=",
},
["n"] = 5,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Chain Lightning",
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 80,
["Operator"] = ">",
},
{
["Type"] = "BUFFSTACKS",
["Name"] = "Maelstrom Weapon",
["Level"] = 5,
},
{
["Name"] = "not xImmune(\"Chain Lightning\")",
["Type"] = "LUA",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1c06wqPbwWum",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1bhCUZbAne4p",
["Type"] = "cooldown",
["Name"] = "Molten Blast",
["ManaCheck"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "LUA",
["Checked"] = true,
["Unit"] = "target",
["Level"] = 4,
["Name"] = "xInRange(5) and IsSpellKnownOrOverridesKnown(425339)",
["Operator"] = ">",
},
{
["PrtsBefore"] = 1,
["Type"] = "MANA",
["Level"] = 60,
["Operator"] = ">=",
},
{
["AndOr"] = "OR",
["Type"] = "LUA",
["PrtsAfter"] = 1,
["Name"] = "xAOE(5,false) > 1",
},
{
["Name"] = "not xImmune(\"Molten Blast\")",
["Type"] = "LUA",
},
["n"] = 4,
},
["Enabled"] = true,
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Lava Lash",
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "LUA",
["Checked"] = true,
["Unit"] = "target",
["Level"] = 4,
["Name"] = "IsSpellKnownOrOverridesKnown(408507)",
["Operator"] = ">",
},
{
["Name"] = "not xImmune(\"Lava Lash\")",
["Type"] = "LUA",
},
{
["Level"] = 1,
["Type"] = "SPELLCD",
["Name"] = "Lava Lash",
["Operator"] = "<=",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1bhfVRMJ6c4p",
["States"] = {
{
},
{
["Alpha"] = 1,
},
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1b_18NqJKhyk",
["Type"] = "cooldown",
["Name"] = "Shamanistic Rage",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "LUA",
["Checked"] = true,
["Unit"] = "target",
["Level"] = 4,
["Name"] = "IsSpellKnownOrOverridesKnown(425336)",
["Operator"] = ">",
},
{
["Type"] = "HEALTH",
["Name"] = "not xImmune(\"Lava Lash\")",
["PrtsBefore"] = 1,
["Level"] = 57,
["Operator"] = "<=",
},
{
["Type"] = "MANA",
["Level"] = 45,
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = "<=",
},
["n"] = 3,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Stormstrike",
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "LUA",
["Checked"] = true,
["Unit"] = "target",
["Level"] = 4,
["Name"] = "IsSpellKnownOrOverridesKnown(17364)",
["Operator"] = ">",
},
{
["Name"] = "not xImmune(\"Stormstrike\")",
["Type"] = "LUA",
},
{
["Level"] = 1,
["Type"] = "SPELLCD",
["Name"] = "Stormstrike",
["Operator"] = "<=",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1c3bXU2OLKG1",
["States"] = {
{
},
{
["Alpha"] = 1,
},
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Windfury Weapon",
["Conditions"] = {
{
["Type"] = "MAINHAND",
["Level"] = 10,
["Operator"] = "<=",
},
{
["Type"] = "LUA",
["Name"] = "xMHWF()",
["AndOr"] = "OR",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1b_lp7goF64O",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Windfury Weapon",
["GUID"] = "TMW:icon:1b_lp7gtOeie",
["Conditions"] = {
{
["Type"] = "OFFHAND",
["Level"] = 10,
["Operator"] = "<=",
},
{
["Name"] = "not IsEquippedItemType('Shields')",
["Type"] = "LUA",
},
["n"] = 2,
},
["CustomTex"] = "inv_hammer_05",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1biL5nQORgmt",
["Type"] = "cooldown",
["Name"] = "Frostbrand Weapon",
["Conditions"] = {
{
["Type"] = "MAINHAND",
["Level"] = 10,
["Operator"] = "<=",
},
["n"] = 1,
},
["Enabled"] = true,
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Frostbrand Weapon",
["GUID"] = "TMW:icon:1biL5nQPCiGS",
["Conditions"] = {
{
["Type"] = "OFFHAND",
["Level"] = 10,
["Operator"] = "<=",
},
{
["Name"] = "not IsEquippedItemType('Shields')",
["Type"] = "LUA",
},
["n"] = 2,
},
["CustomTex"] = "inv_hammer_06",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1Zi_P9NDuquZ",
["Type"] = "cooldown",
["Name"] = "Flametongue Weapon",
["Conditions"] = {
{
["Type"] = "MAINHAND",
["Level"] = 10,
["Operator"] = "<=",
},
["n"] = 1,
},
["Enabled"] = true,
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Flametongue Weapon",
["GUID"] = "TMW:icon:1bhuQwl8Qyyf",
["Conditions"] = {
{
["Type"] = "OFFHAND",
["Level"] = 10,
["Operator"] = "<=",
},
{
["Name"] = "not IsEquippedItemType('Shields')",
["Type"] = "LUA",
},
["n"] = 2,
},
["CustomTex"] = "inv_hammer_07",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1az3vfr0teCJ",
["Type"] = "cooldown",
["Name"] = "Rockbiter Weapon",
["Conditions"] = {
{
["Type"] = "MAINHAND",
["Level"] = 10,
["Operator"] = "<=",
},
["n"] = 1,
},
["Enabled"] = true,
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Rockbiter Weapon",
["SettingsPerView"] = {
["icon"] = {
["Texts"] = {
"",
},
},
},
["GUID"] = "TMW:icon:1biD7YNstx0_",
["Conditions"] = {
{
["Type"] = "OFFHAND",
["Level"] = 10,
["Operator"] = "<=",
},
{
["Name"] = "not IsEquippedItemType('Shields')",
["Type"] = "LUA",
},
["n"] = 2,
},
["CustomTex"] = "inv_hammer_08",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1Zi=Lf3qDCmn",
["Type"] = "cooldown",
["Name"] = "Lightning Shield",
["Conditions"] = {
{
["Name"] = "Lightning Shield",
["Type"] = "BUFFDUR",
},
{
["Name"] = "Water Shield",
["Type"] = "BUFFDUR",
},
{
["Operator"] = ">",
["Type"] = "MANA",
},
{
["Name"] = "not xImmune(\"Lightning Shield\")",
["Type"] = "LUA",
},
["n"] = 4,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1bhfVRNgDzW5",
["Type"] = "cooldown",
["Name"] = "Water Shield",
["Conditions"] = {
{
["Name"] = "Water Shield",
["Type"] = "BUFFDUR",
},
{
["Name"] = "Lightning Shield",
["Type"] = "BUFFDUR",
},
{
["Type"] = "MANA",
["Level"] = 40,
["Operator"] = "<=",
},
{
["Name"] = "IsSpellKnownOrOverridesKnown(408510)",
["Type"] = "LUA",
},
["n"] = 4,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1c6OijbYQ84c",
["Type"] = "cooldown",
["Name"] = "Lightning Bolt",
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 80,
["Operator"] = ">",
},
{
["Type"] = "BUFFSTACKS",
["Name"] = "Maelstrom Weapon",
["Level"] = 5,
},
{
["Level"] = 1.5,
["Type"] = "SPELLCD",
["Name"] = "Chain Lightning",
["Operator"] = ">=",
},
{
["Name"] = "not xImmune(\"Lightning Bolt\")",
["Type"] = "LUA",
},
["n"] = 4,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Windfury Totem",
["Conditions"] = {
{
["Name"] = "Strength of Earth",
["Type"] = "BUFFDUR",
},
{
["Name"] = "-- call of the elements\nnot IsSpellKnown(66842) and xInRange(2)",
["Type"] = "LUA",
},
["n"] = 2,
},
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1a3BehLXSU4P",
["Type"] = "cooldown",
["Name"] = "Strength of Earth Totem",
["Conditions"] = {
{
["Name"] = "Strength of Earth",
["Type"] = "BUFFDUR",
},
{
["Name"] = "-- call of the elements\nnot IsSpellKnown(66842) and xInRange(2)",
["Type"] = "LUA",
},
["n"] = 2,
},
["Enabled"] = true,
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1a3BehLVCfO3",
["Type"] = "cooldown",
["Name"] = "Searing Totem",
["Conditions"] = {
{
["Name"] = "Searing Totem",
["Type"] = "TOTEM1",
},
{
["Name"] = "-- call of the elements\nnot IsSpellKnown(66842) and xInRange(5) -- and xAOE() > 1",
["Type"] = "LUA",
},
["n"] = 2,
},
["Enabled"] = true,
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1Zhjpe9Lw_WF",
["Type"] = "cooldown",
["Name"] = "Healing Wave",
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 80,
["Operator"] = "<=",
},
{
["Type"] = "BUFFSTACKS",
["Name"] = "Maelstrom Weapon",
["Level"] = 5,
},
["n"] = 2,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Healing Wave",
["GUID"] = "TMW:icon:1c3c6f9pDkKm",
["Conditions"] = {
{
["Type"] = "EXISTS",
["AndOr"] = "OR",
["Unit"] = "mouseover",
},
{
["Operator"] = "<=",
["Level"] = 60,
["Type"] = "HEALTH",
["Unit"] = "mouseover",
},
{
["Type"] = "REACT",
["Level"] = 2,
["Unit"] = "mouseover",
},
{
["Unit"] = "mouseover",
["Type"] = "ISPLAYER",
},
{
["Type"] = "BUFFSTACKS",
["Name"] = "Maelstrom Weapon",
["Level"] = 5,
},
["n"] = 5,
},
["CustomTex"] = "443464",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Healing Wave",
["GUID"] = "TMW:icon:1c3cjX9efOO3",
["Conditions"] = {
{
["Type"] = "EXISTS",
["AndOr"] = "OR",
["Unit"] = "targettarget",
},
{
["Operator"] = "<=",
["Level"] = 60,
["Type"] = "HEALTH",
["Unit"] = "targettarget",
},
{
["Type"] = "REACT",
["Level"] = 2,
["Unit"] = "targettarget",
},
{
["Unit"] = "targettarget",
["Type"] = "ISPLAYER",
},
{
["Level"] = 1,
["Type"] = "UNITISUNIT",
["Name"] = "player",
["Unit"] = "targettarget",
},
{
["Type"] = "BUFFSTACKS",
["Name"] = "Maelstrom Weapon",
["Level"] = 5,
},
["n"] = 6,
},
["CustomTex"] = "14913",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Cure Disease",
["States"] = {
{
},
nil,
{
},
{
},
},
["BuffOrDebuff"] = "HARMFUL",
["Conditions"] = {
{
["Unit"] = "mouseover",
["Type"] = "EXISTS",
},
{
["Type"] = "REACT",
["Level"] = 2,
["Unit"] = "mouseover",
},
{
["Name"] = "xDisease(\"mouseover\")",
["Type"] = "LUA",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1biK78mkzXeo",
["Unit"] = "mouseover",
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Cure Poison",
["States"] = {
{
},
nil,
{
},
{
},
},
["BuffOrDebuff"] = "HARMFUL",
["Conditions"] = {
{
["Unit"] = "mouseover",
["Type"] = "EXISTS",
},
{
["Type"] = "REACT",
["Level"] = 2,
["Unit"] = "mouseover",
},
{
["Name"] = "xPoison(\"mouseover\")",
["Type"] = "LUA",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1a3BehMeWjaB",
["Unit"] = "mouseover",
},
{
["GUID"] = "TMW:icon:1c4GQPDcviWr",
["Type"] = "cooldown",
["Name"] = "Purge",
["Conditions"] = {
{
["Unit"] = "target",
["Type"] = "EXISTS",
},
{
["Name"] = "xMagic(\"target\")",
["Type"] = "LUA",
},
["n"] = 2,
},
["Enabled"] = true,
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1ZBi1G1LSN04",
["Type"] = "item",
["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
["States"] = {
{
},
nil,
{
},
{
},
},
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 60,
["Operator"] = "<=",
},
["n"] = 1,
},
["CustomTex"] = "5720",
["OnlyInBags"] = true,
},
{
["GUID"] = "TMW:icon:1ZhjptZBAxKW",
["Type"] = "item",
["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838",
["States"] = {
{
},
nil,
{
},
{
},
},
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 20,
["Operator"] = "<=",
},
["n"] = 1,
},
["CustomTex"] = "29203",
["OnlyInBags"] = true,
},
},
["Point"] = {
["y"] = -5,
["point"] = "TOP",
["relativePoint"] = "TOP",
},
},
{
["GUID"] = "TMW:group:1TWYPj24VzCn",
["Point"] = {
["y"] = -20.00000522536274,
["x"] = -229.9999934656047,
},
["Name"] = "Other",
["Alpha"] = 0,
["Scale"] = 1.5,
["Columns"] = 1,
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["TextureName"] = "Details Flat",
},
{
["GUID"] = "TMW:group:1TeVDtajUwqa",
["Point"] = {
["y"] = -140,
["x"] = -5.450076092640056e-05,
},
["Scale"] = 1.5,
["Alpha"] = 0,
["Name"] = "Rotation CENTER",
["Locked"] = true,
["Icons"] = {
{
["Enabled"] = true,
["Type"] = "meta",
["Conditions"] = {
{
["Name"] = "not IsAltKeyDown();",
["Type"] = "LUA",
},
{
["Level"] = 1,
["Type"] = "MOUNTED",
},
{
["Unit"] = "target",
["Type"] = "EXISTS",
},
{
["Unit"] = "target",
["Type"] = "ALIVE",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
["n"] = 5,
},
["Icons"] = {
"TMW:icon:1ZhjptZBAxKW",
"TMW:icon:1ZBi1G1LSN04",
"TMW:icon:1a3BehMeWjaB",
"TMW:icon:1biK78mkzXeo",
"TMW:icon:1c4GQPDcviWr",
"TMW:icon:1c3c6f9pDkKm",
"TMW:icon:1Zhjpe9Lw_WF",
"TMW:icon:1c3cjX9efOO3",
"TMW:icon:1c06wqPbwWum",
"TMW:icon:1c6OijbYQ84c",
"TMW:icon:1Zi=Lf3qDCmn",
"TMW:icon:1b_18Nq2vIuM",
"TMW:icon:1az3vfr0teCJ",
"TMW:icon:1biD7YNstx0_",
"TMW:icon:1Zi_P9NDuquZ",
"TMW:icon:1bhuQwl8Qyyf",
"TMW:icon:1b_lp7goF64O",
"TMW:icon:1b_lp7gtOeie",
"TMW:icon:1c3bXU2OLKG1",
"TMW:icon:1bhfVRMJ6c4p",
"TMW:icon:1Zi_P9LYFYqt",
"TMW:icon:1bhCUZbAne4p",
"TMW:icon:1TeVAjjXQ0WB",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1YXd9eWHzTSH",
"TMW:icon:1YXd9eWMwI0j",
"TMW:icon:1V6noP8ARoel",
"TMW:icon:1V6lsULwY3_Y",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Columns"] = 1,
["OnlyInCombat"] = true,
},
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
},
{
["Level"] = 1,
["Type"] = "MOUNTED",
},
{
["Unit"] = "target",
["Type"] = "EXISTS",
},
{
["Unit"] = "target",
["Type"] = "ALIVE",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
["n"] = 5,
},
["Icons"] = {
"TMW:icon:1ZhjptZBAxKW",
"TMW:icon:1ZBi1G1LSN04",
"TMW:icon:1a3BehMeWjaB",
"TMW:icon:1biK78mkzXeo",
"TMW:icon:1c4GQPDcviWr",
"TMW:icon:1c3c6f9pDkKm",
"TMW:icon:1c3cjX9efOO3",
"TMW:icon:1Zhjpe9Lw_WF",
"TMW:icon:1c06wqPbwWum",
"TMW:icon:1c6OijbYQ84c",
"TMW:icon:1Zi=Lf3qDCmn",
"TMW:icon:1b_18Nq2vIuM",
"TMW:icon:1az3vfr0teCJ",
"TMW:icon:1biD7YNstx0_",
"TMW:icon:1Zi_P9NDuquZ",
"TMW:icon:1bhuQwl8Qyyf",
"TMW:icon:1b_lp7goF64O",
"TMW:icon:1b_lp7gtOeie",
"TMW:icon:1c3bXU2OLKG1",
"TMW:icon:1bhfVRMJ6c4p",
"TMW:icon:1Zi_P9LYFYqt",
"TMW:icon:1bhCUZbAne4p",
"TMW:icon:1TeVAjjXQ0WB",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
["Type"] = "meta",
},
},
["SortPriorities"] = {
{
["Order"] = -1,
},
},
["Name"] = "Rotation TOPLEFT",
["Locked"] = true,
["Columns"] = 1,
["OnlyInCombat"] = true,
},
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
["Icons"] = {
"TMW:icon:1a3BehLVCfO3",
"TMW:icon:1a3BehLXSU4P",
"TMW:icon:1b_18NqJKhyk",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["OnlyInCombat"] = true,
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
},
},
["Dopetrap - Lone Wolf"] = {
["Version"] = 102000,
},
["Dopede - Stitches"] = {
["Version"] = 101600,
},
["Vermins - Stitches"] = {
["Version"] = 101600,
},
["Dopemend - Lone Wolf"] = {
["Version"] = 102000,
},
["Battitude - Zandalar Tribe"] = {
["Version"] = 110001,
},
["DEATHKNIGHT"] = {
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
},
{
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Unit"] = "target",
["PrtsBefore"] = 1,
["Level"] = 3,
["Name"] = "Frost Fever",
["Operator"] = "<",
},
{
["Unit"] = "target",
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Name"] = "Blood Plague",
["Level"] = 3,
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = "<",
},
["n"] = 3,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
["n"] = 1,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Name"] = "Strength of Earth",
["Type"] = "BUFFDUR",
},
{
["Type"] = "SPELLCD",
["Name"] = "Obliterate",
["PrtsBefore"] = 1,
["AndOr"] = "OR",
["Level"] = 3,
["Operator"] = ">",
},
{
["Level"] = 50,
["Type"] = "RUNIC_POWER_ABS",
["PrtsAfter"] = 1,
["Operator"] = "<",
},
["n"] = 4,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
["Color"] = "ffffffff",
["Alpha"] = 0,
},
{
["Color"] = "ffffffff",
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "BUFFDUR",
["Name"] = "Divine Shield",
["Unit"] = "target",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Ice Block",
["Unit"] = "target",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Anti-Magic Shell",
["Unit"] = "target",
},
["n"] = 4,
},
["RangeCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Anti-Magic Shell",
["Enabled"] = true,
["Conditions"] = {
{
["Name"] = "xAOE(10,true) > 0 or xUnitCastingNonInteruptable(\"target\")",
["Type"] = "LUA",
},
{
["PrtsBefore"] = 1,
["Type"] = "ISPLAYER",
["AndOr"] = "OR",
["Unit"] = "target",
},
{
["Level"] = 1,
["Type"] = "REACT",
["PrtsAfter"] = 1,
["Unit"] = "target",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1ZGiKdRg6oif",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Death and Decay",
["Enabled"] = true,
["Conditions"] = {
{
["Name"] = "xAOE(10) >= 4",
["Type"] = "LUA",
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1ZXaz0p3YpOm",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["AndOr"] = "OR",
["Type"] = "DEBUFFDUR",
["Name"] = "Sated",
["Operator"] = "~=",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1ZYXYoMjwNSI",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Empower Rune Weapon",
["Conditions"] = {
{
["BitFlags"] = 62,
["Type"] = "RUNES2",
},
{
["Type"] = "LEVEL",
["PrtsBefore"] = 1,
["Level"] = 82,
["Unit"] = "target",
["Operator"] = ">",
},
{
["Type"] = "LEVEL",
["Level"] = -1,
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Unit"] = "target",
},
{
["PrtsBefore"] = 1,
["Type"] = "BUFFDUR",
["Name"] = "Bloodlust",
["Operator"] = "~=",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Sated",
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = "~=",
},
["n"] = 5,
},
["GUID"] = "TMW:icon:1ZYXYoMn068Y",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Obliterate",
["Enabled"] = true,
["Conditions"] = {
{
["Level"] = 2,
["Type"] = "SPEC",
},
{
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Operator"] = "~=",
["Name"] = "Blood Plague",
["Unit"] = "target",
},
{
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Operator"] = "~=",
["Name"] = "Frost Fever",
["Unit"] = "target",
},
{
["Type"] = "HEALTH",
["Level"] = 40,
["Operator"] = ">",
},
{
["PrtsBefore"] = 1,
["Type"] = "LUA",
["Name"] = "local blood, frost, unholy, death = xRuneCount()\n\nif frost>0 and unholy>0 then return true end\nif frost>0 and death>0 and blood+death>1 then return true end\nif unholy>0 and death>0 and blood+death>1 then return true end\n\nreturn false",
},
{
["Operator"] = ">",
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["AndOr"] = "OR",
["PrtsBefore"] = 1,
["Level"] = 7.5,
["Name"] = "Frost Fever",
["Unit"] = "target",
},
{
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Operator"] = ">",
["Name"] = "Blood Plague",
["Level"] = 7.5,
["PrtsAfter"] = 2,
["Unit"] = "target",
},
{
["Level"] = 1.5,
["Type"] = "SPELLCD",
["Name"] = "Obliterate",
["Operator"] = "<",
},
{
["PrtsBefore"] = 1,
["Type"] = "LUA",
["Name"] = "xAOE(10) < 3",
},
{
["Type"] = "SPELLCD",
["Name"] = "Howling Blast",
["AndOr"] = "OR",
["Level"] = 2,
["PrtsAfter"] = 1,
["Operator"] = ">",
},
["n"] = 10,
},
["GUID"] = "TMW:icon:1ZYXYoMoeHKG",
["States"] = {
{
},
{
["Alpha"] = 1,
},
{
},
{
["Color"] = "ffffffff",
["Alpha"] = 1,
},
},
},
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
},
{
["Type"] = "RUNIC_POWER_ABS",
["Level"] = 95,
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = ">",
},
{
["Type"] = "SPELLCD",
["Name"] = "Obliterate",
["PrtsBefore"] = 1,
["Level"] = 1.5,
["Operator"] = ">",
},
{
["Type"] = "SPELLCD",
["Name"] = "Howling Blast",
["AndOr"] = "OR",
["Level"] = 1.5,
["PrtsAfter"] = 1,
["Operator"] = ">",
},
["n"] = 4,
},
["GUID"] = "TMW:icon:1ZYXYoMqCvyD",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Howling Blast",
["Enabled"] = true,
["Conditions"] = {
{
["Level"] = 2,
["Type"] = "SPEC",
},
{
["PrtsBefore"] = 1,
["Type"] = "BUFFDUR",
["Name"] = "Freezing Fog",
["Operator"] = "~=",
},
{
["PrtsBefore"] = 1,
["Type"] = "LUA",
["Name"] = "xAOE(10) >= 3",
["AndOr"] = "OR",
},
{
["Type"] = "HEALTH",
["Level"] = 40,
["Operator"] = ">",
},
{
["Type"] = "LUA",
["Checked"] = true,
["Unit"] = "target",
["Name"] = "local blood, frost, unholy, death = xRuneCount()\n\nif frost>0 and unholy>0 then return true end\nif frost>0 and death>0 and blood+death>1 then return true end\nif unholy>0 and death>0 and blood+death>1 then return true end\n\nreturn false",
["Level"] = 1,
["PrtsAfter"] = 1,
["Operator"] = ">",
},
{
["Type"] = "SPELLCD",
["Name"] = "Howling Blast",
["Level"] = 1.5,
["PrtsAfter"] = 1,
["Operator"] = "<",
},
["n"] = 6,
},
["GUID"] = "TMW:icon:1ZYXYoMroYer",
["States"] = {
{
},
{
["Alpha"] = 1,
},
{
},
{
["Color"] = "ffffffff",
["Alpha"] = 1,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Raise Dead",
["Conditions"] = {
{
["Type"] = "BUFFDUR",
["Name"] = "Bloodlust",
["Operator"] = "~=",
},
{
["AndOr"] = "OR",
["Type"] = "DEBUFFDUR",
["Name"] = "Sated",
["Operator"] = "~=",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1Zsi3BcdqHDl",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
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
},
{
["Type"] = "BUFFDUR",
["Name"] = "Anti-Magic Shield",
["Unit"] = "target",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1YYs1I2bCNGy",
["States"] = {
{
},
nil,
{
["Color"] = "ffffffff",
["Alpha"] = 0,
},
{
["Color"] = "ffffffff",
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "ISPLAYER",
["Level"] = 1,
["Unit"] = "target",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Anti-Magic Shield",
["Unit"] = "target",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1YYs1I2c_Meo",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Unit"] = "target",
["Name"] = "Blood Plague",
["Operator"] = "~=",
},
{
["Level"] = 1,
["Type"] = "SPEC",
},
{
["Name"] = "xAOE(5) <= 2",
["Type"] = "LUA",
},
{
["Type"] = "RUNES2",
["BitFlags"] = 57,
["PrtsBefore"] = 1,
["Level"] = 1,
["Operator"] = ">",
},
{
["Type"] = "HEALTH",
["AndOr"] = "OR",
["Level"] = 75,
["PrtsAfter"] = 1,
["Operator"] = ">=",
},
["n"] = 6,
},
["GUID"] = "TMW:icon:1YYv3MYeNeSM",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Color"] = "ffffffff",
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "DEFAULT_ABS",
["Level"] = 60,
["Operator"] = ">=",
},
{
["Type"] = "CURRENTSPELL",
["Name"] = "Rune Strike",
["Level"] = 1,
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1YZamy7DqjiW",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Unit"] = "target",
["Name"] = "Blood Plague",
["Operator"] = "~=",
},
{
["Type"] = "SPEC",
["PrtsAfter"] = 1,
["Level"] = 1,
},
{
["Type"] = "HEALTH",
["PrtsBefore"] = 1,
["AndOr"] = "OR",
["Level"] = 40,
["Operator"] = "<=",
},
{
["Type"] = "SPEC",
["PrtsAfter"] = 1,
["Level"] = 2,
},
["n"] = 5,
},
["GUID"] = "TMW:icon:1YaXVCdLMBa8",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Color"] = "ffffffff",
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "RUNES2",
["BitFlags"] = 1,
["Operator"] = ">",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1YbFYj2F1X0v",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1YbGRIr4FVqp",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Level"] = 1,
["Type"] = "SPEC",
},
{
["Type"] = "RUNES2",
["Name"] = "Death Strike",
["BitFlags"] = 57,
["PrtsBefore"] = 1,
["Level"] = 1,
["Operator"] = ">",
},
{
["Type"] = "HEALTH",
["AndOr"] = "OR",
["Level"] = 75,
["PrtsAfter"] = 1,
["Operator"] = ">",
},
["n"] = 4,
},
["GUID"] = "TMW:icon:1Z3Dak8Afvm1",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Operator"] = "<=",
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Name"] = "Blood Plague",
["AndOr"] = "OR",
["Level"] = 7.5,
["PrtsAfter"] = 1,
["Unit"] = "target",
},
{
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Operator"] = "~=",
["Name"] = "Frost Fever",
["Unit"] = "target",
},
{
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Operator"] = "~=",
["Name"] = "Blood Plague",
["PrtsAfter"] = 1,
["Unit"] = "target",
},
{
["Type"] = "LUA",
["Name"] = "xPestilenceAOE()",
["AndOr"] = "OR",
},
["n"] = 5,
},
["GUID"] = "TMW:icon:1Z4FFfpv6jKF",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Unit"] = "target",
["Type"] = "ISPLAYER",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1ZMyzzwKlj0c",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1Za8YRwFhvat",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Vampiric Blood",
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 40,
["Operator"] = "<=",
},
{
["Level"] = 1,
["Type"] = "SPEC",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1ZsFvYGT2kWU",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Pestilence",
["Conditions"] = {
{
["Name"] = "xPestilenceAOE()\n\nor \n\nxPestilenceSS()",
["Type"] = "LUA",
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1a2UsJB=W54o",
["States"] = {
{
},
nil,
{
},
{
},
},
},
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
},
{
["PrtsBefore"] = 1,
["Type"] = "LUA",
["Name"] = "xAOE(10) >= 3",
["AndOr"] = "OR",
},
{
["Type"] = "SPELLCD",
["Name"] = "Howling Blast",
["Level"] = 1,
["PrtsAfter"] = 1,
["Operator"] = ">",
},
{
["Level"] = 90,
["Type"] = "RUNIC_POWER_ABS",
["AndOr"] = "OR",
["Operator"] = ">",
},
["n"] = 4,
},
["GUID"] = "TMW:icon:1a1Aq1Tw_3ih",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "item",
["Name"] = "Battlemaster's Resolve",
["States"] = {
{
},
nil,
{
},
{
},
},
["GUID"] = "TMW:icon:1ZNzu1N3nE0K",
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 55,
["Operator"] = "<=",
},
["n"] = 1,
},
["OnlyEquipped"] = true,
["OnlyInBags"] = true,
},
{
["Enabled"] = true,
["Type"] = "item",
["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
["States"] = {
{
},
nil,
{
},
{
},
},
["GUID"] = "TMW:icon:1ZGiKdd7WnyK",
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 65,
["Operator"] = "<=",
},
["n"] = 1,
},
["CustomTex"] = "5720",
["OnlyInBags"] = true,
},
{
["Enabled"] = true,
["Type"] = "item",
["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905",
["States"] = {
{
},
nil,
{
},
{
},
},
["GUID"] = "TMW:icon:1ZGiKddAIuOA",
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 35,
["Operator"] = "<=",
},
["n"] = 1,
},
["CustomTex"] = "28491",
["OnlyInBags"] = true,
},
},
["Name"] = "DK Spells",
["Locked"] = true,
["Alpha"] = 0,
["Columns"] = 20,
},
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
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Scale"] = 1.5,
["Columns"] = 1,
["Alpha"] = 0,
["TextureName"] = "Details Flat",
},
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
},
{
["Unit"] = "target",
["Type"] = "ALIVE",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
{
["PrtsBefore"] = 1,
["Type"] = "MOUNTED",
["Level"] = 1,
},
{
["AndOr"] = "OR",
["Type"] = "INSTANCE2",
["PrtsAfter"] = 1,
["BitFlags"] = 504,
},
{
["Name"] = "return not IsAltKeyDown()",
["Type"] = "LUA",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Ice Block",
["Unit"] = "target",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Divine Shield",
["Unit"] = "target",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Anti-Magic Shell",
["Unit"] = "target",
},
["n"] = 9,
},
["Icons"] = {
"TMW:icon:1ZGiKdd7WnyK",
"TMW:icon:1ZGiKddAIuOA",
"TMW:icon:1Zsi3BcdqHDl",
"TMW:icon:1Z4FFfpv6jKF",
"TMW:icon:1V6lsULwY3_Y",
"TMW:icon:1ZMyzzwKlj0c",
"TMW:icon:1ZYXYoMjwNSI",
"TMW:icon:1YYs1I2bCNGy",
"TMW:icon:1YYs1I2c_Meo",
"TMW:icon:1ZYXYoMroYer",
"TMW:icon:1a1Aq1Tw_3ih",
"TMW:icon:1ZYXYoMoeHKG",
"TMW:icon:1YbFYj2F1X0v",
"TMW:icon:1YZamy7DqjiW",
"TMW:icon:1YaXVCdLMBa8",
"TMW:icon:1YYv3MYeNeSM",
"TMW:icon:1Z3Dak8Afvm1",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1YXd9eWHzTSH",
"TMW:icon:1YXd9eWMwI0j",
"TMW:icon:1V6noP8ARoel",
"TMW:icon:1V6lsULwY3_Y",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Name"] = "Rotation CENTER",
["Locked"] = true,
["Conditions"] = {
{
["Level"] = 1,
["Type"] = "MOUNTED",
},
["n"] = 1,
},
["Point"] = {
["y"] = -140,
["x"] = -5.450076092640056e-05,
},
["OnlyInCombat"] = true,
},
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
},
{
["Unit"] = "target",
["Type"] = "ALIVE",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
{
["PrtsBefore"] = 1,
["Type"] = "MOUNTED",
["Level"] = 1,
},
{
["AndOr"] = "OR",
["Type"] = "INSTANCE2",
["PrtsAfter"] = 1,
["BitFlags"] = 504,
},
{
["Name"] = "return not IsAltKeyDown()",
["Type"] = "LUA",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Divine Shield",
["Unit"] = "target",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Ice Block",
["Unit"] = "target",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Anti-Magic Shell",
["Unit"] = "target",
},
["n"] = 9,
},
["Icons"] = {
"TMW:icon:1ZGiKdd7WnyK",
"TMW:icon:1ZGiKddAIuOA",
"TMW:icon:1Zsi3BcdqHDl",
"TMW:icon:1Z4FFfpv6jKF",
"TMW:icon:1V6lsULwY3_Y",
"TMW:icon:1ZMyzzwKlj0c",
"TMW:icon:1ZYXYoMjwNSI",
"TMW:icon:1YYs1I2bCNGy",
"TMW:icon:1YYs1I2c_Meo",
"TMW:icon:1ZYXYoMroYer",
"TMW:icon:1a1Aq1Tw_3ih",
"TMW:icon:1ZYXYoMoeHKG",
"TMW:icon:1YbFYj2F1X0v",
"TMW:icon:1YZamy7DqjiW",
"TMW:icon:1YaXVCdLMBa8",
"TMW:icon:1YYv3MYeNeSM",
"TMW:icon:1Z3Dak8Afvm1",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
["Type"] = "meta",
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Name"] = "Rotation TOPLEFT",
["Locked"] = true,
["Conditions"] = {
{
["Level"] = 1,
["Type"] = "MOUNTED",
},
["n"] = 1,
},
["Columns"] = 1,
["OnlyInCombat"] = true,
},
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
},
{
["Unit"] = "target",
["Type"] = "EXISTS",
},
{
["Unit"] = "target",
["Type"] = "ALIVE",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
{
["PrtsBefore"] = 1,
["Type"] = "MOUNTED",
["Level"] = 1,
},
{
["AndOr"] = "OR",
["Type"] = "INSTANCE2",
["PrtsAfter"] = 1,
["BitFlags"] = 504,
},
["n"] = 6,
},
["Icons"] = {
"TMW:icon:1ZNzu1N3nE0K",
"TMW:icon:1ZsFvYGT2kWU",
"TMW:icon:1TeVAjjavXC6",
"TMW:icon:1V6noP8ARoel",
"TMW:icon:1TeVAjjXQ0WB",
"TMW:icon:1YbGRIr4FVqp",
"TMW:icon:1ZYXYoMn068Y",
"TMW:icon:1ZGiKdRg6oif",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["OnlyInCombat"] = true,
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
},
["NumGroups"] = 5,
["Version"] = 101600,
},
["DRUID"] = {
["Locked"] = true,
["NumGroups"] = 5,
["Version"] = 110401,
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
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Bear Form; Dire Bear Form",
["Type"] = "STANCE",
},
{
["Name"] = "InCombatLockdown() and not IsCurrentSpell(6603)",
["Type"] = "LUA",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1b4RXOJ1Gw40",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
["Type"] = "cooldown",
["Name"] = "Maul",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Bear Form; Dire Bear Form",
["Type"] = "STANCE",
},
{
["PrtsBefore"] = 2,
["Type"] = "LUA",
["Name"] = "xAOE(10) == 1",
},
{
["Type"] = "RAGE_ABS",
["PrtsAfter"] = 1,
["Operator"] = ">=",
},
{
["Type"] = "RAGE_ABS",
["Level"] = 40,
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = ">=",
},
{
["Type"] = "CURRENTSPELL",
["Name"] = "Maul",
["Level"] = 1,
},
["n"] = 5,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Swipe",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Bear Form; Dire Bear Form",
["Type"] = "STANCE",
},
{
["PrtsBefore"] = 1,
["Type"] = "LUA",
["Name"] = "xAOE(10) > 1",
},
{
["PrtsBefore"] = 1,
["Type"] = "CURRENTSPELL",
["Name"] = "Maul",
["AndOr"] = "OR",
},
{
["Type"] = "RAGE_ABS",
["Level"] = 30,
["PrtsAfter"] = 2,
["Operator"] = ">=",
},
{
["Name"] = "Berserk",
["Type"] = "BUFFDUR",
},
["n"] = 5,
},
["GUID"] = "TMW:icon:1V6lsULwY3_Y",
["States"] = {
{
},
nil,
{
["Color"] = "ffffffff",
["Alpha"] = 0,
},
{
["Color"] = "ffffffff",
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Demoralizing Roar",
["Unit"] = "target",
},
{
["Type"] = "LUA",
["Name"] = "xInRange(8) and xAOE(10) > 1",
["Level"] = 8,
["Unit"] = "target",
["Operator"] = "<=",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Demoralizing Shout",
["Unit"] = "target",
},
["n"] = 4,
},
["GUID"] = "TMW:icon:1TeVAjjavXC6",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1V6noP8ARoel",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Tiger's Fury",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Cat Form",
["Type"] = "STANCE",
},
{
["Checked"] = true,
["Type"] = "DEBUFFDUR",
["Name"] = "Rake",
["Unit"] = "target",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1Z4qW_DgW_ek",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Sunfire",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "None",
["Type"] = "STANCE",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Sunfire",
["Level"] = 1,
["Unit"] = "target",
["Operator"] = "<",
},
{
["Name"] = "xTTD == 0 or xTTD > 5",
["Type"] = "LUA",
},
{
["Name"] = "-- IsSpellKnown(414684)",
["Type"] = "LUA",
},
["n"] = 4,
},
["GUID"] = "TMW:icon:1bSC7io0AGGu",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Lifebloom",
["ManaCheck"] = true,
["Conditions"] = {
{
["PrtsBefore"] = 1,
["Type"] = "BUFFDUR",
["Name"] = "Lifebloom",
},
{
["Type"] = "BUFFSTACKS",
["Name"] = "Lifebloom",
["Level"] = 2,
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = "<",
},
{
["Type"] = "HEALTH",
["Level"] = 90,
["Operator"] = "<=",
},
{
["Name"] = "None",
["Type"] = "STANCE",
},
{
["Name"] = "IsSpellKnown(408124)",
["Type"] = "LUA",
},
["n"] = 5,
},
["GUID"] = "TMW:icon:1bSsu5MHaHu2",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Healing Touch",
["GUID"] = "TMW:icon:1bSC7io0voSV",
["Conditions"] = {
{
["PrtsBefore"] = 2,
["Type"] = "HEALTH",
["Level"] = 70,
["Operator"] = "<=",
},
{
["PrtsAfter"] = 1,
["Type"] = "BUFFDUR",
["Name"] = "Fury of Stormrage",
["Operator"] = "~=",
},
{
["Type"] = "HEALTH",
["Level"] = 50,
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = "<",
},
{
["Name"] = "None",
["Type"] = "STANCE",
},
{
["Type"] = "CASTING",
["Name"] = "Healing Touch",
["Level"] = 2,
},
{
["Name"] = "IsSpellKnown(414684)",
["Type"] = "LUA",
},
["n"] = 6,
},
["ManaCheck"] = true,
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1bS5PbSeqkud",
["Type"] = "cooldown",
["Name"] = "Wrath",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "None",
["Type"] = "STANCE",
},
{
["Type"] = "SPEED",
},
{
["Name"] = "IsSpellKnown(414684)",
["Type"] = "LUA",
},
["n"] = 3,
},
["ManaCheck"] = true,
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Claw",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Cat Form",
["Type"] = "STANCE",
},
{
["PrtsBefore"] = 1,
["Type"] = "COMBO",
["Level"] = 5,
["Operator"] = "<",
},
{
["PrtsAfter"] = 1,
["Type"] = "LUA",
["Name"] = "xTTD <= 7",
["AndOr"] = "OR",
},
{
["Name"] = "not xBehindTarget() and not IsSpellKnownOrOverridesKnown(407993)",
["Type"] = "LUA",
},
["n"] = 4,
},
["GUID"] = "TMW:icon:1YYs1I2bCNGy",
["States"] = {
{
},
nil,
{
["Color"] = "ffffffff",
["Alpha"] = 0,
},
{
["Color"] = "ffffffff",
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Mangle",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["PrtsBefore"] = 1,
["Type"] = "DEBUFFDUR",
["Name"] = "Mangle",
["Unit"] = "target",
},
{
["Type"] = "RAGE",
["Level"] = 65,
["AndOr"] = "OR",
["Operator"] = ">=",
},
{
["Type"] = "BUFFDUR",
["AndOr"] = "OR",
["Name"] = "Clearcasting",
["Operator"] = "~=",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Berserk",
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = "~=",
},
{
["Name"] = "Bear Form; Dire Bear Form",
["Type"] = "STANCE",
},
{
["PrtsBefore"] = 1,
["Type"] = "LUA",
["Name"] = "xAOE(10) < 3 and IsSpellKnownOrOverridesKnown(407995)",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Berserk",
["AndOr"] = "OR",
["PrtsAfter"] = 1,
["Operator"] = "~=",
},
["n"] = 7,
},
["GUID"] = "TMW:icon:1bStUtJWGryB",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Mangle",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Cat Form",
["Type"] = "STANCE",
},
{
["Name"] = "IsSpellKnownOrOverridesKnown(407993) and IsUsableSpell(407993)",
["Type"] = "LUA",
},
{
["Type"] = "COMBO",
["Name"] = "Mangle",
["PrtsBefore"] = 2,
["Level"] = 5,
["Unit"] = "target",
["Operator"] = "<",
},
{
["Type"] = "LUA",
["Name"] = "xTTD <= 20",
["AndOr"] = "OR",
},
{
["Type"] = "LUA",
["PrtsAfter"] = 1,
["Name"] = "not xBehindTarget()",
},
{
["PrtsBefore"] = 1,
["Type"] = "LUA",
["Name"] = "xBehindTarget()",
["AndOr"] = "OR",
},
{
["Type"] = "BUFFDUR",
["PrtsAfter"] = 2,
["Name"] = "Clearcasting",
},
["n"] = 7,
},
["GUID"] = "TMW:icon:1bcfSaepd_eV",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Rake",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Cat Form",
["Type"] = "STANCE",
},
{
["Checked"] = true,
["Type"] = "DEBUFFDUR",
["Name"] = "Rake",
["Unit"] = "target",
},
{
["Operator"] = "~=",
["Type"] = "DEBUFFDUR",
["Name"] = "Mangle",
["Unit"] = "target",
},
{
["Name"] = "xTTD > 0 or xTTD == -1",
["Type"] = "LUA",
},
{
["Name"] = "not xImmune(\"Rake\")",
["Type"] = "LUA",
},
["n"] = 5,
},
["GUID"] = "TMW:icon:1YZamy7DqjiW",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Shred",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Cat Form",
["Type"] = "STANCE",
},
{
["Name"] = "xBehindTarget()",
["Type"] = "LUA",
},
{
["Type"] = "COMBO",
["Level"] = 5,
["Operator"] = "<",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Clearcasting",
["Operator"] = "~=",
},
["n"] = 4,
},
["GUID"] = "TMW:icon:1YYv3MYeNeSM",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Rip",
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Cat Form",
["Type"] = "STANCE",
},
{
["Type"] = "COMBO",
["Level"] = 4,
["Operator"] = ">=",
},
{
["Checked"] = true,
["Type"] = "DEBUFFDUR",
["Name"] = "Rip",
["Unit"] = "target",
},
{
["Type"] = "LUA",
["Name"] = "xTTD > 20",
["Level"] = 10000,
["Operator"] = ">",
["Unit"] = "target",
},
["n"] = 4,
},
["GUID"] = "TMW:icon:1YaXVCdLMBa8",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Ferocious Bite",
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Cat Form",
["Type"] = "STANCE",
},
{
["Type"] = "COMBO",
["Level"] = 4,
["Operator"] = ">=",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1YbFYj2F1X0v",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Savage Roar",
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Cat Form",
["Type"] = "STANCE",
},
{
["PrtsBefore"] = 1,
["Type"] = "COMBO",
["Level"] = 4,
["Operator"] = ">=",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Savage Roar",
["Level"] = 5,
["PrtsAfter"] = 1,
["Operator"] = "<=",
},
{
["PrtsBefore"] = 1,
["Type"] = "COMBO",
["AndOr"] = "OR",
["Operator"] = ">",
},
{
["Type"] = "BUFFDUR",
["Checked"] = true,
["Name"] = "Savage Roar",
["Level"] = 5,
["PrtsAfter"] = 1,
["Operator"] = "<=",
},
["n"] = 5,
},
["GUID"] = "TMW:icon:1bT4fvYR_gWY",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1Z3Dak8Afvm1",
["Type"] = "cooldown",
["Name"] = "Pounce",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Cat Form",
["Type"] = "STANCE",
},
{
["Type"] = "EXISTS",
["Unit"] = "target",
},
{
["Type"] = "ALIVE",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Prowl",
["Operator"] = "~=",
},
["n"] = 5,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Nature's Grasp",
["ManaCheck"] = true,
["Conditions"] = {
{
["Type"] = "ISPLAYER",
["Unit"] = "target",
},
{
["Type"] = "ALIVE",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1ZJOZ6wmptif",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Mark of the Wild",
["GUID"] = "TMW:icon:1YXd9eWHzTSH",
["Conditions"] = {
{
["Name"] = "None",
["Type"] = "STANCE",
},
{
["Type"] = "BUFFDUR",
["Level"] = 5,
["Name"] = "Mark of the Wild",
["Operator"] = "<",
},
["n"] = 2,
},
["ManaCheck"] = true,
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Thorns",
["ManaCheck"] = true,
["Conditions"] = {
{
["Name"] = "None",
["Type"] = "STANCE",
},
{
["Type"] = "BUFFDUR",
["Level"] = 5,
["Name"] = "Thorns",
["Operator"] = "<",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1YXd9eWMwI0j",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1YatF3BT0RKW",
["Type"] = "cooldown",
["Name"] = "Faerie Fire (Feral)",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Bear Form; Cat Form; Dire Bear Form",
["Type"] = "STANCE",
},
{
["Type"] = "DEBUFFDUR",
["Name"] = "Faerie Fire (Feral)",
["Unit"] = "target",
},
{
["Name"] = "Prowl",
["Type"] = "BUFFDUR",
},
{
["Type"] = "LUA",
["Name"] = "not xImmune(\"Faerie Fire (Feral)\")",
["Level"] = 5,
["Unit"] = "target",
["Operator"] = "<=",
},
["n"] = 4,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1YawP4LcafCX",
["Type"] = "cooldown",
["Name"] = "Cower",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Name"] = "Cat Form",
["Type"] = "STANCE",
},
{
["Operator"] = ">=",
["Level"] = 85,
["Type"] = "THREATSCALED",
["Unit"] = "target",
},
{
["Type"] = "GROUP2",
["Checked"] = true,
["BitFlags"] = 1,
},
["n"] = 3,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Lifebloom",
["ManaCheck"] = true,
["Conditions"] = {
{
["Name"] = "Tree of Life",
["Type"] = "STANCE",
},
{
["Type"] = "EXISTS",
["Unit"] = "focus",
},
{
["Type"] = "ALIVE",
["Unit"] = "focus",
},
{
["Type"] = "REACT",
["Level"] = 2,
["Unit"] = "focus",
},
{
["Checked"] = true,
["Type"] = "BUFFDUR",
["Name"] = "Lifebloom",
["Unit"] = "focus",
},
{
["Name"] = "xInRange(40,\"focus\")",
["Type"] = "LUA",
},
["n"] = 6,
},
["GUID"] = "TMW:icon:1Zh6oeWTckKb",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Rejuvenation",
["ManaCheck"] = true,
["Conditions"] = {
{
["Name"] = "Tree of Life",
["Type"] = "STANCE",
},
{
["Type"] = "EXISTS",
["Unit"] = "focus",
},
{
["Type"] = "ALIVE",
["Unit"] = "focus",
},
{
["Type"] = "REACT",
["Level"] = 2,
["Unit"] = "focus",
},
{
["Checked"] = true,
["Type"] = "BUFFDUR",
["Name"] = "Rejuvenation",
["Unit"] = "focus",
},
{
["Name"] = "xInRange(40,\"focus\")",
["Type"] = "LUA",
},
["n"] = 6,
},
["GUID"] = "TMW:icon:1Zh6oeWXDH04",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1ZKevCddhaS_",
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
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1ZKevCdgnbud",
["Type"] = "buff",
["Name"] = "Poison",
["SettingsPerView"] = {
["icon"] = {
["TextLayout"] = "TMW:textlayout:1YXC4srUja8k",
},
},
["BuffOrDebuff"] = "HARMFUL",
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
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
},
{
["Name"] = "None",
["Type"] = "STANCE",
},
["n"] = 2,
},
["CustomTex"] = "29203",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
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
},
["n"] = 1,
},
["CustomTex"] = "5720",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["GUID"] = "TMW:group:1TWYPj24VzCn",
["Name"] = "Other",
["Point"] = {
["y"] = -22.2248075248809,
["x"] = -241.4639853189352,
},
["Icons"] = {
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1Z3Dak8Afvm1",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Scale"] = 1.477512240409851,
["Columns"] = 1,
["Alpha"] = 0,
["TextureName"] = "Details Flat",
},
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
},
{
["Type"] = "EXISTS",
["Unit"] = "target",
},
{
["Type"] = "ALIVE",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
{
["Type"] = "MOUNTED",
["Level"] = 1,
},
{
["Type"] = "STANCE",
["Name"] = "Tree of Life",
["AndOr"] = "OR",
},
["n"] = 6,
},
["Icons"] = {
"TMW:icon:1ZBi1G1Ik=8q",
"TMW:icon:1ZBi1G1LSN04",
"TMW:icon:1V6noP8ARoel",
"TMW:icon:1YXd9eWHzTSH",
"TMW:icon:1YXd9eWMwI0j",
"TMW:icon:1bSsu5MHaHu2",
"TMW:icon:1bSC7io0voSV",
"TMW:icon:1bSC7io0AGGu",
"TMW:icon:1bS5PbSeqkud",
"TMW:icon:1YatF3BT0RKW",
"TMW:icon:1TeVAjjavXC6",
"TMW:icon:1bT4fvYR_gWY",
"TMW:icon:1YbFYj2F1X0v",
"TMW:icon:1YaXVCdLMBa8",
"TMW:icon:1YZamy7DqjiW",
"TMW:icon:1YYv3MYeNeSM",
"TMW:icon:1YYs1I2bCNGy",
"TMW:icon:1bStUtJWGryB",
"TMW:icon:1bcfSaepd_eV",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1YXd9eWHzTSH",
"TMW:icon:1YXd9eWMwI0j",
"TMW:icon:1V6noP8ARoel",
"TMW:icon:1V6lsULwY3_Y",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["OnlyInCombat"] = true,
},
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
},
{
["Type"] = "EXISTS",
["Unit"] = "target",
},
{
["Type"] = "ALIVE",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
{
["Type"] = "MOUNTED",
["Level"] = 1,
},
{
["Type"] = "STANCE",
["Name"] = "Tree of Life",
["AndOr"] = "OR",
},
["n"] = 6,
},
["Icons"] = {
"TMW:icon:1ZBi1G1Ik=8q",
"TMW:icon:1ZBi1G1LSN04",
"TMW:icon:1V6noP8ARoel",
"TMW:icon:1YXd9eWHzTSH",
"TMW:icon:1YXd9eWMwI0j",
"TMW:icon:1bSsu5MHaHu2",
"TMW:icon:1bSC7io0voSV",
"TMW:icon:1bSC7io0AGGu",
"TMW:icon:1bS5PbSeqkud",
"TMW:icon:1YatF3BT0RKW",
"TMW:icon:1TeVAjjavXC6",
"TMW:icon:1bT4fvYR_gWY",
"TMW:icon:1YbFYj2F1X0v",
"TMW:icon:1YaXVCdLMBa8",
"TMW:icon:1YZamy7DqjiW",
"TMW:icon:1YYv3MYeNeSM",
"TMW:icon:1YYs1I2bCNGy",
"TMW:icon:1bStUtJWGryB",
"TMW:icon:1bcfSaepd_eV",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Type"] = "meta",
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["SortPriorities"] = {
{
["Order"] = -1,
},
},
["Name"] = "Rotation TOPLEFT",
["Locked"] = true,
["Point"] = {
["point"] = "TOPLEFT",
["relativePoint"] = "TOPLEFT",
},
["OnlyInCombat"] = true,
},
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
},
{
["Name"] = "return not IsAltKeyDown();",
["Type"] = "LUA",
},
{
["Type"] = "EXISTS",
["Unit"] = "target",
},
{
["Type"] = "ALIVE",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
["n"] = 5,
},
["Icons"] = {
"TMW:icon:1b4RXOJ1Gw40",
"TMW:icon:1TeVAjjXQ0WB",
"TMW:icon:1V6lsULwY3_Y",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["OnlyInCombat"] = true,
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
},
},
["Vermin - Zandalar Tribe"] = {
["Version"] = 110401,
},
["HUNTER"] = {
["Version"] = 110401,
["NumGroups"] = 5,
["TextureName"] = "xVerminClean",
["Groups"] = {
{
["Point"] = {
["y"] = -4.996173281900221,
["x"] = -0.0002605930177353105,
["point"] = "TOP",
["relativePoint"] = "TOP",
},
["Scale"] = 1.0008,
["Rows"] = 3,
["Locked"] = true,
["GUID"] = "TMW:group:1TeVAjjUoOOh",
["Columns"] = 20,
["Alpha"] = 0,
["Name"] = "SPELLS",
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
},
{
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Unit"] = "target",
["Name"] = "Serpent Sting",
["PrtsBefore"] = 1,
},
{
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["PrtsAfter"] = 1,
["Operator"] = "<=",
["AndOr"] = "OR",
["Unit"] = "target",
["Name"] = "Serpent Sting",
["Level"] = 0.2,
},
{
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Unit"] = "target",
["Name"] = "Viper Sting",
},
{
["Type"] = "CASTING",
["Name"] = "Mend Pet",
["Level"] = 2,
},
{
["Type"] = "LUA",
["Name"] = "(xTTD == -1 or xTTD > 6) and IsSpellInRange(\"Serpent Sting\", \"target\") and not xImmune(\"Serpent Sting\")",
},
["n"] = 6,
},
["GUID"] = "TMW:icon:1TeVAjjXQ0WB",
["States"] = {
{
},
{
["Alpha"] = 1,
},
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
},
{
["Type"] = "cooldown",
["Name"] = "Arcane Shot",
["GUID"] = "TMW:icon:1V6lsULwY3_Y",
["ManaCheck"] = true,
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "MANA",
["Operator"] = ">=",
["Name"] = "Explosive Shot",
["Level"] = 50,
},
{
["Type"] = "CASTING",
["Name"] = "Mend Pet",
["Level"] = 2,
},
{
["Type"] = "LUA",
["Name"] = "-- xGetRange() >= 8\nIsSpellInRange(\"Arcane Shot\", \"target\") and not xImmune(\"Arcane Shot\")",
},
["n"] = 3,
},
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
},
{
["Type"] = "cooldown",
["Name"] = "Multi-Shot",
["ManaCheck"] = true,
["GUID"] = "TMW:icon:1YS2u64Alj4P",
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "MANA",
["Operator"] = ">=",
["Name"] = "xBehindTarget() and xGetRange() >= 8",
["Level"] = 50,
},
{
["Type"] = "SPEED",
},
{
["Type"] = "LUA",
["Name"] = "xBehindTarget() and IsSpellInRange(\"Multi-Shot\", \"target\")",
},
["n"] = 3,
},
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
},
{
["Type"] = "cooldown",
["Name"] = "Chimera Shot",
["GUID"] = "TMW:icon:1bUm6EYv4OSE",
["Conditions"] = {
{
["Type"] = "SPELLCD",
["Operator"] = "<=",
["Name"] = "Chimera Shot",
["Level"] = 0.6,
},
{
["Type"] = "MANA",
["Operator"] = ">=",
["Name"] = "Explosive Shot",
["Level"] = 15,
},
{
["Type"] = "CASTING",
["Name"] = "Mend Pet",
["Level"] = 2,
},
{
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Unit"] = "target",
["Operator"] = ">=",
["Name"] = "Serpent Sting",
["PrtsBefore"] = 1,
["Level"] = 1,
},
{
["Type"] = "LUA",
["PrtsAfter"] = 1,
["Name"] = "xImmune(\"Serpent Sting\")",
["AndOr"] = "OR",
},
{
["Type"] = "LUA",
["Name"] = "not xImmune(\"Chimera Shot\")",
},
["n"] = 6,
},
["ManaCheck"] = true,
["States"] = {
{
},
{
["Alpha"] = 1,
},
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
["Enabled"] = true,
},
{
["Type"] = "cooldown",
["Name"] = "Explosive Shot",
["GUID"] = "TMW:icon:1bUm6EYv_P02",
["Conditions"] = {
{
["Type"] = "MANA",
["Operator"] = ">=",
["Name"] = "Explosive Shot",
},
{
["Type"] = "CASTING",
["Name"] = "Mend Pet",
["Level"] = 2,
},
["n"] = 2,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
["Enabled"] = true,
},
{
["Type"] = "cooldown",
["Name"] = "Kill Command",
["ManaCheck"] = true,
["GUID"] = "TMW:icon:1bX1IpjvoyWh",
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "MANA",
["Operator"] = ">=",
["Name"] = "Explosive Shot",
},
{
["Type"] = "CASTING",
["Name"] = "Mend Pet",
["Level"] = 2,
},
["n"] = 2,
},
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Type"] = "cooldown",
["Name"] = "Bestial Wrath",
["GUID"] = "TMW:icon:1bylVkrAep8k",
["Conditions"] = {
{
["Type"] = "REACT",
["Unit"] = "target",
["Level"] = 1,
},
{
["Type"] = "ISPLAYER",
["Unit"] = "target",
},
["n"] = 2,
},
["States"] = {
{
},
nil,
{
},
{
},
},
["Enabled"] = true,
},
{
["Type"] = "cooldown",
["Name"] = "Intimidation",
["GUID"] = "TMW:icon:1bylVkrBRZaw",
["Conditions"] = {
{
["Type"] = "REACT",
["Unit"] = "target",
["Level"] = 1,
},
{
["Type"] = "ISPLAYER",
["Unit"] = "target",
},
["n"] = 2,
},
["States"] = {
{
},
nil,
{
},
{
},
},
["Enabled"] = true,
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Type"] = "cooldown",
["Name"] = "Explosive Trap",
["Enabled"] = true,
["GUID"] = "TMW:icon:1ZlhdlmrsoGF",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
},
},
["Conditions"] = {
{
["Type"] = "DEBUFFDUR",
["Checked"] = true,
["Unit"] = "target",
["Name"] = "Explosive Trap",
},
{
["Type"] = "LUA",
["Name"] = "xInRange(0,\"target\",\"min\") -- and xBehindTarget()",
},
["n"] = 2,
},
},
{
["Unit"] = "pet",
["Type"] = "cooldown",
["Name"] = "Mend Pet",
["GUID"] = "TMW:icon:1X=OmHlbqz67",
["ManaCheck"] = true,
["Conditions"] = {
{
["Type"] = "HEALTH",
["Unit"] = "pet",
["Operator"] = "<=",
["Level"] = 40,
},
{
["Type"] = "BUFFDUR",
["Checked"] = true,
["Unit"] = "pet",
["Name"] = "Mend Pet",
},
{
["Type"] = "EXISTS",
["Unit"] = "pet",
},
{
["Type"] = "ALIVE",
["Unit"] = "pet",
},
{
["Type"] = "SPEED",
},
["n"] = 5,
},
["Enabled"] = true,
["SettingsPerView"] = {
["icon"] = {
["TextLayout"] = "icon1",
["Texts"] = {
"",
"",
},
},
},
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
},
{
["BuffOrDebuff"] = "EITHER",
["Unit"] = "target",
["Type"] = "buff",
["Name"] = "Enraged",
["GUID"] = "TMW:icon:1ZuahEVFckqw",
["ManaCheck"] = true,
["CustomTex"] = "19801",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
["Enabled"] = true,
},
{
["Type"] = "cooldown",
["Name"] = "Aimed Shot",
["GUID"] = "TMW:icon:1ZDQ16jnm6W=",
["ManaCheck"] = true,
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "PTSINTAL",
["Name"] = "Chimera Shot",
["PrtsBefore"] = 1,
["AndOr"] = "OR",
},
{
["Type"] = "PTSINTAL",
["Operator"] = ">",
["Name"] = "Chimera Shot",
["PrtsBefore"] = 1,
["AndOr"] = "OR",
},
{
["Type"] = "SPELLCD",
["PrtsAfter"] = 2,
["Operator"] = "~=",
["Name"] = "Chimera Shot",
},
{
["Type"] = "SPELLCD",
["Operator"] = "<=",
["Name"] = "Aimed Shot",
["Level"] = 1,
},
{
["Type"] = "LUA",
["Name"] = "not xBehindTarget()",
},
["n"] = 5,
},
["States"] = {
{
},
{
["Alpha"] = 1,
},
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
},
{
["Type"] = "cooldown",
["Name"] = "Concussive Shot",
["ManaCheck"] = true,
["GUID"] = "TMW:icon:1ZDRwPNU7Z0Z",
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "THREATSCALED",
["Operator"] = ">=",
["Unit"] = "target",
["PrtsBefore"] = 1,
["Level"] = 99,
},
{
["Type"] = "SPEED",
["Unit"] = "target",
["Operator"] = ">",
["Level"] = 64,
},
{
["Type"] = "LUA",
["PrtsAfter"] = 1,
["Name"] = "not xImmune(\"Concussive Shot\")",
},
{
["Type"] = "ISPLAYER",
["Unit"] = "target",
["AndOr"] = "OR",
},
["n"] = 4,
},
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
},
{
["Type"] = "cooldown",
["Name"] = "Trueshot Aura",
["Enabled"] = true,
["GUID"] = "TMW:icon:1ZDQ16jpl=uP",
["States"] = {
{
},
nil,
{
},
{
},
},
["Conditions"] = {
{
["Type"] = "BUFFDUR",
["Name"] = "Trueshot Aura",
},
["n"] = 1,
},
},
{
["Type"] = "cooldown",
["Name"] = "Deterrence",
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "HEALTH",
["Operator"] = "<=",
["Level"] = 20,
},
{
["Type"] = "CASTING",
["Name"] = "Mend Pet",
["Level"] = 2,
},
["n"] = 2,
},
["ManaCheck"] = true,
["GUID"] = "TMW:icon:1ZDQ16jrgNie",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Type"] = "cooldown",
["Name"] = "Carve",
["GUID"] = "TMW:icon:1c0PDduo4KeH",
["Conditions"] = {
{
["Type"] = "LUA",
["Name"] = "xInRange(5,\"target\",\"max\") and xAOE(10) > 1",
},
{
["Type"] = "MANA",
["Operator"] = ">=",
["Level"] = 40,
},
["n"] = 2,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
["Enabled"] = true,
},
{
["Type"] = "cooldown",
["Name"] = "Flanking Strike",
["GUID"] = "TMW:icon:1bVNaN3WNJKD",
["ManaCheck"] = true,
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "LUA",
["Name"] = "xInRange(5,\"target\",\"max\")",
},
{
["Type"] = "MANA",
["Operator"] = ">=",
},
{
["Type"] = "CASTING",
["Name"] = "Mend Pet",
["Level"] = 2,
},
["n"] = 3,
},
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
},
{
["Type"] = "cooldown",
["Name"] = "Wing Clip",
["ManaCheck"] = true,
["GUID"] = "TMW:icon:1ZEKCuryiveD",
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "DEBUFFDUR",
["Unit"] = "target",
["Name"] = "Wing Clip",
["PrtsBefore"] = 1,
},
{
["Type"] = "SPEED",
["Unit"] = "target",
["Operator"] = ">",
["Level"] = 64,
},
{
["Type"] = "LUA",
["PrtsAfter"] = 1,
["Name"] = "xInRange(5,\"target\",\"max\")",
},
{
["Type"] = "BUFFDUR",
["Operator"] = "~=",
["Name"] = "Aspect of the Viper",
["PrtsBefore"] = 1,
["AndOr"] = "OR",
},
{
["Type"] = "SPELLCD",
["Operator"] = ">=",
["Name"] = "Raptor Strike",
["Level"] = 1.3,
},
{
["Type"] = "SPELLCD",
["Operator"] = ">",
["Name"] = "Flanking Strike",
["Level"] = 2,
},
{
["Type"] = "LUA",
["PrtsAfter"] = 1,
["Name"] = "xInRange(5,\"target\",\"max\")",
},
{
["Type"] = "ISPLAYER",
["Unit"] = "target",
["PrtsBefore"] = 1,
["AndOr"] = "OR",
},
{
["Type"] = "DEBUFFDUR",
["PrtsAfter"] = 1,
["Unit"] = "target",
["Name"] = "Wing Clip",
},
{
["Type"] = "CASTING",
["Name"] = "Mend Pet",
["Level"] = 2,
},
["n"] = 10,
},
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
},
{
["Type"] = "cooldown",
["Name"] = "Mongoose Bite",
["ManaCheck"] = true,
["GUID"] = "TMW:icon:1bW6OhXywJms",
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "MANA",
["Operator"] = ">=",
},
{
["Type"] = "REACTIVE",
["Name"] = "Mongoose Bite",
},
{
["Type"] = "LUA",
["Name"] = "xInRange(5,\"target\",\"max\")",
},
{
["Type"] = "CASTING",
["Name"] = "Mend Pet",
["Level"] = 2,
},
["n"] = 4,
},
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
},
{
["Type"] = "cooldown",
["Name"] = "Raptor Strike",
["GUID"] = "TMW:icon:1ayCWLUPE1CN",
["Conditions"] = {
{
["Type"] = "CURRENTSPELL",
["Unit"] = "target",
["Name"] = "Raptor Strike",
["Level"] = 1,
},
{
["Type"] = "MANA",
["Operator"] = ">=",
},
{
["Type"] = "LUA",
["Name"] = "xInRange(5,\"target\",\"max\")",
},
{
["Type"] = "CASTING",
["Name"] = "Mend Pet",
["Level"] = 2,
},
["n"] = 4,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
["Enabled"] = true,
},
{
["CLEUEvents"] = {
[""] = true,
},
["Type"] = "cooldown",
["BarDisplay_BarGCD"] = true,
["Name"] = "Feign Death",
["Enabled"] = true,
["ClockGCD"] = true,
["GUID"] = "TMW:icon:1a_1UgKk_YW1",
["States"] = {
{
},
nil,
{
},
{
},
},
["Conditions"] = {
{
["Type"] = "LUA",
["Name"] = "xThreat() > 80",
},
["n"] = 1,
},
},
{
["CLEUEvents"] = {
[""] = true,
},
["Type"] = "cooldown",
["BarDisplay_BarGCD"] = true,
["Name"] = "Disengage",
["GUID"] = "TMW:icon:1b7_I0LR89Wq",
["ManaCheck"] = true,
["ClockGCD"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "LUA",
["Name"] = "xThreat() > 70 and xInRange(5,\"target\",\"max\")",
},
{
["Type"] = "GROUP2",
["Checked"] = true,
["BitFlags"] = 1,
["PrtsBefore"] = 1,
},
{
["Type"] = "GROUP2",
["BitFlags"] = 1,
["PrtsBefore"] = 1,
["AndOr"] = "OR",
},
{
["Type"] = "EXISTS",
["Unit"] = "pet",
},
{
["Type"] = "ALIVE",
["PrtsAfter"] = 2,
["Unit"] = "pet",
},
["n"] = 5,
},
["Enabled"] = true,
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Type"] = "cooldown",
["Name"] = "Auto Shot",
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "SPEED",
},
{
["Type"] = "LUA",
["Name"] = "-- select min range, 2 is max range\n-- select(1, xGetRange(\"target\")) >= 8\nInCombatLockdown() and not IsCurrentSpell(75) and \nIsSpellInRange(\"Arcane Shot\", \"target\")",
},
{
["Type"] = "CASTING",
["Name"] = "Mend Pet",
["Level"] = 2,
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1b0R_gF9ykyh",
["CustomTex"] = "6660",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
["Alpha"] = 0,
},
{
},
},
["RangeCheck"] = true,
},
{
["Type"] = "cooldown",
["Name"] = "Attack",
["GUID"] = "TMW:icon:1bVNN3giHs4I",
["Enabled"] = true,
["CustomTex"] = "6660",
["States"] = {
{
["Alpha"] = 0.01,
},
nil,
{
["Alpha"] = 0,
},
{
},
},
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "SPEED",
},
{
["Type"] = "LUA",
["Name"] = "-- select min range, 2 is max range\n-- select(1, xGetRange(\"target\")) >= 8\nInCombatLockdown() and not IsCurrentSpell(6603) and not\nIsSpellInRange(\"Arcane Shot\", \"target\")",
},
{
["Type"] = "CASTING",
["Name"] = "Mend Pet",
["Level"] = 2,
},
["n"] = 3,
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Unit"] = "pet",
["Type"] = "buff",
["Name"] = "Frenzy Effect",
["ShowTimerText"] = true,
["GUID"] = "TMW:icon:1b9KipSFhwqo",
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Type"] = "cooldown",
["Name"] = "1742",
["Enabled"] = true,
["GUID"] = "TMW:icon:1ZG0cMPPKbCD",
["States"] = {
{
},
nil,
{
},
{
},
},
["Conditions"] = {
{
["Type"] = "HEALTH",
["Operator"] = "<=",
["Unit"] = "pet",
["Level"] = 40,
},
{
["Type"] = "EXISTS",
["Unit"] = "pet",
},
{
["Type"] = "ALIVE",
["Unit"] = "pet",
},
["n"] = 3,
},
},
},
},
{
["Point"] = {
["y"] = -34.5806684942859,
["x"] = -248.5259315440971,
},
["Scale"] = 1.4,
["TextureName"] = "Details Flat",
["OnlyInCombat"] = true,
["Columns"] = 1,
["Icons"] = {
{
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1a_1UgKk_YW1",
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Name"] = "OTHER",
["GUID"] = "TMW:group:1TWYPj24VzCn",
},
{
["Point"] = {
["y"] = -130,
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
"TMW:icon:1ZBi1G1Ik=8q",
"TMW:icon:1ZBi1G1LSN04",
"TMW:icon:1b0R_gF9ykyh",
"TMW:icon:1bVNN3giHs4I",
"TMW:icon:1b7_I0LR89Wq",
"TMW:icon:1bylVkrBRZaw",
"TMW:icon:1bylVkrAep8k",
"TMW:icon:1ZDRwPNU7Z0Z",
"TMW:icon:1X=OmHlbqz67",
"TMW:icon:1ZuahEVFckqw",
"TMW:icon:1TeVAjjXQ0WB",
"TMW:icon:1ZDQ16jnm6W=",
"TMW:icon:1bUm6EYv4OSE",
"TMW:icon:1bUm6EYv_P02",
"TMW:icon:1bX1IpjvoyWh",
"TMW:icon:1YS2u64Alj4P",
"TMW:icon:1V6lsULwY3_Y",
"TMW:icon:1bW6OhXywJms",
"TMW:icon:1ZEKCuryiveD",
"TMW:icon:1bVNaN3WNJKD",
"TMW:icon:1ayCWLUPE1CN",
"TMW:icon:1c0PDduo4KeH",
},
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "MOUNTED",
["Level"] = 1,
},
{
["Type"] = "EXISTS",
["Unit"] = "target",
},
{
["Type"] = "ALIVE",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Unit"] = "target",
["Level"] = 1,
},
{
["Type"] = "BUFFDUR",
["Name"] = "Feign Death",
},
{
["Type"] = "LUA",
["Name"] = "not IsAltKeyDown() and not UnitInVehicle(\"player\")",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Food",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Drink",
},
["n"] = 8,
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1X=OmHlbqz67",
"TMW:icon:1YYUluwZXp0V",
"TMW:icon:1YS2u64Alj4P",
"TMW:icon:1YS2u64Csf0H",
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1X=OmHlbqz67",
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Name"] = "ROTATION CENTER",
["GUID"] = "TMW:group:1TeVDtajUwqa",
},
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
"TMW:icon:1ZBi1G1Ik=8q",
"TMW:icon:1ZBi1G1LSN04",
"TMW:icon:1b0R_gF9ykyh",
"TMW:icon:1bVNN3giHs4I",
"TMW:icon:1b7_I0LR89Wq",
"TMW:icon:1bylVkrBRZaw",
"TMW:icon:1bylVkrAep8k",
"TMW:icon:1ZDRwPNU7Z0Z",
"TMW:icon:1X=OmHlbqz67",
"TMW:icon:1ZuahEVFckqw",
"TMW:icon:1TeVAjjXQ0WB",
"TMW:icon:1ZDQ16jnm6W=",
"TMW:icon:1bUm6EYv4OSE",
"TMW:icon:1bUm6EYv_P02",
"TMW:icon:1bX1IpjvoyWh",
"TMW:icon:1YS2u64Alj4P",
"TMW:icon:1V6lsULwY3_Y",
"TMW:icon:1bW6OhXywJms",
"TMW:icon:1ZEKCuryiveD",
"TMW:icon:1bVNaN3WNJKD",
"TMW:icon:1ayCWLUPE1CN",
"TMW:icon:1c0PDduo4KeH",
},
["Enabled"] = true,
["Conditions"] = {
{
["Type"] = "MOUNTED",
["Level"] = 1,
},
{
["Type"] = "EXISTS",
["Unit"] = "target",
},
{
["Type"] = "ALIVE",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Unit"] = "target",
["Level"] = 1,
},
{
["Type"] = "BUFFDUR",
["Name"] = "Feign Death",
},
{
["Type"] = "LUA",
["Name"] = "not IsAltKeyDown() and not UnitInVehicle(\"player\")",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Food",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Drink",
},
["n"] = 8,
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Name"] = "ROTATION TOPLEFT",
["GUID"] = "TMW:group:1YWH=DtwTpKV",
},
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
"TMW:icon:1a_1UgKk_YW1",
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Name"] = "OFFGCD",
["GUID"] = "TMW:group:1ZNbDZWSALqf",
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
},
["Locked"] = true,
},
["Vermin - Celebras"] = {
["Version"] = 110401,
},
["Battlenac - Zandalar Tribe"] = {
["Version"] = 110301,
},
["PALADIN"] = {
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
["Name"] = "Righteous Fury",
["Conditions"] = {
{
["Type"] = "BUFFDUR",
["Checked"] = true,
["Name"] = "Righteous Fury",
},
{
["Type"] = "SPEC",
["Level"] = 2,
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1ZmhO7mqKue=",
["States"] = {
{
},
nil,
{
},
{
},
},
},
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
},
{
["Type"] = "EXISTS",
["Unit"] = "focus",
},
{
["Type"] = "BUFFDUR",
["Name"] = "Beacon of Light",
["Unit"] = "focus",
},
["n"] = 3,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Holy Light",
["Conditions"] = {
{
["Type"] = "SPEC",
["Level"] = 2,
},
{
["Type"] = "EXISTS",
["Unit"] = "mouseover",
},
{
["Operator"] = "<",
["Level"] = 90,
["Type"] = "HEALTH",
["Unit"] = "mouseover",
},
{
["Type"] = "REACT",
["Level"] = 2,
["Unit"] = "mouseover",
},
{
["Type"] = "SPEED",
},
["n"] = 5,
},
["GUID"] = "TMW:icon:1Z_AGSGa0teP",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Divine Plea",
["Conditions"] = {
{
["Type"] = "MANA",
["Level"] = 60,
["Operator"] = "<=",
},
["n"] = 1,
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Divine Shield",
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 30,
["Operator"] = "<=",
},
{
["Name"] = "Forbearance",
["Type"] = "DEBUFFDUR",
},
["n"] = 2,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
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
},
["n"] = 1,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
["n"] = 1,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "EXISTS",
["Unit"] = "mouseover",
},
{
["Name"] = "xInRange(30,\"mouseover\")",
["Type"] = "LUA",
},
["n"] = 3,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "MANA",
["Level"] = 45,
["Operator"] = ">=",
},
{
["Name"] = "xInRange(2)",
["Type"] = "LUA",
},
{
["Type"] = "CREATURETYPE",
["Name"] = "Demon; Undead",
["Unit"] = "target",
},
["n"] = 4,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Hammer of Wrath",
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "SPEC",
["Level"] = 2,
},
{
["Operator"] = "<=",
["Level"] = 20,
["Type"] = "HEALTH",
["Unit"] = "target",
},
{
["Type"] = "MANA",
["Level"] = 15,
["Operator"] = ">=",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1ZkmyyWZapS_",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
["n"] = 1,
},
["CustomTex"] = "4987",
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Holy Shield",
["ManaCheck"] = true,
["Conditions"] = {
{
["Type"] = "SPEC",
["Level"] = 2,
},
{
["Name"] = "Holy Shield",
["Type"] = "BUFFDUR",
},
{
["Type"] = "MANA",
["Level"] = 15,
["Operator"] = ">=",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1YXd9eWHzTSH",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
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
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1YXd9eWMwI0j",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "SPEC",
["Level"] = 2,
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1YatF3BT0RKW",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "SPEC",
["Level"] = 2,
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1YawP4LcafCX",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1Z6tL7hXaSCZ",
["Type"] = "cooldown",
["Name"] = "Exorcism",
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "SPEC",
["Level"] = 2,
},
["n"] = 1,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Name"] = "Forbearance",
["Type"] = "DEBUFFDUR",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1Z6tL7hZeq4n",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "buff",
["BuffOrDebuff"] = "HARMFUL",
["ManaCheck"] = true,
["Name"] = "Poison; Disease; Magic",
["SettingsPerView"] = {
["icon"] = {
["Texts"] = {
"",
"",
},
},
},
["GUID"] = "TMW:icon:1Z6tL7hbgPqi",
["Conditions"] = {
{
["Name"] = "xBehindTarget()",
["Type"] = "LUA",
},
["n"] = 1,
},
["CustomTex"] = "4987",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Name"] = "Forbearance",
["Type"] = "DEBUFFDUR",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1Z6tL7hdj2mo",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["Enabled"] = true,
["Type"] = "cooldown",
["Name"] = "Consecration",
["ManaCheck"] = true,
["Conditions"] = {
{
["Name"] = "xAOE(10) > 0 and xInRange(2)",
["Type"] = "LUA",
},
{
["Type"] = "SPEC",
["Level"] = 2,
},
{
["Type"] = "MANA",
["Level"] = 15,
["Operator"] = ">=",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1Z6tL7hfkyqu",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "SPEC",
["Level"] = 2,
},
{
["Name"] = "xAOE(10) > 1",
["Type"] = "LUA",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1Z6uOhVXfBCq",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
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
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1ZknB6Qckg8U",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
},
},
},
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
},
{
["Type"] = "SPEC",
["Level"] = 2,
},
{
["PrtsBefore"] = 1,
["Type"] = "LEVEL",
["Level"] = -1,
["Unit"] = "target",
},
{
["Type"] = "LEVEL",
["AndOr"] = "OR",
["Level"] = 83,
["PrtsAfter"] = 1,
["Unit"] = "target",
},
["n"] = 4,
},
["GUID"] = "TMW:icon:1ZkmyynlJgaL",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
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
},
["n"] = 1,
},
["CustomTex"] = "5720",
["States"] = {
{
},
nil,
{
},
{
},
},
},
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
},
["n"] = 1,
},
["CustomTex"] = "28491",
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Name"] = "PALADIN SPELLS",
["Locked"] = true,
["Columns"] = 20,
["Alpha"] = 0,
},
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
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Scale"] = 1.5,
["Columns"] = 1,
["Alpha"] = 0,
["TextureName"] = "Details Flat",
},
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
},
{
["Type"] = "EXISTS",
["Unit"] = "target",
},
{
["Type"] = "ALIVE",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
{
["Type"] = "MOUNTED",
["Level"] = 1,
},
["n"] = 6,
},
["Icons"] = {
"TMW:icon:1ZmhsoGZsuaJ",
"TMW:icon:1ZmhsoDa4SWt",
"TMW:icon:1ZmhO7mqKue=",
"TMW:icon:1Z6tL7hZeq4n",
"TMW:icon:1Z_AGSGa0teP",
"TMW:icon:1ZwdlWxY789W",
"TMW:icon:1Z6tL7hbgPqi",
"TMW:icon:1ZkmyyWWPpGC",
"TMW:icon:1ZkmyyWZapS_",
"TMW:icon:1YXd9eWMwI0j",
"TMW:icon:1Z6tL7hfkyqu",
"TMW:icon:1ZkmyyWX_u4d",
"TMW:icon:1YXd9eWHzTSH",
"TMW:icon:1ZkmyyWS_emA",
"TMW:icon:1ZkmyyWUmDSs",
"TMW:icon:1Ztb9RIdmLi9",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1YXd9eWHzTSH",
"TMW:icon:1YXd9eWMwI0j",
"TMW:icon:1V6noP8ARoel",
"TMW:icon:1V6lsULwY3_Y",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["OnlyInCombat"] = true,
},
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
},
{
["Type"] = "EXISTS",
["Unit"] = "target",
},
{
["Type"] = "ALIVE",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
{
["Type"] = "MOUNTED",
["PrtsAfter"] = 1,
["Level"] = 1,
},
{
["Type"] = "SPEC",
["Level"] = 1,
["AndOr"] = "OR",
},
["n"] = 6,
},
["Icons"] = {
"TMW:icon:1ZmhsoGZsuaJ",
"TMW:icon:1ZmhsoDa4SWt",
"TMW:icon:1ZmhO7mqKue=",
"TMW:icon:1Z6tL7hZeq4n",
"TMW:icon:1Z_AGSGa0teP",
"TMW:icon:1ZwdlWxY789W",
"TMW:icon:1Z6tL7hbgPqi",
"TMW:icon:1ZkmyyWWPpGC",
"TMW:icon:1ZkmyyWZapS_",
"TMW:icon:1YXd9eWMwI0j",
"TMW:icon:1Z6tL7hfkyqu",
"TMW:icon:1ZkmyyWX_u4d",
"TMW:icon:1YXd9eWHzTSH",
"TMW:icon:1ZkmyyWS_emA",
"TMW:icon:1ZkmyyWUmDSs",
"TMW:icon:1Ztb9RIdmLi9",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Type"] = "meta",
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["OnlyInCombat"] = true,
},
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
},
["n"] = 1,
},
["Icons"] = {
"TMW:icon:1Z6tL7hdj2mo",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["Point"] = {
["y"] = -9.187387125994171e-05,
["x"] = 30,
["point"] = "TOPLEFT",
["relativePoint"] = "TOPLEFT",
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
},
["Version"] = 100900,
["NumGroups"] = 5,
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
},
{
["Name"] = "Power Word: Shield",
["Type"] = "BUFFDUR",
},
{
["Type"] = "HEALTH",
["Level"] = 90,
["Operator"] = "<",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1a7jsucSi0aE",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "EXISTS",
["Unit"] = "mouseover",
},
{
["Type"] = "ALIVE",
["Unit"] = "mouseover",
},
{
["Type"] = "REACT",
["Level"] = 2,
["Unit"] = "mouseover",
},
{
["Type"] = "CURRENTSPELL",
["Name"] = "Heal",
["Level"] = 1,
},
["n"] = 5,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["GUID"] = "TMW:icon:1a7l2flZcXmn",
["Type"] = "cooldown",
["Name"] = "Renew",
["Enabled"] = true,
["Conditions"] = {
{
["Name"] = "Renew",
["Type"] = "BUFFDUR",
},
{
["Type"] = "HEALTH",
["Level"] = 90,
["Operator"] = "<",
},
["n"] = 2,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Unit"] = "mouseover",
["Level"] = 90,
["Type"] = "HEALTH",
["Operator"] = "<",
},
{
["Type"] = "EXISTS",
["Unit"] = "mouseover",
},
{
["Type"] = "ALIVE",
["Unit"] = "mouseover",
},
{
["Type"] = "REACT",
["Level"] = 2,
["Unit"] = "mouseover",
},
["n"] = 5,
},
["GUID"] = "TMW:icon:1a9jdXHzXsKe",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Void Plague",
["GUID"] = "TMW:icon:1bgbqMf2PcOe",
["RangeCheck"] = true,
["Conditions"] = {
{
["Checked"] = true,
["Type"] = "DEBUFFDUR",
["Name"] = "Void Plague",
["Unit"] = "target",
},
{
["Type"] = "CREATURETYPE",
["Level"] = 1,
["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
{
["Name"] = "xTTD > -10 and IsSpellKnownOrOverridesKnown(425204)",
["Type"] = "LUA",
},
["n"] = 4,
},
["Enabled"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Homunculi",
["Enabled"] = true,
["RangeCheck"] = true,
["Conditions"] = {
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
{
["Name"] = "xTTD > -10 and IsSpellKnownOrOverridesKnown(402799)",
["Type"] = "LUA",
},
["n"] = 2,
},
["GUID"] = "TMW:icon:1bg_BJk9vseP",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["ManaCheck"] = true,
["Type"] = "buff",
["BuffOrDebuff"] = "HARMFUL",
["Unit"] = "mouseover",
["Name"] = "Magic",
["Enabled"] = true,
["GUID"] = "TMW:icon:1a9ihU2QC18O",
["Conditions"] = {
{
["Type"] = "EXISTS",
["Name"] = "magi",
["Unit"] = "mouseover",
},
{
["Type"] = "ALIVE",
["Unit"] = "mouseover",
["Operator"] = "<",
},
{
["Type"] = "REACT",
["Level"] = 2,
["Unit"] = "mouseover",
},
["n"] = 3,
},
["CustomTex"] = "527",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Name"] = "InCombatLockdown() and not IsCurrentSpell(5019)",
["Type"] = "LUA",
},
{
["Type"] = "SPEED",
},
["n"] = 3,
},
["CustomTex"] = "6660",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
["Alpha"] = 0,
},
{
},
},
},
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
},
{
["Type"] = "CREATURETYPE",
["Level"] = 1,
["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
{
["Name"] = "xTTD > -10",
["Type"] = "LUA",
},
["n"] = 4,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "CREATURETYPE",
["Level"] = 1,
["Name"] = "Totem; Non-combat Pet; Gas Cloud; Critter",
["Unit"] = "target",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
["n"] = 3,
},
["GUID"] = "TMW:icon:1a9kNk57eWOn",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "SPEED",
},
{
["Type"] = "CURRENTSPELL",
["Name"] = "Mind Flay",
["Level"] = 1,
},
{
["Unit"] = "target",
["Type"] = "DEBUFFDUR",
["Name"] = "Shadow Word: Pain",
["Operator"] = "~=",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
["n"] = 5,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "SPEED",
},
{
["Type"] = "CURRENTSPELL",
["Name"] = "Mind Blast",
["Level"] = 1,
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
{
["Name"] = "xTTD > 1",
["Type"] = "LUA",
},
["n"] = 5,
},
["GUID"] = "TMW:icon:1a7l2fmgZwCv",
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "target",
},
["n"] = 2,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["GUID"] = "TMW:icon:1a7lUEjXAASn",
["Type"] = "cooldown",
["Name"] = "Inner Fire",
["Enabled"] = true,
["Conditions"] = {
{
["Name"] = "Inner Fire",
["Type"] = "BUFFDUR",
},
["n"] = 1,
},
["ManaCheck"] = true,
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
{
["ManaCheck"] = true,
["Type"] = "cooldown",
["Name"] = "Power Word: Fortitude",
["Enabled"] = true,
["Conditions"] = {
{
["Name"] = "Power Word: Fortitude",
["Type"] = "BUFFDUR",
},
["n"] = 1,
},
["GUID"] = "TMW:icon:1a8KSxK3rF0S",
["States"] = {
{
},
nil,
{
},
{
["Alpha"] = 0,
},
},
},
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
},
{
["Type"] = "EXISTS",
["Unit"] = "mouseover",
},
{
["Type"] = "REACT",
["Level"] = 1,
["Unit"] = "mouseover",
},
{
["Type"] = "ALIVE",
["Unit"] = "mouseover",
},
{
["Name"] = "xInRange(30,\"mouseover\")",
["Type"] = "LUA",
},
["n"] = 5,
},
["GUID"] = "TMW:icon:1a7lUEjf6xOH",
["States"] = {
{
["Alpha"] = 0,
},
nil,
{
["Alpha"] = 0,
},
{
["Alpha"] = 0,
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "item",
["Name"] = "33447; 43531; 22829; 929; 13446; 33092; 3928; 39671; 43569; 858; 1710; 118; 28100; 32947; 4596; 33934; 31853; 18839; 31839; 31852; 23822; 31838; 32905",
["States"] = {
{
},
nil,
{
},
{
},
},
["GUID"] = "TMW:icon:1a7lUElf_=Se",
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 40,
["Operator"] = "<=",
},
["n"] = 1,
},
["CustomTex"] = "29203",
["OnlyInBags"] = true,
},
{
["Enabled"] = true,
["Type"] = "item",
["Name"] = "22105; 22103; 22104; 36892; 5509; 5512; 36894; 19013; 36893; 36891; 36890; 19009; 19004; 19012; 5510; 19007; 19005; 19006; 19010; 36889; 5511; 19008; 9421; 19011",
["States"] = {
{
},
nil,
{
},
{
},
},
["GUID"] = "TMW:icon:1a7lUElnNLeF",
["Conditions"] = {
{
["Type"] = "HEALTH",
["Level"] = 65,
["Operator"] = "<=",
},
["n"] = 1,
},
["CustomTex"] = "5720",
["OnlyInBags"] = true,
},
},
},
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
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1TWYSTcSCl0z",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
["TextureName"] = "Details Flat",
},
{
["GUID"] = "TMW:group:1TQuFk14Ix42",
["Point"] = {
["y"] = -120,
["x"] = -5.450076092640056e-05,
},
["Scale"] = 1.5,
["Alpha"] = 0,
["Icons"] = {
{
["Enabled"] = true,
["Type"] = "meta",
["Icons"] = {
"TMW:icon:1a7lUElf_=Se",
"TMW:icon:1a7lUElnNLeF",
"TMW:icon:1a9ihU2QC18O",
"TMW:icon:1a7l2flZcXmn",
"TMW:icon:1a9jdXHzXsKe",
"TMW:icon:1a7jsucSi0aE",
"TMW:icon:1a7jsvYEKX8C",
"TMW:icon:1a8KSxK3rF0S",
"TMW:icon:1a7lUEjXAASn",
"TMW:icon:1a7l2fmgZwCv",
"TMW:icon:1bg_BJk9vseP",
"TMW:icon:1a7jsvYwXc4j",
"TMW:icon:1bgbqMf2PcOe",
"TMW:icon:1a9kNk57eWOn",
"TMW:icon:1a7lUEjf6xOH",
"TMW:icon:1a9kPVhaMuWr",
"TMW:icon:1a7jsvYu6Fu1",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "buff",
["Sort"] = -1,
["Name"] = "Battle Shout",
["DurationMin"] = 15,
["DurationMinEnabled"] = true,
["Conditions"] = {
{
["Type"] = "RAGE_ABS",
["Level"] = 10,
["Operator"] = ">=",
},
["n"] = 1,
},
["States"] = {
{
["Alpha"] = 0,
},
{
["Alpha"] = 1,
},
{
},
{
},
[100] = {
["Alpha"] = 1,
},
},
},
},
["TextureName"] = "Details Flat",
["LayoutDirection"] = 2,
["Columns"] = 1,
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
},
["n"] = 1,
},
["SortPriorities"] = {
{
["Order"] = -1,
},
},
["OnlyInCombat"] = true,
},
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
"TMW:icon:1a7lUElf_=Se",
"TMW:icon:1a7lUElnNLeF",
"TMW:icon:1a9ihU2QC18O",
"TMW:icon:1a7l2flZcXmn",
"TMW:icon:1a9jdXHzXsKe",
"TMW:icon:1a7jsucSi0aE",
"TMW:icon:1a7jsvYEKX8C",
"TMW:icon:1a8KSxK3rF0S",
"TMW:icon:1a7lUEjXAASn",
"TMW:icon:1a7l2fmgZwCv",
"TMW:icon:1bg_BJk9vseP",
"TMW:icon:1a7jsvYwXc4j",
"TMW:icon:1bgbqMf2PcOe",
"TMW:icon:1a9kNk57eWOn",
"TMW:icon:1a7lUEjf6xOH",
"TMW:icon:1a9kPVhaMuWr",
"TMW:icon:1a7jsvYu6Fu1",
},
["States"] = {
{
},
nil,
{
},
{
},
},
},
{
["Enabled"] = true,
["Type"] = "buff",
["Sort"] = -1,
["Name"] = "Battle Shout",
["DurationMin"] = 15,
["DurationMinEnabled"] = true,
["Conditions"] = {
{
["Type"] = "RAGE_ABS",
["Level"] = 10,
["Operator"] = ">=",
},
["n"] = 1,
},
["States"] = {
{
["Alpha"] = 0,
},
{
["Alpha"] = 1,
},
{
},
{
},
[100] = {
["Alpha"] = 1,
},
},
},
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
},
},
["Columns"] = 1,
["OnlyInCombat"] = true,
},
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
},
nil,
{
},
{
},
},
},
},
["OnlyInCombat"] = true,
},
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
},
nil,
{
},
{
},
},
},
},
["Point"] = {
["point"] = "LEFT",
["relativePoint"] = "LEFT",
},
},
{
["Icons"] = {
{
["States"] = {
{
},
nil,
{
},
{
},
},
},
},
},
},
["Locked"] = true,
["Version"] = 110401,
["NumGroups"] = 6,
["TextureName"] = "xVerminClean",
},
["Doperage - Lone Wolf"] = {
["Version"] = 102000,
},
["Dopesnare - Lone Wolf"] = {
["Version"] = 102000,
},
["Dopesick - Stitches"] = {
["Version"] = 101600,
},
["Dopestab - Lone Wolf"] = {
["Version"] = 102000,
},
["Dopeah - Stitches"] = {
["Version"] = 101600,
},
["Dopeclaw - Stitches"] = {
["Version"] = 101600,
},
["Vbank - Celebras"] = {
["Version"] = 110401,
},
["Mq - Celebras"] = {
["Version"] = 110401,
},
},
}
