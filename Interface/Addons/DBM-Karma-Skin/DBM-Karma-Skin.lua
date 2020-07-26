local classcolors = true --Enable/Disable class coloring
local BassosInterface = false --Placing and Scaling everything like i need it in my own Interface, disable if you want to change it permanently
local darkbars = true --Setting the the not classcolorued bars (Add,AOE,Debuff,Interrupt,Role,Phase) to a specific value and making them a bit darker
local xVerminInterface = true

local skin = DBT:RegisterSkin("Karma-Skin")

DBM.Bars:SetSkin("Karma-Skin")

if classcolors == true then
	_, playerClass = UnitClass("player")
	classbarmultiplier = 0.8
	colours = RAID_CLASS_COLORS[playerClass]
	--Normal
	DBM.Bars:SetOption("StartColorR", colours.r * classbarmultiplier)
	DBM.Bars:SetOption("StartColorG", colours.g * classbarmultiplier)
	DBM.Bars:SetOption("StartColorB", colours.b * classbarmultiplier)
	DBM.Bars:SetOption("EndColorR", colours.r * classbarmultiplier)
	DBM.Bars:SetOption("EndColorG", colours.g * classbarmultiplier)
	DBM.Bars:SetOption("EndColorB", colours.b * classbarmultiplier)
end

if darkbars == true then
	darkbarmultiplier = 0.7
	--Adds
	DBM.Bars:SetOption("StartColorAR", 0.15 * darkbarmultiplier)
	DBM.Bars:SetOption("StartColorAG", 0.385 * darkbarmultiplier)
	DBM.Bars:SetOption("StartColorAB", 1 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorAR", 0.15 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorAG", 0.385 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorAB", 1 * darkbarmultiplier)
	--AOE
	DBM.Bars:SetOption("StartColorAER", 1 * darkbarmultiplier)
	DBM.Bars:SetOption("StartColorAEG", 0.043 * darkbarmultiplier)
	DBM.Bars:SetOption("StartColorAEB", 0.247 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorAER", 1 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorAEG", 0.043 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorAEB", 0.247 * darkbarmultiplier)
	--Debuff
	DBM.Bars:SetOption("StartColorDR", 1 * darkbarmultiplier)
	DBM.Bars:SetOption("StartColorDG", 0 * darkbarmultiplier)
	DBM.Bars:SetOption("StartColorDB", 1 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorDR", 1 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorDG", 0 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorDB", 1 * darkbarmultiplier)
	--Interrupt
	DBM.Bars:SetOption("StartColorIR", 0.047 * darkbarmultiplier)
	DBM.Bars:SetOption("StartColorIG", 0.88 * darkbarmultiplier)
	DBM.Bars:SetOption("StartColorIB", 1 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorIR", 0.047 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorIG", 0.88 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorIB", 1 * darkbarmultiplier)
	--Role
	DBM.Bars:SetOption("StartColorRR", 0.11 * darkbarmultiplier)
	DBM.Bars:SetOption("StartColorRG", 1 * darkbarmultiplier)
	DBM.Bars:SetOption("StartColorRB", 0.3 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorRR", 0.11 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorRG", 1 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorRB", 0.3 * darkbarmultiplier)
	--Phase
	DBM.Bars:SetOption("StartColorPR", 0.5 * darkbarmultiplier)
	DBM.Bars:SetOption("StartColorPG", 0.41 * darkbarmultiplier)
	DBM.Bars:SetOption("StartColorPB", 0.285 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorPR", 0.5 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorPG", 0.41 * darkbarmultiplier)
	DBM.Bars:SetOption("EndColorPB", 0.285 * darkbarmultiplier)
end

if BassosInterface == true then
	DBM.Bars:SetOption("HugeTimerX", 18.5)
	DBM.Bars:SetOption("HugeTimerY", 250)
	DBM.Bars:SetOption("TimerX", -130)
	DBM.Bars:SetOption("TimerY", 150)
	DBM.Options.SpecialWarningY = -200
	DBM.Options.SpecialWarningX = 0
	DBM.Options.RaidWarningPosition.Y = 280
	DBM.Options.RaidWarningPosition.X = 0
	DBM.Bars:SetOption("ExpandUpwards", true)
	DBM.Bars:SetOption("Scale", 1.2)
	DBM.Bars:SetOption("HugeScale", 1.5)
	DBM.Bars:SetOption("ClickThrough", true)
	DBM.Bars:SetOption("HugeWidth", 150)
	DBM.Bars:SetOption("Width", 120)
end

if xVerminInterface == true then
	DBM.Bars:SetOption("ExpandUpwards", true)
	DBM.Bars:SetOption("Scale", 0.9)
	DBM.Bars:SetOption("ClickThrough", true)
	DBM.Bars:SetOption("Width", 183)
	DBM.Bars:SetOption("Alpha", 0.9)
	DBM.Bars:SetOption("HugeBarsEnabled", false)
	DBM.Bars:SetOption("BarYOffset", 6)
end

-- Dont touch these options below --
DBM.Bars:SetOption("Spark", false)
DBM.Bars:SetOption("HugeBarXOffset", 0)
DBM.Bars:SetOption("HugeBarYOffset", 5)
DBM.Bars:SetOption("BarXOffset", 0)
DBM.Bars:SetOption("BarYOffset", 5)
DBM.Bars:SetOption("IconRight", false)
DBM.Bars:SetOption("Font", "Interface\\AddOns\\DBM-Karma-Skin\\media\\ROADWAY.ttf")
DBM.Bars:SetOption("Texture", "Interface\\AddOns\\DBM-Karma-Skin\\textures\\bar.tga")
DBM.Bars:SetOption("EnlargeBarsTime", 10)
DBM.Bars:SetOption("Skin", "Karma-Skin")
DBM.Bars:SetOption("Template", "DBM-Karma-Skin-Template")
DBM.Options.SpecialWarningFont = "Interface\\AddOns\\DBM-Karma-Skin\\media\\Enigma__2.ttf"
DBM.Options.WarningFont = "Interface\\AddOns\\DBM-Karma-Skin\\media\\Enigma__2.ttf"
DBM.Options.SpecialWarningFontStyle = "THINOUTLINE"
DBM.Options.WarningFontStyle = "THINOUTLINE"
