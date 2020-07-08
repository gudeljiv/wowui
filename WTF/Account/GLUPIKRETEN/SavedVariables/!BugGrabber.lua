
BugGrabberDB = {
	["session"] = 672,
	["lastSanitation"] = 3,
	["errors"] = {
		{
			["message"] = "Interface\\AddOns\\xVerminz\\Experience.lua:7: bad argument #1 to 'select' (index out of range)",
			["time"] = "2019/10/17 21:42:32",
			["locals"] = "(*temporary) = -2\n",
			["stack"] = "[C]: in function `select'\nInterface\\AddOns\\xVerminz\\Experience.lua:7: in function <Interface\\AddOns\\xVerminz\\Experience.lua:5>\nInterface\\AddOns\\xVerminz\\Experience.lua:59: in function <Interface\\AddOns\\xVerminz\\Experience.lua:53>\n[C]: ?",
			["session"] = 608,
			["counter"] = 1105,
		}, -- [1]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\Experience.lua:82: unexpected symbol near ')'",
			["time"] = "2019/10/19 18:02:53",
			["locals"] = "",
			["stack"] = "",
			["session"] = 619,
			["counter"] = 4,
		}, -- [2]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoRepair.lua:6: attempt to call global 'CanGuildBankRepair' (a nil value)",
			["time"] = "2019/10/19 19:13:03",
			["locals"] = "repairAllCost = 230\ncanRepair = true\n(*temporary) = nil\n(*temporary) = \"attempt to call global 'CanGuildBankRepair' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\AutoRepair.lua:6: in function <Interface\\AddOns\\xVerminz\\AutoRepair.lua:1>",
			["session"] = 622,
			["counter"] = 1,
		}, -- [3]
		{
			["message"] = "[string \"print(CanGuildBankRepair())\"]:1: attempt to call global 'CanGuildBankRepair' (a nil value)",
			["time"] = "2019/10/19 19:13:33",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = \"attempt to call global 'CanGuildBankRepair' (a nil value)\"\n",
			["stack"] = "[string \"print(CanGuildBankRepair())\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 622,
			["counter"] = 1,
		}, -- [4]
		{
			["message"] = "[string \"print(CanGuildBankRepaiasdr())\"]:1: attempt to call global 'CanGuildBankRepaiasdr' (a nil value)",
			["time"] = "2019/10/19 19:14:55",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = \"attempt to call global 'CanGuildBankRepaiasdr' (a nil value)\"\n",
			["stack"] = "[string \"print(CanGuildBankRepaiasdr())\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 622,
			["counter"] = 1,
		}, -- [5]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'xVerminz' tried to call the protected function 'TargetFrameToT:Show()'.",
			["time"] = "2019/10/22 20:58:45",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `Show'\nInterface\\FrameXML\\TargetFrame.lua:910: in function <Interface\\FrameXML\\TargetFrame.lua:905>\n[C]: in function `TargetofTarget_Update'\nInterface\\FrameXML\\TargetFrame.lua:420: in function `TargetFrame_OnUpdate'\n[string \"*:OnUpdate\"]:1: in function <[string \"*:OnUpdate\"]:1>",
			["session"] = 643,
			["counter"] = 10,
		}, -- [6]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\SkinBuffs.lua:57: attempt to index global 'config' (a nil value)",
			["time"] = "2019/10/23 13:38:11",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\xVerminz\\SkinBuffs.lua:57: in function <Interface\\AddOns\\xVerminz\\SkinBuffs.lua:14>\n[C]: ?\n[C]: in function `TargetFrame_UpdateAuras'\nInterface\\FrameXML\\TargetFrame.lua:197: in function <Interface\\FrameXML\\TargetFrame.lua:142>",
			["session"] = 645,
			["counter"] = 5,
		}, -- [7]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\CustomContainers.lua:17: attempt to index global 'config' (a nil value)",
			["time"] = "2019/10/23 13:37:53",
			["locals"] = "_ = \"Hunter\"\nclass = \"HUNTER\"\ncolor = <table> {\n colorStr = \"ffaad372\"\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:627\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:616\n b = 0.450000\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:658\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:662\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:654\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:635\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:620\n g = 0.830000\n r = 0.670000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:643\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:631\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:650\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:639\n}\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = CustomContainer_Combat {\n 0 = <userdata>\n}\n(*temporary) = <table> {\n}\n(*temporary) = nil\n(*temporary) = \"LEFT\"\n(*temporary) = 0\n(*temporary) = 0\n(*temporary) = <userdata>\n(*temporary) = \"attempt to index global 'config' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\CustomContainers.lua:17: in main chunk",
			["session"] = 646,
			["counter"] = 2,
		}, -- [8]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\Experience.lua:29: attempt to index global 'config' (a nil value)",
			["time"] = "2019/10/23 13:37:53",
			["locals"] = "_ = \"Hunter\"\nclass = \"HUNTER\"\n_ = 3\nr = nil\ng = nil\nb = nil\nColorGradient = <function> defined @Interface\\AddOns\\xVerminz\\Experience.lua:5\nPetExpFrame = PetExpFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = \"attempt to index global 'config' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\Experience.lua:29: in main chunk",
			["session"] = 646,
			["counter"] = 2,
		}, -- [9]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\GarbageCollector.lua:10: attempt to index global 'config' (a nil value)",
			["time"] = "2019/10/23 13:37:53",
			["locals"] = "cgt = CustomContainer_CombatGarbageText {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = \"ARTWORK\"\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = \"attempt to index global 'config' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\GarbageCollector.lua:10: in main chunk",
			["session"] = 646,
			["counter"] = 2,
		}, -- [10]
		{
			["message"] = "...ace\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:7: attempt to index global 'config' (a nil value)",
			["time"] = "2019/10/23 13:37:53",
			["locals"] = "TargetHealthFrame = TargetHealthFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = \"ARTWORK\"\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = <userdata>\n(*temporary) = \"attempt to index global 'config' (a nil value)\"\n",
			["stack"] = "...ace\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:7: in main chunk",
			["session"] = 646,
			["counter"] = 2,
		}, -- [11]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\Unit.lua:10: attempt to index global 'config' (a nil value)",
			["time"] = "2019/10/23 13:37:53",
			["locals"] = "cus = CustomContainer_CombatUnitState {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = \"ARTWORK\"\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = <userdata>\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'config' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\Unit.lua:10: in main chunk",
			["session"] = 646,
			["counter"] = 2,
		}, -- [12]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\xDamageFont.lua:3: attempt to index global 'config' (a nil value)",
			["time"] = "2019/10/23 13:37:53",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"Frame\"\n(*temporary) = \"xDamageFont\"\n(*temporary) = xDamageFont {\n 0 = <userdata>\n}\n(*temporary) = xDamageFont {\n 0 = <userdata>\n}\n(*temporary) = \"attempt to index global 'config' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\xDamageFont.lua:3: in main chunk",
			["session"] = 646,
			["counter"] = 2,
		}, -- [13]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\xVerminz-54000.lua:137: MonkeyQuestFrame:SetPoint(): Couldn't find region named 'CustomContainer_2'",
			["time"] = "2019/10/23 13:37:56",
			["locals"] = "(*temporary) = MonkeyQuestFrame {\n 0 = <userdata>\n}\n(*temporary) = \"TOPRIGHT\"\n(*temporary) = \"CustomContainer_2\"\n(*temporary) = \"TOPLEFT\"\n(*temporary) = -10\n(*temporary) = 0\n",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\xVerminz\\xVerminz-54000.lua:137: in function <Interface\\AddOns\\xVerminz\\xVerminz.lua:30>",
			["session"] = 646,
			["counter"] = 2,
		}, -- [14]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\SkinBuffs.lua:37: attempt to index global 'config' (a nil value)",
			["time"] = "2019/10/23 13:38:00",
			["locals"] = "numBuffs = 2\nnumDebuffs = 0\n(for index) = 1\n(for limit) = 2\n(for step) = 1\ni = 1\nframe = TargetFrameBuff1 {\n 0 = <userdata>\n unit = \"target\"\n}\nframeBorder = nil\nframeCount = TargetFrameBuff1Count {\n 0 = <userdata>\n}\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = TargetFrameBuff1Count {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = 0\n(*temporary) = \"target\"\n(*temporary) = false\n(*temporary) = false\n(*temporary) = \"attempt to index global 'config' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\SkinBuffs.lua:37: in function <Interface\\AddOns\\xVerminz\\SkinBuffs.lua:14>\n[C]: ?\n[C]: in function `TargetFrame_UpdateAuras'\nInterface\\FrameXML\\TargetFrame.lua:131: in function <Interface\\FrameXML\\TargetFrame.lua:99>\n[C]: in function `TargetFrame_Update'\nInterface\\FrameXML\\TargetFrame.lua:150: in function <Interface\\FrameXML\\TargetFrame.lua:142>\n[C]: in function `CameraOrSelectOrMoveStop'\n[string \"CAMERAORSELECTORMOVE\"]:4: in function <[string \"CAMERAORSELECTORMOVE\"]:1>",
			["session"] = 646,
			["counter"] = 3,
		}, -- [15]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\CustomContainers.lua:113: attempt to index global 'xVerminz' (a nil value)",
			["time"] = "2019/10/23 13:39:05",
			["locals"] = "_ = \"Hunter\"\nclass = \"HUNTER\"\ncolor = <table> {\n colorStr = \"ffaad372\"\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:627\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:616\n b = 0.450000\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:658\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:662\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:654\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:635\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:620\n g = 0.830000\n r = 0.670000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:643\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:631\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:650\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:639\n}\nf = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = CustomContainer_2 {\n 0 = <userdata>\n}\n(*temporary) = <table> {\n}\n(*temporary) = nil\n(*temporary) = \"LEFT\"\n(*temporary) = 0\n(*temporary) = 0\n(*temporary) = \"attempt to index global 'xVerminz' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\CustomContainers.lua:113: in main chunk",
			["session"] = 650,
			["counter"] = 4,
		}, -- [16]
		{
			["message"] = "(null)",
			["session"] = 650,
			["time"] = "2019/10/23 13:37:53",
			["counter"] = 26,
		}, -- [17]
		{
			["message"] = "...\\TradeSkillMaster\\Core\\Lib\\Inventory\\BagTracking.lua:389: Unexpected bag: -2",
			["time"] = "2020/07/08 18:50:31",
			["locals"] = "(*temporary) = \"Unexpected bag: -2\"\n",
			["stack"] = "[C]: in function `error'\n...\\TradeSkillMaster\\Core\\Lib\\Inventory\\BagTracking.lua:389: in function `callback'\n...nterface\\AddOns\\TradeSkillMaster\\Core\\Util\\Event.lua:37: in function `ProcessEvent'\n...nterface\\AddOns\\TradeSkillMaster\\Core\\Util\\Event.lua:53: in function <...nterface\\AddOns\\TradeSkillMaster\\Core\\Util\\Event.lua:45>",
			["session"] = 661,
			["counter"] = 1,
		}, -- [18]
		{
			["message"] = "...nterface\\AddOns\\TradeSkillMaster\\Core\\Util\\Event.lua:49: assertion failed!",
			["time"] = "2020/07/08 18:50:31",
			["locals"] = "(*temporary) = false\n",
			["stack"] = "[C]: in function `assert'\n...nterface\\AddOns\\TradeSkillMaster\\Core\\Util\\Event.lua:49: in function <...nterface\\AddOns\\TradeSkillMaster\\Core\\Util\\Event.lua:45>",
			["session"] = 661,
			["counter"] = 20,
		}, -- [19]
		{
			["message"] = "Interface\\AddOns\\TradeSkillMaster\\Core\\Util\\Util.lua:456: Could not acquire temp table",
			["time"] = "2020/07/08 18:50:32",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"Could not acquire temp table\"\n",
			["stack"] = "[C]: in function `assert'\nInterface\\AddOns\\TradeSkillMaster\\Core\\Util\\Util.lua:456: in function `AcquireTempTable'\n...nterface\\AddOns\\TradeSkillMaster\\Core\\Util\\Event.lua:48: in function <...nterface\\AddOns\\TradeSkillMaster\\Core\\Util\\Event.lua:45>",
			["session"] = 661,
			["counter"] = 218,
		}, -- [20]
		{
			["message"] = "[string \"print(\">\", GetSubZone(), \"<\")\"]:1: attempt to call global 'GetSubZone' (a nil value)",
			["time"] = "2020/07/08 18:55:35",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = \">\"\n(*temporary) = nil\n(*temporary) = \"attempt to call global 'GetSubZone' (a nil value)\"\n",
			["stack"] = "[string \"print(\">\", GetSubZone(), \"<\")\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 662,
			["counter"] = 1,
		}, -- [21]
		{
			["message"] = "...face\\AddOns\\Questie\\Modules\\Network\\QuestieComms.lua:388: attempt to compare number with string",
			["time"] = "2020/07/08 19:51:26",
			["stack"] = "...face\\AddOns\\Questie\\Modules\\Network\\QuestieComms.lua:388: in function <...face\\AddOns\\Questie\\Modules\\Network\\QuestieComms.lua:373>\n[C]: ?\n...hka\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:29: in function <...hka\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:25>\n...hka\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:64: in function `Fire'\n...face\\AddOns\\BugSack\\Libs\\AceComm-3.0\\AceComm-3.0-12.lua:264: in function <...face\\AddOns\\BugSack\\Libs\\AceComm-3.0\\AceComm-3.0.lua:246>",
			["session"] = 672,
			["counter"] = 1,
		}, -- [22]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn '!Colorz' tried to call the protected function 'CompactRaidFrame2:ClearAllPoints()'.",
			["time"] = "2020/07/08 19:52:13",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `ClearAllPoints'\nInterface\\FrameXML\\FlowContainer.lua:157: in function `FlowContainer_DoLayout'\nInterface\\FrameXML\\FlowContainer.lua:17: in function `FlowContainer_ResumeUpdates'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:185: in function `CompactRaidFrameContainer_LayoutFrames'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:130: in function `CompactRaidFrameContainer_TryUpdate'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:57: in function `CompactRaidFrameContainer_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 672,
			["counter"] = 1,
		}, -- [23]
		{
			["message"] = "...\\AddOns\\cargBags_Nivaya\\cargBags\\base\\itembutton.lua:81: Usage: CreateFrame(\"frameType\" [, \"name\"] [, parent] [, \"template\"] [, id])",
			["time"] = "2020/07/07 16:56:37",
			["locals"] = "(*temporary) = \"Button\"\n(*temporary) = \"NivayaSlot1\"\n(*temporary) = \"ItemButtonTemplate\"\n(*temporary) = \"ContainerFrameItemButtonTemplate\"\n",
			["stack"] = "[C]: in function `CreateFrame'\n...\\AddOns\\cargBags_Nivaya\\cargBags\\base\\itembutton.lua:81: in function `Create'\n...\\AddOns\\cargBags_Nivaya\\cargBags\\base\\itembutton.lua:56: in function `New'\nInterface\\AddOns\\cargBags_Nivaya\\cargBags_Nivaya.lua:762: in function <Interface\\AddOns\\cargBags_Nivaya\\cargBags_Nivaya.lua:757>",
			["session"] = 672,
			["counter"] = 14,
		}, -- [24]
	},
}
