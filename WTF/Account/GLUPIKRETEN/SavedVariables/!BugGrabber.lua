
BugGrabberDB = {
	["session"] = 756,
	["lastSanitation"] = 3,
	["errors"] = {
		{
			["message"] = "[string \"ItemRackMenu3:CreateBeautyBorder(8)\"]:1: attempt to index global 'ItemRackMenu3' (a nil value)",
			["time"] = "2020/07/11 18:52:47",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'ItemRackMenu3' (a nil value)\"\n",
			["stack"] = "[string \"ItemRackMenu3:CreateBeautyBorder(8)\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 745,
			["counter"] = 1,
		}, -- [1]
		{
			["message"] = "...ace\\AddOns\\Details_TinyThreat\\Details_TinyThreat.lua:55: Cannot find a library instance of \"LibThreatClassic2\".",
			["time"] = "2020/07/11 19:09:10",
			["locals"] = "(*temporary) = \"Cannot find a library instance of \"LibThreatClassic2\".\"\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\Aptechka\\Libs\\LibStub\\LibStub.lua:23: in function `GetLibrary'\n...ace\\AddOns\\Details_TinyThreat\\Details_TinyThreat.lua:55: in main chunk",
			["session"] = 751,
			["counter"] = 2,
		}, -- [2]
		{
			["message"] = "(null)",
			["time"] = "2020/07/11 19:09:15",
			["session"] = 751,
			["counter"] = 5,
		}, -- [3]
		{
			["message"] = "Couldn't open Interface\\AddOns\\Details\\Libs\\LibThreatClassic2\\lib.xml",
			["time"] = "2020/07/11 19:09:15",
			["session"] = 751,
			["counter"] = 8,
		}, -- [4]
		{
			["message"] = "Couldn't open Interface\\AddOns\\Details_Streamer\\Details_Streamer.toc",
			["session"] = 751,
			["time"] = "2020/07/11 19:09:55",
			["counter"] = 2,
		}, -- [5]
		{
			["message"] = "[ADDON_ACTION_FORBIDDEN] AddOn 'cargBags_Nivaya' tried to call the protected function 'UNKNOWN()'.",
			["time"] = "2020/07/11 19:14:51",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: ?\n[C]: in function `UseContainerItem'\nInterface\\FrameXML\\ContainerFrame.lua:1250: in function `ContainerFrameItemButton_OnClick'\n[string \"*:OnClick\"]:12: in function <[string \"*:OnClick\"]:1>",
			["session"] = 752,
			["counter"] = 1,
		}, -- [6]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'ItemRack' tried to call the protected function 'AttemptToSaveBindings()'.",
			["time"] = "2020/07/11 19:23:02",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `AttemptToSaveBindings'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:2045: in function `SetSetBindings'\nInterface\\AddOns\\ItemRackOptions\\ItemRackOptions.lua:1041: in function `ReconcileSetBindings'\nInterface\\AddOns\\ItemRackOptions\\ItemRackOptions.lua:411: in function <Interface\\AddOns\\ItemRackOptions\\ItemRackOptions.lua:395>\nInterface\\AddOns\\cargBags_Nivaya\\filters-Filters.lua:132: in function `SaveSet'\nInterface\\AddOns\\ItemRackOptions\\ItemRackOptions.lua:272: in function `ButtonOnClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 753,
			["counter"] = 1,
		}, -- [7]
		{
			["message"] = "...\\AddOns\\cargBags_Nivaya\\cargBags\\base\\itembutton.lua:81: Usage: CreateFrame(\"frameType\" [, \"name\"] [, parent] [, \"template\"] [, id])",
			["time"] = "2020/07/11 17:53:14",
			["locals"] = "(*temporary) = \"Button\"\n(*temporary) = \"NivayaSlot1\"\n(*temporary) = \"ItemButtonTemplate\"\n(*temporary) = \"ContainerFrameItemButtonTemplate\"\n",
			["stack"] = "[C]: in function `CreateFrame'\n...\\AddOns\\cargBags_Nivaya\\cargBags\\base\\itembutton.lua:81: in function `Create'\n...\\AddOns\\cargBags_Nivaya\\cargBags\\base\\itembutton.lua:56: in function `New'\nInterface\\AddOns\\cargBags_Nivaya\\cargBags_Nivaya.lua:762: in function <Interface\\AddOns\\cargBags_Nivaya\\cargBags_Nivaya.lua:757>",
			["session"] = 756,
			["counter"] = 16,
		}, -- [8]
	},
}
