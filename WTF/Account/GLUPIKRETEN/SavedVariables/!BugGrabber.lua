
BugGrabberDB = {
	["session"] = 804,
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
			["message"] = "Couldn't open Interface\\AddOns\\Details\\Libs\\LibThreatClassic2\\lib.xml",
			["time"] = "2020/07/11 19:09:15",
			["session"] = 751,
			["counter"] = 8,
		}, -- [3]
		{
			["message"] = "Couldn't open Interface\\AddOns\\Details_Streamer\\Details_Streamer.toc",
			["session"] = 751,
			["time"] = "2020/07/11 19:09:55",
			["counter"] = 2,
		}, -- [4]
		{
			["message"] = "[ADDON_ACTION_FORBIDDEN] AddOn 'cargBags_Nivaya' tried to call the protected function 'UNKNOWN()'.",
			["time"] = "2020/07/11 19:14:51",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: ?\n[C]: in function `UseContainerItem'\nInterface\\FrameXML\\ContainerFrame.lua:1250: in function `ContainerFrameItemButton_OnClick'\n[string \"*:OnClick\"]:12: in function <[string \"*:OnClick\"]:1>",
			["session"] = 752,
			["counter"] = 1,
		}, -- [5]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'ItemRack' tried to call the protected function 'AttemptToSaveBindings()'.",
			["time"] = "2020/07/11 19:23:02",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `AttemptToSaveBindings'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:2045: in function `SetSetBindings'\nInterface\\AddOns\\ItemRackOptions\\ItemRackOptions.lua:1041: in function `ReconcileSetBindings'\nInterface\\AddOns\\ItemRackOptions\\ItemRackOptions.lua:411: in function <Interface\\AddOns\\ItemRackOptions\\ItemRackOptions.lua:395>\nInterface\\AddOns\\cargBags_Nivaya\\filters-Filters.lua:132: in function `SaveSet'\nInterface\\AddOns\\ItemRackOptions\\ItemRackOptions.lua:272: in function `ButtonOnClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 753,
			["counter"] = 1,
		}, -- [6]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:83: 'for' limit must be a number",
			["time"] = "2020/07/12 20:44:49",
			["locals"] = "numBuffs = 0\n(for index) = 1\n(for limit) = nil\n(for step) = 1\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"'for' limit must be a number\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:83: in function <Interface\\AddOns\\xVermin\\SkinBuffs.lua:80>\n[C]: in function `PetFrame_Update'\n[string \"*:OnShow\"]:2: in function <[string \"*:OnShow\"]:1>\n[C]: in function `Show'\nInterface\\FrameXML\\PetFrame.lua:47: in function <Interface\\FrameXML\\PetFrame.lua:41>\n[C]: in function `PetFrame_Update'\nInterface\\FrameXML\\PetFrame.lua:72: in function <Interface\\FrameXML\\PetFrame.lua:67>",
			["session"] = 764,
			["counter"] = 5,
		}, -- [7]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:175: hooksecurefunc(): PetFrame_UpdateAuras is not a function",
			["time"] = "2020/07/12 22:41:19",
			["locals"] = "",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:175: in main chunk",
			["session"] = 772,
			["counter"] = 1,
		}, -- [8]
		{
			["message"] = "[string \"print(UnitAura(\"pet\"))\"]:1: Usage: UnitAura(\"unit\", [index][, \"filter\"])",
			["time"] = "2020/07/12 22:47:32",
			["locals"] = "(*temporary) = \"pet\"\n",
			["stack"] = "[C]: in function `UnitAura'\n[string \"print(UnitAura(\"pet\"))\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 772,
			["counter"] = 1,
		}, -- [9]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:175: hooksecurefunc(): UpdateUI is not a function",
			["time"] = "2020/07/12 22:49:58",
			["locals"] = "",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:175: in main chunk",
			["session"] = 773,
			["counter"] = 1,
		}, -- [10]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:175: hooksecurefunc(): UNIT_HAPPINESS is not a function",
			["time"] = "2020/07/12 22:52:06",
			["locals"] = "",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:175: in main chunk",
			["session"] = 774,
			["counter"] = 1,
		}, -- [11]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:175: hooksecurefunc(): UNIT_AURA is not a function",
			["time"] = "2020/07/12 22:56:42",
			["locals"] = "",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:175: in main chunk",
			["session"] = 775,
			["counter"] = 1,
		}, -- [12]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:175: hooksecurefunc(): PET_BAR_UPDATE_COOLDOWN is not a function",
			["time"] = "2020/07/12 23:00:31",
			["locals"] = "",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:175: in main chunk",
			["session"] = 777,
			["counter"] = 1,
		}, -- [13]
		{
			["message"] = "(null)",
			["time"] = "2020/07/11 19:09:15",
			["session"] = 777,
			["counter"] = 23,
		}, -- [14]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:107: Attempt to find 'this' in non-table object (used '.' instead of ':' ?)",
			["time"] = "2020/07/12 22:57:07",
			["locals"] = "",
			["stack"] = "[C]: in function `GetName'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:107: in function `SkinPet'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:177: in main chunk",
			["session"] = 779,
			["counter"] = 2,
		}, -- [15]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:77: attempt to index field 'PetFood' (a nil value)",
			["time"] = "2020/07/13 16:55:52",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:249\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:233\n IsUsableFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:161\n Bandage = <table> {\n }\n BetterFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:267\n ManaGem = <table> {\n }\n inArray = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:216\n Potion = <table> {\n }\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:321\n dirty = false\n BetterBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:341\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:241\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:263\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:245\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:333\n BetterMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:329\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:58\n BetterHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:325\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:237\n IsUsablePetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:166\n BetterPetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:284\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:229\n BetterManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:337\n Sorted = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:152\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:225\n BuildSequence = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:350\n BetterDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:305\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:301\n}\nbest = <table> {\n drink = <table> {\n }\n food = <table> {\n }\n manaGem = <table> {\n }\n mPotion = <table> {\n }\n bandage = <table> {\n }\n healthstone = <table> {\n }\n hPotion = <table> {\n }\n buffFood = <table> {\n }\n petfood = <table> {\n }\n buffDrink = <table> {\n }\n}\n(for index) = 0\n(for limit) = 4\n(for step) = 1\nbag = 0\n(for index) = 1\n(for limit) = 16\n(for step) = 1\nslot = 1\nid = 2515\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:166\n(*temporary) = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:249\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:233\n IsUsableFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:161\n Bandage = <table> {\n }\n BetterFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:267\n ManaGem = <table> {\n }\n inArray = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:216\n Potion = <table> {\n }\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:321\n dirty = false\n BetterBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:341\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:241\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:263\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:245\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:333\n BetterMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:329\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:58\n BetterHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:325\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:237\n IsUsablePetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:166\n BetterPetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:284\n IsUsableDrink = <funct",
			["stack"] = "Interface\\AddOns\\xVermin\\BestFood.lua:77: in function `UpdateMacros'\nInterface\\AddOns\\xVermin\\BestFood.lua:49: in function <Interface\\AddOns\\xVermin\\BestFood.lua:44>",
			["session"] = 786,
			["counter"] = 2,
		}, -- [16]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:207: attempt to index local 'food' (a nil value)",
			["time"] = "2020/07/13 16:56:47",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:249\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:233\n IsUsableFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:161\n Bandage = <table> {\n }\n BetterFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:267\n ManaGem = <table> {\n }\n inArray = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:216\n Potion = <table> {\n }\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:321\n dirty = false\n BetterBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:341\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:241\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:263\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:245\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:333\n BetterMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:329\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:58\n BetterHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:325\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:237\n IsUsablePetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:166\n BetterPetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:284\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:229\n BetterManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:337\n Sorted = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:152\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:225\n BuildSequence = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:350\n BetterDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:305\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:301\n}\nfood = nil\npetType = \"Cat\"\ndiet = <table> {\n 1 = \"Meat\"\n 2 = \"Fish\"\n}\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = \"Meat\"\n(*temporary) = \"Fish\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'food' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\BestFood.lua:207: in function `IsUsablePetFood'\nInterface\\AddOns\\xVermin\\BestFood.lua:77: in function `UpdateMacros'\nInterface\\AddOns\\xVermin\\BestFood.lua:49: in function <Interface\\AddOns\\xVermin\\BestFood.lua:44>",
			["session"] = 787,
			["counter"] = 5,
		}, -- [17]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:229: bad argument #1 to 'ipairs' (table expected, got nil)",
			["time"] = "2020/07/13 17:03:39",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"table expected, got nil\"\n = <function> defined =[C]:-1\n",
			["stack"] = "[C]: in function `ipairs'\nInterface\\AddOns\\xVermin\\BestFood.lua:229: in function `inArray'\nInterface\\AddOns\\xVermin\\BestFood.lua:217: in function `IsUsablePetFood'\nInterface\\AddOns\\xVermin\\BestFood.lua:77: in function `UpdateMacros'\nInterface\\AddOns\\xVermin\\BestFood.lua:49: in function <Interface\\AddOns\\xVermin\\BestFood.lua:44>",
			["session"] = 792,
			["counter"] = 1,
		}, -- [18]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:217: bad argument #1 to 'ipairs' (table expected, got nil)",
			["time"] = "2020/07/13 17:05:13",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"table expected, got nil\"\n = <function> defined =[C]:-1\n",
			["stack"] = "[C]: in function `ipairs'\nInterface\\AddOns\\xVermin\\BestFood.lua:217: in function `inArray'\nInterface\\AddOns\\xVermin\\BestFood.lua:213: in function `IsUsablePetFood'\nInterface\\AddOns\\xVermin\\BestFood.lua:77: in function `UpdateMacros'\nInterface\\AddOns\\xVermin\\BestFood.lua:49: in function <Interface\\AddOns\\xVermin\\BestFood.lua:44>",
			["session"] = 794,
			["counter"] = 2,
		}, -- [19]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:218: bad argument #1 to 'ipairs' (table expected, got nil)",
			["time"] = "2020/07/13 17:06:39",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"table expected, got nil\"\n = <function> defined =[C]:-1\n",
			["stack"] = "[C]: in function `ipairs'\nInterface\\AddOns\\xVermin\\BestFood.lua:218: in function `inArray'\nInterface\\AddOns\\xVermin\\BestFood.lua:214: in function `IsUsablePetFood'\nInterface\\AddOns\\xVermin\\BestFood.lua:77: in function `UpdateMacros'\nInterface\\AddOns\\xVermin\\BestFood.lua:49: in function <Interface\\AddOns\\xVermin\\BestFood.lua:44>",
			["session"] = 795,
			["counter"] = 1,
		}, -- [20]
		{
			["message"] = "...\\AddOns\\cargBags_Nivaya\\cargBags\\base\\itembutton.lua:81: Usage: CreateFrame(\"frameType\" [, \"name\"] [, parent] [, \"template\"] [, id])",
			["time"] = "2020/07/11 17:53:14",
			["locals"] = "(*temporary) = \"Button\"\n(*temporary) = \"NivayaSlot1\"\n(*temporary) = \"ItemButtonTemplate\"\n(*temporary) = \"ContainerFrameItemButtonTemplate\"\n",
			["stack"] = "[C]: in function `CreateFrame'\n...\\AddOns\\cargBags_Nivaya\\cargBags\\base\\itembutton.lua:81: in function `Create'\n...\\AddOns\\cargBags_Nivaya\\cargBags\\base\\itembutton.lua:56: in function `New'\nInterface\\AddOns\\cargBags_Nivaya\\cargBags_Nivaya.lua:762: in function <Interface\\AddOns\\cargBags_Nivaya\\cargBags_Nivaya.lua:757>",
			["session"] = 804,
			["counter"] = 65,
		}, -- [21]
	},
}
