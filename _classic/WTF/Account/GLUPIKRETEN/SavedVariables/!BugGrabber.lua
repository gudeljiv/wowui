
BugGrabberDB = {
	["session"] = 10062,
	["lastSanitation"] = 3,
	["errors"] = {
		{
			["message"] = "Interface/SharedXML/SharedTooltipTemplates.lua:276: attempt to call method 'GetRGB' (a nil value)",
			["time"] = "2023/09/03 11:28:47",
			["locals"] = "self = LootBarToolTip {\n SetBorderBlendMode = <function> defined @Interface/SharedXML/SharedTooltipTemplates.lua:302\n NineSlice = Frame {\n }\n TooltipBackdropOnLoad = <function> defined @Interface/SharedXML/SharedTooltipTemplates.lua:271\n TopOverlay = Texture {\n }\n GetBackdropColor = <function> defined @Interface/SharedXML/SharedTooltipTemplates.lua:290\n GetBackdropBorderColor = <function> defined @Interface/SharedXML/SharedTooltipTemplates.lua:298\n 0 = <userdata>\n BottomOverlay = Texture {\n }\n SetBackdropColor = <function> defined @Interface/SharedXML/SharedTooltipTemplates.lua:286\n layoutType = \"TooltipDefaultLayout\"\n SetBackdropBorderColor = <function> defined @Interface/SharedXML/SharedTooltipTemplates.lua:294\n}\nbgColor = <table> {\n b = 0.190000\n g = 0.090000\n r = 0.090000\n}\nbgAlpha = 1\n(*temporary) = nil\n(*temporary) = <table> {\n b = 0.190000\n g = 0.090000\n r = 0.090000\n}\n(*temporary) = \"attempt to call method 'GetRGB' (a nil value)\"\n",
			["stack"] = "[string \"@Interface/SharedXML/SharedTooltipTemplates.lua\"]:276: in function <Interface/SharedXML/SharedTooltipTemplates.lua:271>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: in function `CreateFrame'\n[string \"@Interface/AddOns/RareScanner/RareScanner.lua\"]:324: in main chunk",
			["session"] = 10035,
			["counter"] = 48,
		}, -- [1]
		{
			["message"] = "Interface/SharedXML/SharedTooltipTemplates.lua:144: attempt to call method 'GetRGB' (a nil value)",
			["time"] = "2023/09/03 11:29:13",
			["locals"] = "self = LibDBIconTooltip {\n 0 = <userdata>\n beautyShadow = <table> {\n }\n layoutType = \"TooltipDefaultLayout\"\n GetBackdropColor = <function> defined @Interface/SharedXML/SharedTooltipTemplates.lua:290\n BottomOverlay = Texture {\n }\n SetBackdropBorderColor = <function> defined @Interface/SharedXML/SharedTooltipTemplates.lua:294\n updateTooltip = 0.200000\n TooltipBackdropOnLoad = <function> defined @Interface/SharedXML/SharedTooltipTemplates.lua:271\n TopOverlay = Texture {\n }\n GetBackdropBorderColor = <function> defined @Interface/SharedXML/SharedTooltipTemplates.lua:298\n SetBorderBlendMode = <function> defined @Interface/SharedXML/SharedTooltipTemplates.lua:302\n needsReset = true\n Background = TooltipBackground {\n }\n SetBackdropColor = <function> defined @Interface/SharedXML/SharedTooltipTemplates.lua:286\n NineSlice = Frame {\n }\n beautyBorder = <table> {\n }\n}\nstyle = nil\nembedded = nil\n(*temporary) = nil\n(*temporary) = <table> {\n b = 0.190000\n g = 0.090000\n r = 0.090000\n}\n(*temporary) = \"attempt to call method 'GetRGB' (a nil value)\"\n",
			["stack"] = "[string \"@Interface/SharedXML/SharedTooltipTemplates.lua\"]:144: in function `SharedTooltip_SetBackdropStyle'\n[string \"@Interface/FrameXML/GameTooltip.lua\"]:398: in function `GameTooltip_OnHide'\n[string \"*GameTooltipTemplate.xml:250_OnHide\"]:1: in function <[string \"*GameTooltipTemplate.xml:250_OnHide\"]:1>\n[string \"=[C]\"]: in function `Hide'\n[string \"@Interface/AddOns/BugSack/Libs/LibDBIcon-1.0-52/LibDBIcon-1.0.lua\"]:81: in function <.../AddOns/BugSack/Libs/LibDBIcon-1.0/LibDBIcon-1.0.lua:80>",
			["session"] = 10035,
			["counter"] = 33,
		}, -- [2]
		{
			["message"] = "MultiBarBottomRightButton9:SetPoint(): Invalid region point -2",
			["time"] = "2023/09/03 12:17:48",
			["locals"] = "(*temporary) = MultiBarBottomRightButton9 {\n 0 = <userdata>\n HotKey = MultiBarBottomRightButton9HotKey {\n }\n action = 57\n NewActionTexture = Texture {\n }\n Border = MultiBarBottomRightButton9Border {\n }\n Flash = MultiBarBottomRightButton9Flash {\n }\n feedback_action = 57\n flashtime = 0\n Background = Texture {\n }\n icon = MultiBarBottomRightButton9Icon {\n }\n eventsRegistered = true\n AutoCastable = Texture {\n }\n SpellHighlightAnim = AnimationGroup {\n }\n rangeTimer = 0.116000\n Name = MultiBarBottomRightButton9Name {\n }\n flashing = 0\n SpellHighlightTexture = Texture {\n }\n buttonType = \"MULTIACTIONBAR2BUTTON\"\n NormalTexture = MultiBarBottomRightButton9NormalTexture {\n }\n FlyoutBorderShadow = MultiBarBottomRightButton9FlyoutBorderShadow {\n }\n FlyoutBorder = MultiBarBottomRightButton9FlyoutBorder {\n }\n Count = MultiBarBottomRightButton9Count {\n }\n AutoCastShine = MultiBarBottomRightButton9Shine {\n }\n FlyoutArrow = MultiBarBottomRightButton9FlyoutArrow {\n }\n cooldown = MultiBarBottomRightButton9Cooldown {\n }\n zoneAbilityDisabled = false\n}\n(*temporary) = \"-2\"\n(*temporary) = \"-2\"\n",
			["stack"] = "[string \"=[C]\"]: in function `SetPoint'\n[string \"MultiBarBottomRightButton9:SetPoint(\"-2\", \"-2\")\"]:1: in main chunk\n[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface/FrameXML/ChatFrame.lua\"]:2235: in function `?'\n[string \"@Interface/FrameXML/ChatFrame.lua\"]:4966: in function `ChatEdit_ParseText'\n[string \"@Interface/FrameXML/ChatFrame.lua\"]:4629: in function `ChatEdit_SendText'\n[string \"@Interface/FrameXML/ChatFrame.lua\"]:3008: in function <Interface/FrameXML/ChatFrame.lua:3001>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: in function `UseAction'\n[string \"@Interface/FrameXML/SecureTemplates.lua\"]:343: in function `handler'\n[string \"@Interface/FrameXML/SecureTemplates.lua\"]:625: in function `SecureActionButton_OnClick'\n[string \"*ActionBarFrame.xml:15_OnClick\"]:4: in function <[string \"*ActionBarFrame.xml:15_OnClick\"]:1>",
			["session"] = 10044,
			["counter"] = 1,
		}, -- [3]
		{
			["message"] = "MultiBarBottomRightButton9:SetPoint(): Couldn't find region named '-2'",
			["time"] = "2023/09/03 12:18:04",
			["locals"] = "(*temporary) = MultiBarBottomRightButton9 {\n 0 = <userdata>\n HotKey = MultiBarBottomRightButton9HotKey {\n }\n action = 57\n NewActionTexture = Texture {\n }\n Border = MultiBarBottomRightButton9Border {\n }\n Flash = MultiBarBottomRightButton9Flash {\n }\n feedback_action = 57\n flashtime = 0\n Background = Texture {\n }\n icon = MultiBarBottomRightButton9Icon {\n }\n eventsRegistered = true\n AutoCastable = Texture {\n }\n SpellHighlightAnim = AnimationGroup {\n }\n rangeTimer = 0.050000\n Name = MultiBarBottomRightButton9Name {\n }\n flashing = 0\n SpellHighlightTexture = Texture {\n }\n buttonType = \"MULTIACTIONBAR2BUTTON\"\n NormalTexture = MultiBarBottomRightButton9NormalTexture {\n }\n FlyoutBorderShadow = MultiBarBottomRightButton9FlyoutBorderShadow {\n }\n FlyoutBorder = MultiBarBottomRightButton9FlyoutBorder {\n }\n Count = MultiBarBottomRightButton9Count {\n }\n AutoCastShine = MultiBarBottomRightButton9Shine {\n }\n FlyoutArrow = MultiBarBottomRightButton9FlyoutArrow {\n }\n cooldown = MultiBarBottomRightButton9Cooldown {\n }\n zoneAbilityDisabled = false\n}\n(*temporary) = \"TOPRIGHT\"\n(*temporary) = \"-2\"\n(*temporary) = \"-2\"\n",
			["stack"] = "[string \"=[C]\"]: in function `SetPoint'\n[string \"MultiBarBottomRightButton9:SetPoint(\"TOPRIGHT\", \"-2\", \"-2\")\"]:1: in main chunk\n[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface/FrameXML/ChatFrame.lua\"]:2235: in function `?'\n[string \"@Interface/FrameXML/ChatFrame.lua\"]:4966: in function `ChatEdit_ParseText'\n[string \"@Interface/FrameXML/ChatFrame.lua\"]:4629: in function `ChatEdit_SendText'\n[string \"@Interface/FrameXML/ChatFrame.lua\"]:3008: in function <Interface/FrameXML/ChatFrame.lua:3001>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: in function `UseAction'\n[string \"@Interface/FrameXML/SecureTemplates.lua\"]:343: in function `handler'\n[string \"@Interface/FrameXML/SecureTemplates.lua\"]:625: in function `SecureActionButton_OnClick'\n[string \"*ActionBarFrame.xml:15_OnClick\"]:4: in function <[string \"*ActionBarFrame.xml:15_OnClick\"]:1>",
			["session"] = 10044,
			["counter"] = 1,
		}, -- [4]
		{
			["message"] = "Interface/AddOns/ItemRack/ItemRack.lua:2006: Usage: SaveBindings(1||2)",
			["time"] = "2023/09/03 12:28:52",
			["locals"] = "(*temporary) = 0\n",
			["stack"] = "[string \"=[C]\"]: in function `SaveBindings'\n[string \"@Interface/AddOns/ItemRack/ItemRack.lua\"]:2006: in function `SetSetBindings'\n[string \"@Interface/AddOns/ItemRack/ItemRack.lua\"]:265: in function `?'\n[string \"@Interface/AddOns/ItemRack/ItemRack.lua\"]:230: in function `OnEvent'\n[string \"*ItemRack.xml:4_OnEvent\"]:1: in function <[string \"*ItemRack.xml:4_OnEvent\"]:1>",
			["session"] = 10051,
			["counter"] = 2,
		}, -- [5]
		{
			["message"] = "[ADDON_ACTION_FORBIDDEN] AddOn 'RingMenu' tried to call the protected function 'SpellStopCasting()'.",
			["time"] = "2023/09/03 13:18:53",
			["locals"] = "_ = Frame {\n RegisterEvent = <function> defined @Interface/AddOns/!BugGrabber/BugGrabber.lua:487\n 0 = <userdata>\n UnregisterEvent = <function> defined @Interface/AddOns/!BugGrabber/BugGrabber.lua:487\n SetScript = <function> defined @Interface/AddOns/!BugGrabber/BugGrabber.lua:487\n}\nevent = \"ADDON_ACTION_FORBIDDEN\"\nevents = <table> {\n ADDON_ACTION_BLOCKED = <function> defined @Interface/AddOns/!BugGrabber/BugGrabber.lua:553\n ADDON_ACTION_FORBIDDEN = <function> defined @Interface/AddOns/!BugGrabber/BugGrabber.lua:553\n PLAYER_LOGIN = <function> defined @Interface/AddOns/!BugGrabber/BugGrabber.lua:547\n LUA_WARNING = <function> defined @Interface/AddOns/!BugGrabber/BugGrabber.lua:562\n ADDON_LOADED = <function> defined @Interface/AddOns/!BugGrabber/BugGrabber.lua:507\n}\n",
			["stack"] = "[string \"@Interface/AddOns/!BugGrabber/BugGrabber.lua\"]:481: in function <Interface/AddOns/!BugGrabber/BugGrabber.lua:481>\n[string \"=[C]\"]: in function `SpellStopCasting'\n[string \"@Interface_Vanilla/FrameXML/UIParent.lua\"]:3497: in function `ToggleGameMenu'\n[string \"@Interface/SharedXML/Settings/Blizzard_SettingsPanel.lua\"]:347: in function `TransitionBackOpeningPanel'\n[string \"@Interface/SharedXML/Settings/Blizzard_SettingsPanel.lua\"]:336: in function `ExitWithCommit'\n[string \"@Interface/SharedXML/Settings/Blizzard_SettingsPanel.lua\"]:305: in function `Close'\n[string \"@Interface/SharedXML/Settings/Blizzard_SettingsPanel.lua\"]:71: in function <...erface/SharedXML/Settings/Blizzard_SettingsPanel.lua:70>",
			["session"] = 10056,
			["counter"] = 1,
		}, -- [6]
	},
}
