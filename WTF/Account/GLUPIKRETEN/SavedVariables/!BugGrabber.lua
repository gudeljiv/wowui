
BugGrabberDB = {
	["session"] = 962,
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
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:83: 'for' limit must be a number",
			["time"] = "2020/07/12 20:44:49",
			["locals"] = "numBuffs = 0\n(for index) = 1\n(for limit) = nil\n(for step) = 1\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"'for' limit must be a number\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:83: in function <Interface\\AddOns\\xVermin\\SkinBuffs.lua:80>\n[C]: in function `PetFrame_Update'\n[string \"*:OnShow\"]:2: in function <[string \"*:OnShow\"]:1>\n[C]: in function `Show'\nInterface\\FrameXML\\PetFrame.lua:47: in function <Interface\\FrameXML\\PetFrame.lua:41>\n[C]: in function `PetFrame_Update'\nInterface\\FrameXML\\PetFrame.lua:72: in function <Interface\\FrameXML\\PetFrame.lua:67>",
			["session"] = 764,
			["counter"] = 5,
		}, -- [6]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:175: hooksecurefunc(): PetFrame_UpdateAuras is not a function",
			["time"] = "2020/07/12 22:41:19",
			["locals"] = "",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:175: in main chunk",
			["session"] = 772,
			["counter"] = 1,
		}, -- [7]
		{
			["message"] = "[string \"print(UnitAura(\"pet\"))\"]:1: Usage: UnitAura(\"unit\", [index][, \"filter\"])",
			["time"] = "2020/07/12 22:47:32",
			["locals"] = "(*temporary) = \"pet\"\n",
			["stack"] = "[C]: in function `UnitAura'\n[string \"print(UnitAura(\"pet\"))\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 772,
			["counter"] = 1,
		}, -- [8]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:175: hooksecurefunc(): UpdateUI is not a function",
			["time"] = "2020/07/12 22:49:58",
			["locals"] = "",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:175: in main chunk",
			["session"] = 773,
			["counter"] = 1,
		}, -- [9]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:175: hooksecurefunc(): UNIT_HAPPINESS is not a function",
			["time"] = "2020/07/12 22:52:06",
			["locals"] = "",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:175: in main chunk",
			["session"] = 774,
			["counter"] = 1,
		}, -- [10]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:175: hooksecurefunc(): UNIT_AURA is not a function",
			["time"] = "2020/07/12 22:56:42",
			["locals"] = "",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:175: in main chunk",
			["session"] = 775,
			["counter"] = 1,
		}, -- [11]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:175: hooksecurefunc(): PET_BAR_UPDATE_COOLDOWN is not a function",
			["time"] = "2020/07/12 23:00:31",
			["locals"] = "",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:175: in main chunk",
			["session"] = 777,
			["counter"] = 1,
		}, -- [12]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:107: Attempt to find 'this' in non-table object (used '.' instead of ':' ?)",
			["time"] = "2020/07/12 22:57:07",
			["locals"] = "",
			["stack"] = "[C]: in function `GetName'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:107: in function `SkinPet'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:177: in main chunk",
			["session"] = 779,
			["counter"] = 2,
		}, -- [13]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:77: attempt to index field 'PetFood' (a nil value)",
			["time"] = "2020/07/13 16:55:52",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:249\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:233\n IsUsableFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:161\n Bandage = <table> {\n }\n BetterFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:267\n ManaGem = <table> {\n }\n inArray = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:216\n Potion = <table> {\n }\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:321\n dirty = false\n BetterBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:341\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:241\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:263\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:245\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:333\n BetterMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:329\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:58\n BetterHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:325\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:237\n IsUsablePetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:166\n BetterPetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:284\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:229\n BetterManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:337\n Sorted = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:152\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:225\n BuildSequence = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:350\n BetterDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:305\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:301\n}\nbest = <table> {\n drink = <table> {\n }\n food = <table> {\n }\n manaGem = <table> {\n }\n mPotion = <table> {\n }\n bandage = <table> {\n }\n healthstone = <table> {\n }\n hPotion = <table> {\n }\n buffFood = <table> {\n }\n petfood = <table> {\n }\n buffDrink = <table> {\n }\n}\n(for index) = 0\n(for limit) = 4\n(for step) = 1\nbag = 0\n(for index) = 1\n(for limit) = 16\n(for step) = 1\nslot = 1\nid = 2515\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:166\n(*temporary) = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:249\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:233\n IsUsableFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:161\n Bandage = <table> {\n }\n BetterFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:267\n ManaGem = <table> {\n }\n inArray = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:216\n Potion = <table> {\n }\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:321\n dirty = false\n BetterBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:341\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:241\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:263\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:245\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:333\n BetterMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:329\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:58\n BetterHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:325\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:237\n IsUsablePetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:166\n BetterPetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:284\n IsUsableDrink = <funct",
			["stack"] = "Interface\\AddOns\\xVermin\\BestFood.lua:77: in function `UpdateMacros'\nInterface\\AddOns\\xVermin\\BestFood.lua:49: in function <Interface\\AddOns\\xVermin\\BestFood.lua:44>",
			["session"] = 786,
			["counter"] = 2,
		}, -- [14]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:207: attempt to index local 'food' (a nil value)",
			["time"] = "2020/07/13 16:56:47",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:249\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:233\n IsUsableFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:161\n Bandage = <table> {\n }\n BetterFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:267\n ManaGem = <table> {\n }\n inArray = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:216\n Potion = <table> {\n }\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:321\n dirty = false\n BetterBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:341\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:241\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:263\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:245\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:333\n BetterMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:329\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:58\n BetterHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:325\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:237\n IsUsablePetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:166\n BetterPetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:284\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:229\n BetterManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:337\n Sorted = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:152\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:225\n BuildSequence = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:350\n BetterDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:305\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:301\n}\nfood = nil\npetType = \"Cat\"\ndiet = <table> {\n 1 = \"Meat\"\n 2 = \"Fish\"\n}\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = \"Meat\"\n(*temporary) = \"Fish\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'food' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\BestFood.lua:207: in function `IsUsablePetFood'\nInterface\\AddOns\\xVermin\\BestFood.lua:77: in function `UpdateMacros'\nInterface\\AddOns\\xVermin\\BestFood.lua:49: in function <Interface\\AddOns\\xVermin\\BestFood.lua:44>",
			["session"] = 787,
			["counter"] = 5,
		}, -- [15]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:229: bad argument #1 to 'ipairs' (table expected, got nil)",
			["time"] = "2020/07/13 17:03:39",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"table expected, got nil\"\n = <function> defined =[C]:-1\n",
			["stack"] = "[C]: in function `ipairs'\nInterface\\AddOns\\xVermin\\BestFood.lua:229: in function `inArray'\nInterface\\AddOns\\xVermin\\BestFood.lua:217: in function `IsUsablePetFood'\nInterface\\AddOns\\xVermin\\BestFood.lua:77: in function `UpdateMacros'\nInterface\\AddOns\\xVermin\\BestFood.lua:49: in function <Interface\\AddOns\\xVermin\\BestFood.lua:44>",
			["session"] = 792,
			["counter"] = 1,
		}, -- [16]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:217: bad argument #1 to 'ipairs' (table expected, got nil)",
			["time"] = "2020/07/13 17:05:13",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"table expected, got nil\"\n = <function> defined =[C]:-1\n",
			["stack"] = "[C]: in function `ipairs'\nInterface\\AddOns\\xVermin\\BestFood.lua:217: in function `inArray'\nInterface\\AddOns\\xVermin\\BestFood.lua:213: in function `IsUsablePetFood'\nInterface\\AddOns\\xVermin\\BestFood.lua:77: in function `UpdateMacros'\nInterface\\AddOns\\xVermin\\BestFood.lua:49: in function <Interface\\AddOns\\xVermin\\BestFood.lua:44>",
			["session"] = 794,
			["counter"] = 2,
		}, -- [17]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:218: bad argument #1 to 'ipairs' (table expected, got nil)",
			["time"] = "2020/07/13 17:06:39",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"table expected, got nil\"\n = <function> defined =[C]:-1\n",
			["stack"] = "[C]: in function `ipairs'\nInterface\\AddOns\\xVermin\\BestFood.lua:218: in function `inArray'\nInterface\\AddOns\\xVermin\\BestFood.lua:214: in function `IsUsablePetFood'\nInterface\\AddOns\\xVermin\\BestFood.lua:77: in function `UpdateMacros'\nInterface\\AddOns\\xVermin\\BestFood.lua:49: in function <Interface\\AddOns\\xVermin\\BestFood.lua:44>",
			["session"] = 795,
			["counter"] = 1,
		}, -- [18]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:632: attempt to index global 'F' (a nil value)",
			["time"] = "2020/07/13 19:27:16",
			["locals"] = "defaultFoodMacro = \"#showtooltip\n/use [nocombat]<food>\n/castsequence [combat]<hPotions>\n\"\ndefaultPetFoodMacro = \"#showtooltip <petfood>\n/cast feed pet\n/use <petfood>\n\"\ndefaultDrinkMacro = \"#showtooltip\n/use [nocombat]<drink>\n/castsequence [combat]<mPotions>\n\"\nCreateOrUpdateMacro = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:27\nFirstAidSkillPoints = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:236\n(*temporary) = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:232\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:216\n IsUsableFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:177\n Bandage = <table> {\n }\n BetterFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:250\n AvailableInArray = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:198\n ManaGem = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:312\n Potion = <table> {\n }\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:304\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:246\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:224\n BetterBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:324\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:228\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:212\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:316\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:59\n BetterHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:308\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:220\n IsUsablePetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:182\n BetterPetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:267\n dirty = false\n BetterManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:320\n Sorted = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:168\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:208\n BuildSequence = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:333\n BetterDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:288\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:284\n}\n(*temporary) = \"PetFood\"\n(*temporary) = <table> {\n}\n(*temporary) = nil\n(*temporary) = <table> {\n}\n(*temporary) = 117\n(*temporary) = nil\n(*temporary) = \"BASIC\"\n(*temporary) = \"attempt to index global 'F' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\BestFood.lua:632: in main chunk",
			["session"] = 805,
			["counter"] = 1,
		}, -- [19]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:864: table index is nil",
			["time"] = "2020/07/13 19:29:16",
			["locals"] = "defaultFoodMacro = \"#showtooltip\n/use [nocombat]<food>\n/castsequence [combat]<hPotions>\n\"\ndefaultPetFoodMacro = \"#showtooltip <petfood>\n/cast feed pet\n/use <petfood>\n\"\ndefaultDrinkMacro = \"#showtooltip\n/use [nocombat]<drink>\n/castsequence [combat]<mPotions>\n\"\nCreateOrUpdateMacro = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:27\nFirstAidSkillPoints = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:236\n(*temporary) = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:232\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:216\n IsUsableFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:177\n Bandage = <table> {\n }\n BetterFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:250\n AvailableInArray = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:198\n ManaGem = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:312\n Potion = <table> {\n }\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:304\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:246\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:224\n BetterBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:324\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:228\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:212\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:316\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:59\n BetterHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:308\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:220\n IsUsablePetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:182\n BetterPetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:267\n dirty = false\n BetterManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:320\n Sorted = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:168\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:208\n BuildSequence = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:333\n BetterDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:288\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:284\n}\n(*temporary) = \"PetFood\"\n(*temporary) = <table> {\n}\n(*temporary) = nil\n(*temporary) = <table> {\n 81917 = \"BASIC\"\n 40202 = \"BASIC\"\n 20424 = \"INEDIBLE\"\n 62658 = \"BONUS\"\n 3726 = \"BONUS\"\n 12037 = \"INEDIBLE\"\n 3727 = \"BONUS\"\n 74650 = \"BONUS\"\n 67271 = \"BASIC\"\n 83097 = \"BASIC\"\n 3729 = \"BONUS\"\n 3220 = \"BONUS\"\n 3731 = \"INEDIBLE\"\n 81918 = \"BASIC\"\n 62778 = \"INEDIBLE\"\n 34736 = \"INEDIBLE\"\n 27636 = \"BONUS\"\n 59232 = \"BASIC\"\n 60268 = \"BASIC\"\n 33254 = \"BASIC\"\n 27660 = \"BONUS\"\n 35565 = \"BONUS\"\n 58268 = \"BASIC\"\n 57519 = \"BONUS\"\n 19305 = \"BASIC\"\n 20074 = \"BONUS\"\n 22644 = \"INEDIBLE\"\n 85506 = \"INEDIBLE\"\n 33454 = \"BASIC\"\n 74653 = \"BONUS\"\n 58269 = \"BASIC\"\n 43001 = \"BONUS\"\n 57544 = \"BASIC\"\n 38427 = \"BASIC\"\n 62676 = \"BASIC\"\n 32685 = \"BASIC\"\n 74654 = \"BONUS\"\n 31673 = \"BONUS\"\n 5465 = \"INEDIBLE\"\n 5467 = \"INEDIBLE\"\n 75014 = \"INEDIBLE\"\n 5469 = \"INEDIBLE\"\n 5470 = \"INEDIBLE\"\n 5471 = \"INEDIBLE\"\n 5472 = \"BONUS\"\n 62780 = \"INEDIBLE\"\n 5474 = \"BONUS\"\n 74839 = \"INEDIBLE\"\n 34754 = \"BONUS\"\n 19995 = \"BASIC\"\n 5478 = \"BASIC\"\n 65730 = \"BASIC\"\n 5480 = \"BONUS\"\n 723 = \"INEDIBLE\"\n 74838 = \"INEDIBLE\"\n 11444 = \"BASIC\"\n 3770 = \"BASIC\"\n 12213 = \"BONUS\"\n 3771 = \"BASIC\"\n 81413 = \"BONUS\"\n 43010 = \"INEDIBLE\"\n 38428 = \"BASIC\"\n 12223 = \"INEDIBLE\"\n 42779 = \"BONUS\"\n 74837 = \"INEDIBLE\"\n 34125 = \"BONUS\"\n 9681 = \"BASIC\"\n 65731 = \"BASIC\"\n 19306 = \"BASIC\"\n 74834 = \"INEDIBLE\"\n 74833 = \"INEDIBLE\"\n 67229 = \"INEDIBLE\"\n 74642 = \"BONUS\"\n 2886 = \"INEDIBLE\"\n 62784 = \"INEDIBLE\"\n 1015 = \"INEDIBLE\"\n 4739 = \"INEDIBLE\"\n 2888 = \"BONUS\"\n 27669 = \"INEDIBLE\"\n 34747 = \"BASIC\"\n 34755 = \"BONUS\"\n 67230 = \"BASIC\"\n 62781 = \"INEDIBLE\"\n 62",
			["stack"] = "Interface\\AddOns\\xVermin\\BestFood.lua:864: in main chunk",
			["session"] = 806,
			["counter"] = 1,
		}, -- [20]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:78: attempt to index field 'PetFood' (a nil value)",
			["time"] = "2020/07/13 19:27:21",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:232\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:216\n IsUsableFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:177\n Bandage = <table> {\n }\n BetterFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:250\n AvailableInArray = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:198\n ManaGem = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:312\n Potion = <table> {\n }\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:304\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:246\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:224\n BetterBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:324\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:228\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:212\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:316\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:59\n BetterHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:308\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:220\n IsUsablePetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:182\n BetterPetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:267\n dirty = false\n BetterManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:320\n Sorted = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:168\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:208\n BuildSequence = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:333\n BetterDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:288\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:284\n}\nbest = <table> {\n drink = <table> {\n }\n food = <table> {\n }\n manaGem = <table> {\n }\n mPotion = <table> {\n }\n bandage = <table> {\n }\n healthstone = <table> {\n }\n hPotion = <table> {\n }\n buffFood = <table> {\n }\n petfood = <table> {\n }\n buffDrink = <table> {\n }\n}\n(for index) = 0\n(for limit) = 4\n(for step) = 1\nbag = 0\n(for index) = 1\n(for limit) = 16\n(for step) = 1\nslot = 1\nid = 2515\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:182\n(*temporary) = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:232\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:216\n IsUsableFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:177\n Bandage = <table> {\n }\n BetterFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:250\n AvailableInArray = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:198\n ManaGem = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:312\n Potion = <table> {\n }\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:304\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:246\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:224\n BetterBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:324\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:228\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:212\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:316\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:59\n BetterHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:308\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:220\n IsUsablePetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:182\n BetterPetFood = <fu",
			["stack"] = "Interface\\AddOns\\xVermin\\BestFood.lua:78: in function `UpdateMacros'\nInterface\\AddOns\\xVermin\\BestFood.lua:50: in function <Interface\\AddOns\\xVermin\\BestFood.lua:45>",
			["session"] = 806,
			["counter"] = 7,
		}, -- [21]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:273: attempt to compare nil with number",
			["time"] = "2020/07/13 20:00:44",
			["locals"] = "a = <table> {\n id = 5469\n type = \"Meat\"\n}\nb = <table> {\n id = 2287\n type = \"Meat\"\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to compare nil with number\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\BestFood.lua:273: in function <Interface\\AddOns\\xVermin\\BestFood.lua:265>\n[C]: in function `sort'\nInterface\\AddOns\\xVermin\\BestFood.lua:173: in function `Sorted'\nInterface\\AddOns\\xVermin\\BestFood.lua:108: in function `UpdateMacros'\nInterface\\AddOns\\xVermin\\BestFood.lua:50: in function <Interface\\AddOns\\xVermin\\BestFood.lua:45>",
			["session"] = 814,
			["counter"] = 2,
		}, -- [22]
		{
			["message"] = "[string \"CharacterFeetSlot.oGlowBorder:CreateBeautyB...\"]:1: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2020/07/13 21:10:17",
			["locals"] = "(*temporary) = nil\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = 8\n(*temporary) = \"attempt to call method 'CreateBeautyBorder' (a nil value)\"\n",
			["stack"] = "[string \"CharacterFeetSlot.oGlowBorder:CreateBeautyB...\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 816,
			["counter"] = 1,
		}, -- [23]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:27: attempt to call method 'gsub' (a nil value)",
			["time"] = "2020/07/14 09:58:27",
			["locals"] = "(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = CharacterHeadSlot {\n }\n 2 = CharacterNeckSlot {\n }\n 3 = CharacterShoulderSlot {\n }\n 4 = CharacterBackSlot {\n }\n 5 = CharacterChestSlot {\n }\n 6 = CharacterWristSlot {\n }\n 7 = CharacterHandsSlot {\n }\n 8 = CharacterWaistSlot {\n }\n 9 = CharacterLegsSlot {\n }\n 10 = CharacterFeetSlot {\n }\n 11 = CharacterFinger0Slot {\n }\n 12 = CharacterFinger1Slot {\n }\n 13 = CharacterTrinket0Slot {\n }\n 14 = CharacterTrinket1Slot {\n }\n 15 = CharacterMainHandSlot {\n }\n 16 = CharacterSecondaryHandSlot {\n }\n 17 = CharacterRangedSlot {\n }\n 18 = CharacterAmmoSlot {\n }\n}\n(for control) = 1\ni = 1\nv = CharacterHeadSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136516\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterHeadSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterHeadSlotSearchOverlay {\n }\n icon = CharacterHeadSlotIconTexture {\n }\n}\n(*temporary) = nil\n(*temporary) = CharacterHeadSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136516\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterHeadSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterHeadSlotSearchOverlay {\n }\n icon = CharacterHeadSlotIconTexture {\n }\n}\n(*temporary) = \"Character\"\n(*temporary) = \"\"\n(*temporary) = \"attempt to call method 'gsub' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:27: in main chunk",
			["session"] = 820,
			["counter"] = 1,
		}, -- [24]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:28: Attempt to find 'this' in non-table object (used '.' instead of ':' ?)",
			["time"] = "2020/07/14 09:59:57",
			["locals"] = "",
			["stack"] = "[C]: in function `GetName'\nInterface\\AddOns\\xVermin\\CharacterFrame.lua:28: in main chunk",
			["session"] = 822,
			["counter"] = 1,
		}, -- [25]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:35: attempt to index global 'color' (a nil value)",
			["time"] = "2020/07/14 09:59:06",
			["locals"] = "(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = CharacterHeadSlot {\n }\n 2 = CharacterNeckSlot {\n }\n 3 = CharacterShoulderSlot {\n }\n 4 = CharacterBackSlot {\n }\n 5 = CharacterChestSlot {\n }\n 6 = CharacterWristSlot {\n }\n 7 = CharacterHandsSlot {\n }\n 8 = CharacterWaistSlot {\n }\n 9 = CharacterLegsSlot {\n }\n 10 = CharacterFeetSlot {\n }\n 11 = CharacterFinger0Slot {\n }\n 12 = CharacterFinger1Slot {\n }\n 13 = CharacterTrinket0Slot {\n }\n 14 = CharacterTrinket1Slot {\n }\n 15 = CharacterMainHandSlot {\n }\n 16 = CharacterSecondaryHandSlot {\n }\n 17 = CharacterRangedSlot {\n }\n 18 = CharacterAmmoSlot {\n }\n}\n(for control) = 1\ni = 1\nv = CharacterHeadSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n beautyShadow = <table> {\n }\n backgroundTextureName = 136516\n IconOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n checkRelic = false\n Count = CharacterHeadSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterHeadSlotSearchOverlay {\n }\n icon = CharacterHeadSlotIconTexture {\n }\n}\n(*temporary) = <function> defined @Interface\\AddOns\\!Beautycase\\!Beautycase.lua:95\n(*temporary) = CharacterHeadSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n beautyShadow = <table> {\n }\n backgroundTextureName = 136516\n IconOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n checkRelic = false\n Count = CharacterHeadSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterHeadSlotSearchOverlay {\n }\n icon = CharacterHeadSlotIconTexture {\n }\n}\n(*temporary) = nil\n(*temporary) = 8\n(*temporary) = 8\n(*temporary) = 1\n(*temporary) = 8\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = \"Interface\\AddOns\\xVermin\\media\\textureOverlay\"\n(*temporary) = true\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'color' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:35: in main chunk",
			["session"] = 824,
			["counter"] = 3,
		}, -- [26]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:28: Invalid inventory slot in GetInventorySlotInfo",
			["time"] = "2020/07/14 10:01:59",
			["locals"] = "(*temporary) = \"Head\"\n",
			["stack"] = "[C]: in function `GetInventorySlotInfo'\nInterface\\AddOns\\xVermin\\CharacterFrame.lua:28: in main chunk",
			["session"] = 825,
			["counter"] = 1,
		}, -- [27]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:30: Usage: GetItemInfo(itemID|\"name\"|\"itemlink\")",
			["time"] = "2020/07/14 10:02:54",
			["locals"] = "(*temporary) = nil\n",
			["stack"] = "[C]: in function `GetItemInfo'\nInterface\\AddOns\\xVermin\\CharacterFrame.lua:30: in main chunk",
			["session"] = 826,
			["counter"] = 1,
		}, -- [28]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:31: Usage: GetItemInfo(itemID|\"name\"|\"itemlink\")",
			["time"] = "2020/07/14 10:03:46",
			["locals"] = "(*temporary) = nil\n",
			["stack"] = "[C]: in function `GetItemInfo'\nInterface\\AddOns\\xVermin\\CharacterFrame.lua:31: in main chunk",
			["session"] = 828,
			["counter"] = 2,
		}, -- [29]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:35: Usage: GetItemInfo(itemID|\"name\"|\"itemlink\")",
			["time"] = "2020/07/14 10:06:34",
			["locals"] = "(*temporary) = nil\n",
			["stack"] = "[C]: in function `GetItemInfo'\nInterface\\AddOns\\xVermin\\CharacterFrame.lua:35: in main chunk",
			["session"] = 829,
			["counter"] = 1,
		}, -- [30]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:6: Usage: GetItemInfo(itemID|\"name\"|\"itemlink\")",
			["time"] = "2020/07/14 10:07:55",
			["locals"] = "(*temporary) = nil\n",
			["stack"] = "[C]: in function `GetItemInfo'\nInterface\\AddOns\\xVermin\\CharacterFrame.lua:6: in main chunk",
			["session"] = 830,
			["counter"] = 1,
		}, -- [31]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:30: Usage: GetItemQualityColor(index)",
			["time"] = "2020/07/14 18:10:05",
			["locals"] = "(*temporary) = nil\n",
			["stack"] = "[C]: in function `GetItemQualityColor'\nInterface\\AddOns\\xVermin\\CharacterFrame.lua:30: in function <Interface\\AddOns\\xVermin\\CharacterFrame.lua:1>",
			["session"] = 834,
			["counter"] = 2,
		}, -- [32]
		{
			["message"] = "Interface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1176: attempt to call global 'dump' (a nil value)",
			["time"] = "2020/07/14 18:18:37",
			["locals"] = "id = 6\nmenuInclude = nil\nshowButtonMenu = nil\nitemLink = nil\nitemID = 0\nitemName = \"(empty)\"\nequipSlot = nil\nitemTexture = \"Interface\\Icons\\INV_Misc_QuestionMark\"\ncol = 0\nrow = 1\nxpos = 48\nypos = -8\nmax_cols = 1\nbutton = ItemRackMenu1 {\n 0 = <userdata>\n HotKey = ItemRackMenu1HotKey {\n }\n NewActionTexture = <unnamed> {\n }\n Border = ItemRackMenu1Border {\n }\n Flash = ItemRackMenu1Flash {\n }\n icon = ItemRackMenu1Icon {\n }\n AutoCastable = <unnamed> {\n }\n SpellHighlightAnim = <unnamed> {\n }\n SpellHighlightTexture = <unnamed> {\n }\n NormalTexture = ItemRackMenu1NormalTexture {\n }\n FlyoutBorderShadow = ItemRackMenu1FlyoutBorderShadow {\n }\n FlyoutBorder = ItemRackMenu1FlyoutBorder {\n }\n Count = ItemRackMenu1Count {\n }\n AutoCastShine = ItemRackMenu1Shine {\n }\n FlyoutArrow = ItemRackMenu1FlyoutArrow {\n }\n cooldown = ItemRackMenu1Cooldown {\n }\n Name = ItemRackMenu1Name {\n }\n}\n(for index) = 1\n(for limit) = 1\n(for step) = 1\ni = 1\n(*temporary) = nil\n(*temporary) = ItemRackMenu1Icon {\n 0 = <userdata>\n}\n(*temporary) = \"attempt to call global 'dump' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1176: in function `BuildMenu'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1834: in function `DockMenuToCharacterSheet'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1814: in function `PaperDollItemSlotButton_OnEnter'\n[string \"*:OnEnter\"]:1: in function <[string \"*:OnEnter\"]:1>",
			["session"] = 837,
			["counter"] = 2,
		}, -- [33]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:40: attempt to call method 'SetBeautyBorderShadowTexture' (a nil value)",
			["time"] = "2020/07/14 18:55:45",
			["locals"] = "itemLink = nil\nr = nil\ng = nil\nb = nil\nitemLink = nil\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = CharacterHeadSlot {\n }\n 2 = CharacterNeckSlot {\n }\n 3 = CharacterShoulderSlot {\n }\n 4 = CharacterBackSlot {\n }\n 5 = CharacterChestSlot {\n }\n 6 = CharacterWristSlot {\n }\n 7 = CharacterHandsSlot {\n }\n 8 = CharacterWaistSlot {\n }\n 9 = CharacterLegsSlot {\n }\n 10 = CharacterFeetSlot {\n }\n 11 = CharacterFinger0Slot {\n }\n 12 = CharacterFinger1Slot {\n }\n 13 = CharacterTrinket0Slot {\n }\n 14 = CharacterTrinket1Slot {\n }\n 15 = CharacterMainHandSlot {\n }\n 16 = CharacterSecondaryHandSlot {\n }\n 17 = CharacterRangedSlot {\n }\n 18 = CharacterAmmoSlot {\n }\n}\n(for control) = 1\ni = 1\nv = CharacterHeadSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n beautyShadow = <table> {\n }\n backgroundTextureName = 136516\n IconOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n checkRelic = false\n Count = CharacterHeadSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterHeadSlotSearchOverlay {\n }\n icon = CharacterHeadSlotIconTexture {\n }\n}\n(*temporary) = nil\n(*temporary) = CharacterHeadSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n beautyShadow = <table> {\n }\n backgroundTextureName = 136516\n IconOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n checkRelic = false\n Count = CharacterHeadSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterHeadSlotSearchOverlay {\n }\n icon = CharacterHeadSlotIconTexture {\n }\n}\n(*temporary) = \"Interface\\AddOns\\xVermin\\media\\textureShadow\"\n(*temporary) = \"attempt to call method 'SetBeautyBorderShadowTexture' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:40: in function <Interface\\AddOns\\xVermin\\CharacterFrame.lua:1>",
			["session"] = 847,
			["counter"] = 3,
		}, -- [34]
		{
			["message"] = "Interface\\AddOns\\BuffOwner\\BuffOwner-1.1.lua:19: attempt to call method 'GetRGB' (a nil value)",
			["time"] = "2020/07/14 19:06:32",
			["locals"] = "tooltip = GameTooltip {\n 0 = <userdata>\n beautyShadow = <table> {\n }\n SetHyperlink = <function> defined =[C]:-1\n SetBackdropBorderColor = <function> defined @Interface\\AddOns\\Lorti UI Classic\\core\\frames.lua:192\n comparing = false\n beautyBorder = <table> {\n }\n TopOverlay = <unnamed> {\n }\n TMW_SetEquiv = <function> defined @Interface\\AddOns\\TellMeWhen\\Options\\TellMeWhen_Options.lua:165\n SetLootItem = <function> defined =[C]:-1\n SetQuestItem = <function> defined =[C]:-1\n SetInboxItem = <function> defined =[C]:-1\n SetBuybackItem = <function> defined =[C]:-1\n shoppingTooltips = <table> {\n }\n SetMerchantItem = <function> defined =[C]:-1\n SetQuestLogItem = <function> defined =[C]:-1\n SetTradeTargetItem = <function> defined =[C]:-1\n Background = NeavBackground {\n }\n SetTradePlayerItem = <function> defined =[C]:-1\n SetSendMailItem = <function> defined =[C]:-1\n updateTooltip = 0.095000\n SetInventoryItem = <function> defined =[C]:-1\n SetLootRollItem = <function> defined =[C]:-1\n inspectCache = <table> {\n }\n TMW_SetDogTag = <function> defined @Interface\\AddOns\\TellMeWhen\\Components\\Core\\Common\\DogTags\\config.lua:398\n SetAuctionSellItem = <function> defined =[C]:-1\n SetBagItem = <function> defined =[C]:-1\n needsReset = true\n TMW_SetSpellByIDWithClassIcon = <function> defined @Interface\\AddOns\\TellMeWhen\\Components\\Core\\Spells\\ClassSpellCache.lua:189\n BottomOverlay = <unnamed> {\n }\n TMW_SetFrameHighlight = <function> defined @Interface\\AddOns\\TellMeWhen\\Components\\GroupModules\\GroupModule_GroupPosition\\Config.lua:193\n SetAuctionItem = <function> defined =[C]:-1\n}\nfunc = <function> defined =[C]:-1\nok = true\n_ = \"Frostwolf Howler\"\n_ = 132266\n_ = 0\n_ = nil\n_ = 0\n_ = 0\ncaster = \"target\"\npet = \"target\"\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = GameTooltip {\n 0 = <userdata>\n beautyShadow = <table> {\n }\n SetHyperlink = <function> defined =[C]:-1\n SetBackdropBorderColor = <function> defined @Interface\\AddOns\\Lorti UI Classic\\core\\frames.lua:192\n comparing = false\n beautyBorder = <table> {\n }\n TopOverlay = <unnamed> {\n }\n TMW_SetEquiv = <function> defined @Interface\\AddOns\\TellMeWhen\\Options\\TellMeWhen_Options.lua:165\n SetLootItem = <function> defined =[C]:-1\n SetQuestItem = <function> defined =[C]:-1\n SetInboxItem = <function> defined =[C]:-1\n SetBuybackItem = <function> defined =[C]:-1\n shoppingTooltips = <table> {\n }\n SetMerchantItem = <function> defined =[C]:-1\n SetQuestLogItem = <function> defined =[C]:-1\n SetTradeTargetItem = <function> defined =[C]:-1\n Background = NeavBackground {\n }\n SetTradePlayerItem = <function> defined =[C]:-1\n SetSendMailItem = <function> defined =[C]:-1\n updateTooltip = 0.095000\n SetInventoryItem = <function> defined =[C]:-1\n SetLootRollItem = <function> defined =[C]:-1\n inspectCache = <table> {\n }\n TMW_SetDogTag = <function> defined @Interface\\AddOns\\TellMeWhen\\Components\\Core\\Common\\DogTags\\config.lua:398\n SetAuctionSellItem = <function> defined =[C]:-1\n SetBagItem = <function> defined =[C]:-1\n needsReset = true\n TMW_SetSpellByIDWithClassIcon = <function> defined @Interface\\AddOns\\TellMeWhen\\Components\\Core\\Spells\\ClassSpellCache.lua:189\n BottomOverlay = <unnamed> {\n }\n TMW_SetFrameHighlight = <function> defined @Interface\\AddOns\\TellMeWhen\\Components\\GroupModules\\GroupModule_GroupPosition\\Config.lua:193\n SetAuctionItem = <function> defined =[C]:-1\n}\n(*temporary) = \" \"\n(*temporary) = \"|cffffc000Source:|r Rentgen\"\n(*temporary) = 1\n(*temporary) = 0.975000\n(*temporary) = 0\n(*temporary) = nil\n(*temporary) = <table> {\n b = 1\n colorStr = \"ff326fff\"\n g = 0.435294\n r = 0.196078\n}\n(*temporary) = \"attempt to call method 'GetRGB' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\BuffOwner\\BuffOwner-1.1.lua:19: in function <Interface\\AddOns\\BuffOwner\\BuffOwner.lua:7>\n(tail call): ?\n[C]: in function `SetUnitBuff'\n[string \"*:OnEnter\"]:2: in function <[string \"*:OnEnter\"]:1>",
			["session"] = 856,
			["counter"] = 2,
		}, -- [35]
		{
			["message"] = "Interface\\AddOns\\!Beautycase\\!Beautycase.lua:73: attempt to compare number with nil",
			["time"] = "2020/07/14 20:26:25",
			["locals"] = "self = Minimap {\n 0 = <userdata>\n timer = 0\n}\nuL1 = 1\nuL2 = 1\nuR1 = 1\nuR2 = 1\nbL1 = 1\nbL2 = 1\nbR1 = 1\nbR2 = 1\nspace = nil\n(*temporary) = nil\n(*temporary) = Minimap {\n 0 = <userdata>\n timer = 0\n}\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = \"|cffFF0000!Beautycase error:|r Invalid frame! This object has no !Beautycase border\"\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = true\n(*temporary) = \"attempt to compare number with nil\"\nformatName = \"|cffFF0000!Beautycase\"\nGetBeautyBorderInfo = <function> defined @Interface\\AddOns\\!Beautycase\\!Beautycase.lua:39\n",
			["stack"] = "Interface\\AddOns\\!Beautycase\\!Beautycase.lua:73: in function `SetBeautyBorderPadding'\nInterface\\AddOns\\nMinimap\\core.lua:89: in main chunk",
			["session"] = 858,
			["counter"] = 1,
		}, -- [36]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:32: attempt to concatenate field 'iq' (a nil value)",
			["time"] = "2020/07/14 21:19:17",
			["locals"] = "itemLink = nil\nr = 0.117647\ng = 1\nb = 0\nitemLink = \"|cff1eff00|Hitem:5346::::::::13:::11::::|h[Orcish Battle Bow]|h|r\"\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = CharacterHeadSlot {\n }\n 2 = CharacterNeckSlot {\n }\n 3 = CharacterShoulderSlot {\n }\n 4 = CharacterBackSlot {\n }\n 5 = CharacterChestSlot {\n }\n 6 = CharacterWristSlot {\n }\n 7 = CharacterHandsSlot {\n }\n 8 = CharacterWaistSlot {\n }\n 9 = CharacterLegsSlot {\n }\n 10 = CharacterFeetSlot {\n }\n 11 = CharacterFinger0Slot {\n }\n 12 = CharacterFinger1Slot {\n }\n 13 = CharacterTrinket0Slot {\n }\n 14 = CharacterTrinket1Slot {\n }\n 15 = CharacterMainHandSlot {\n }\n 16 = CharacterSecondaryHandSlot {\n }\n 17 = CharacterRangedSlot {\n }\n 18 = CharacterAmmoSlot {\n }\n}\n(for control) = 17\ni = 17\nv = CharacterRangedSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n beautyShadow = <table> {\n }\n backgroundTextureName = 136520\n IconOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n checkRelic = true\n Count = CharacterRangedSlotCount {\n }\n IconBorder = <unnamed> {\n }\n hasItem = 1\n searchOverlay = CharacterRangedSlotSearchOverlay {\n }\n icon = CharacterRangedSlotIconTexture {\n }\n count = 1\n}\n(*temporary) = <function> defined @Interface\\AddOns\\!Beautycase\\!Beautycase.lua:130\n(*temporary) = CharacterRangedSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n beautyShadow = <table> {\n }\n backgroundTextureName = 136520\n IconOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n checkRelic = true\n Count = CharacterRangedSlotCount {\n }\n IconBorder = <unnamed> {\n }\n hasItem = 1\n searchOverlay = CharacterRangedSlotSearchOverlay {\n }\n icon = CharacterRangedSlotIconTexture {\n }\n count = 1\n}\n(*temporary) = nil\n(*temporary) = 2\n(*temporary) = 0\n(*temporary) = \"ff1eff00\"\n(*temporary) = 0\n(*temporary) = \"Weapon\"\n(*temporary) = \"Bows\"\n(*temporary) = 1\n(*temporary) = \"INVTYPE_RANGED\"\n(*temporary) = 135496\n(*temporary) = 425\n(*temporary) = 2\n(*temporary) = 2\n(*temporary) = \"attempt to concatenate field 'iq' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:32: in function <Interface\\AddOns\\xVermin\\CharacterFrame.lua:1>",
			["session"] = 871,
			["counter"] = 2,
		}, -- [37]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:34: attempt to concatenate field 'iq' (a table value)",
			["time"] = "2020/07/14 21:32:14",
			["locals"] = "itemLink = nil\nr = 0.117647\ng = 1\nb = 0\nitemLink = \"|cff1eff00|Hitem:5346::::::::13:::11::::|h[Orcish Battle Bow]|h|r\"\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = CharacterHeadSlot {\n }\n 2 = CharacterNeckSlot {\n }\n 3 = CharacterShoulderSlot {\n }\n 4 = CharacterBackSlot {\n }\n 5 = CharacterChestSlot {\n }\n 6 = CharacterWristSlot {\n }\n 7 = CharacterHandsSlot {\n }\n 8 = CharacterWaistSlot {\n }\n 9 = CharacterLegsSlot {\n }\n 10 = CharacterFeetSlot {\n }\n 11 = CharacterFinger0Slot {\n }\n 12 = CharacterFinger1Slot {\n }\n 13 = CharacterTrinket0Slot {\n }\n 14 = CharacterTrinket1Slot {\n }\n 15 = CharacterMainHandSlot {\n }\n 16 = CharacterSecondaryHandSlot {\n }\n 17 = CharacterRangedSlot {\n }\n 18 = CharacterAmmoSlot {\n }\n}\n(for control) = 17\ni = 17\nv = CharacterRangedSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n beautyShadow = <table> {\n }\n backgroundTextureName = 136520\n IconOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n checkRelic = true\n Count = CharacterRangedSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterRangedSlotSearchOverlay {\n }\n icon = CharacterRangedSlotIconTexture {\n }\n}\n(*temporary) = <function> defined @Interface\\AddOns\\!Beautycase\\!Beautycase.lua:130\n(*temporary) = CharacterRangedSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n beautyShadow = <table> {\n }\n backgroundTextureName = 136520\n IconOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n checkRelic = true\n Count = CharacterRangedSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterRangedSlotSearchOverlay {\n }\n icon = CharacterRangedSlotIconTexture {\n }\n}\n(*temporary) = <table> {\n 1 = \"Interface\\AddOns\\xVermin\\media\\ItemQuality0\"\n 2 = \"Interface\\AddOns\\xVermin\\media\\ItemQuality1\"\n 3 = \"Interface\\AddOns\\xVermin\\media\\ItemQuality2\"\n 4 = \"Interface\\AddOns\\xVermin\\media\\ItemQuality3\"\n 5 = \"Interface\\AddOns\\xVermin\\media\\ItemQuality4\"\n 6 = \"Interface\\AddOns\\xVermin\\media\\ItemQuality5\"\n 7 = \"Interface\\AddOns\\xVermin\\media\\ItemQuality6\"\n 8 = \"Interface\\AddOns\\xVermin\\media\\ItemQuality7\"\n}\n(*temporary) = 2\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = true\n(*temporary) = true\n(*temporary) = true\n(*temporary) = true\n(*temporary) = nil\n(*temporary) = 2\n(*temporary) = true\n(*temporary) = nil\n(*temporary) = true\n(*temporary) = nil\n(*temporary) = \"attempt to concatenate field 'iq' (a table value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:34: in function <Interface\\AddOns\\xVermin\\CharacterFrame.lua:1>",
			["session"] = 872,
			["counter"] = 1,
		}, -- [38]
		{
			["message"] = "[string \"PetActionBarButton2:SetScale(2)\"]:1: attempt to index global 'PetActionBarButton2' (a nil value)",
			["time"] = "2020/07/14 21:34:16",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'PetActionBarButton2' (a nil value)\"\n",
			["stack"] = "[string \"PetActionBarButton2:SetScale(2)\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 873,
			["counter"] = 1,
		}, -- [39]
		{
			["message"] = "[string \"PetActionButton1:setScale(5)\"]:1: attempt to call method 'setScale' (a nil value)",
			["time"] = "2020/07/14 21:41:38",
			["locals"] = "(*temporary) = nil\n(*temporary) = PetActionButton1 {\n 0 = <userdata>\n HotKey = PetActionButton1HotKey {\n }\n NewActionTexture = <unnamed> {\n }\n Border = PetActionButton1Border {\n }\n Flash = PetActionButton1Flash {\n }\n tooltipName = \"Attack\"\n icon = PetActionButton1Icon {\n }\n AutoCastable = <unnamed> {\n }\n SpellHighlightAnim = <unnamed> {\n }\n SetPoint = <function> defined @Interface\\AddOns\\xVermin\\xVermin.lua:188\n ClearAllPoints = <function> defined @Interface\\AddOns\\xVermin\\xVermin.lua:186\n Shadow = <unnamed> {\n }\n flashing = false\n SpellHighlightTexture = <unnamed> {\n }\n NormalTexture = <table> {\n }\n isToken = 1\n FlyoutBorderShadow = PetActionButton1FlyoutBorderShadow {\n }\n FlyoutBorder = PetActionButton1FlyoutBorder {\n }\n Count = PetActionButton1Count {\n }\n AutoCastShine = PetActionButton1Shine {\n }\n FlyoutArrow = PetActionButton1FlyoutArrow {\n }\n cooldown = PetActionButton1Cooldown {\n }\n Name = PetActionButton1Name {\n }\n}\n(*temporary) = 5\n(*temporary) = \"attempt to call method 'setScale' (a nil value)\"\n",
			["stack"] = "[string \"PetActionButton1:setScale(5)\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 875,
			["counter"] = 1,
		}, -- [40]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:26: attempt to concatenate global 'name' (a nil value)",
			["time"] = "2020/07/14 21:48:53",
			["locals"] = "itemLink = nil\nr = nil\ng = nil\nb = nil\nitemLink = nil\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = CharacterHeadSlot {\n }\n 2 = CharacterNeckSlot {\n }\n 3 = CharacterShoulderSlot {\n }\n 4 = CharacterBackSlot {\n }\n 5 = CharacterChestSlot {\n }\n 6 = CharacterWristSlot {\n }\n 7 = CharacterHandsSlot {\n }\n 8 = CharacterWaistSlot {\n }\n 9 = CharacterLegsSlot {\n }\n 10 = CharacterFeetSlot {\n }\n 11 = CharacterFinger0Slot {\n }\n 12 = CharacterFinger1Slot {\n }\n 13 = CharacterTrinket0Slot {\n }\n 14 = CharacterTrinket1Slot {\n }\n 15 = CharacterMainHandSlot {\n }\n 16 = CharacterSecondaryHandSlot {\n }\n 17 = CharacterRangedSlot {\n }\n 18 = CharacterAmmoSlot {\n }\n}\n(for control) = 1\ni = 1\nv = CharacterHeadSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136516\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterHeadSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterHeadSlotSearchOverlay {\n }\n icon = CharacterHeadSlotIconTexture {\n }\n}\n(*temporary) = <table> {\n UpdateOnBarHighlightMarksBySpell = <function> defined @Interface\\FrameXML\\ActionButton.lua:70\n ERR_OUT_OF_CHI = \"Not enough chi\"\n DH_HAVOC_CORE_ABILITY_2 = \"Strong melee attack that consumes Fury. If it critical strikes, some Fury is refunded.\"\n MerchantItem9ItemButtonStock = MerchantItem9ItemButtonStock {\n }\n GetTrainerServiceTypeFilter = <function> defined =[C]:-1\n UNIT_NAMES_COMBATLOG_TOOLTIP = \"Color unit names.\"\n SetTrainerServiceTypeFilter = <function> defined =[C]:-1\n LE_GAME_ERR_CHAT_RAID_RESTRICTED_TRIAL = 742\n SPELL_FAILED_CUSTOM_ERROR_71 = \"This partygoer wants to dance with you.\"\n LE_GAME_ERR_PET_SPELL_TARGETS_DEAD = 399\n ERROR_CLUB_TICKET_COUNT_AT_MAX_COMMUNITY = \"Can't create any more invite links for this group.\"\n RecruitAFriendFrame = RecruitAFriendFrame {\n }\n CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdownButtonNormalTexture = CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdownButtonNormalTexture {\n }\n ERR_TRADE_EQUIPPED_BAG = \"You can't trade equipped bags.\"\n PVP_RANK_6_1 = \"Corporal\"\n MultiBarLeftButton7 = MultiBarLeftButton7 {\n }\n InterfaceOptionsNamesPanelUnitNameplatesShowAll = InterfaceOptionsNamesPanelUnitNameplatesShowAll {\n }\n VideoOptionsFrameDefaults = VideoOptionsFrameDefaults {\n }\n MerchantItem2AltCurrencyFrameItem1Text = MerchantItem2AltCurrencyFrameItem1Text {\n }\n OPTION_TOOLTIP_ACTION_BUTTON_USE_KEY_DOWN = \"Action button keybinds will respond on key down, rather than on key up.\"\n BINDING_NAME_NAMEPLATES = \"Show Enemy Name Plates\"\n INSTANCE_UNAVAILABLE_OTHER_TEMPORARILY_DISABLED = \"%s cannot enter. This instance is temporarily disabled.\"\n MultiBarBottomRightButton8Shine5 = MultiBarBottomRightButton8Shine5 {\n }\n IsReferAFriendLinked = <function> defined =[C]:-1\n MAIL_LETTER_TOOLTIP = \"Click to make a permanent\ncopy of this letter.\"\n UnitFrameManaBar_UnregisterDefaultEvents = <function> defined @Interface\\FrameXML\\UnitFrame.lua:602\n ERR_NOAMMO_S = \"%s\"\n CHAT_CONFIG_OTHER_COMBAT = <table> {\n }\n FCFDockOverflowButton_OnClick = <function> defined @Interface\\FrameXML\\FloatingChatFrame.lua:2373\n BOOST2_WARRIOR_COLOSSUSSMASH = \"Use |cFFFFFFFFColossus Smash|r.\n\n|cFFFFFFFFColossus Smash|r increases your damage.\"\n BN_UNABLE_TO_RESOLVE_NAME = \"Unable to whisper '%s'. Blizzard services may be unavailable.\"\n LE_GAME_ERR_RECRUIT_A_FRIEND_FAILED = 952\n CompactRaidFrameManagerDisplayFrameHiddenModeToggleTopRight = CompactRaidFrameManagerDisplayFrameHiddenModeToggleTopRight {\n }\n LE_GAME_ERR_ONLY_ONE_QUIVER = 32\n SpellButton6Cooldown = SpellButton6Cooldown {\n }\n LOSS_OF_CONTROL_DISPLAY_FEAR = \"Feared\"\n Graphics_QualityText = Graphics_QualityText {\n }\n VOICEMACRO_4_Sc_1_FEMALE = \"Help me attack!\"\n StanceButton4FlyoutArrow = StanceButton4FlyoutArrow {\n }\n MultiBarRightButton7Shine9 = MultiBarRightButton7Shine9 {\n }\n BankFrameItem17SearchOverlay = BankFrameItem17SearchOverlay {\n }\n DMG_LCD = \"DMG\"\n VideoOptionsPanel_Cancel = <function> defined @Interface\\SharedXML\\VideoOptionsPanels.lua:315\n HubPanelProfileDefaultFrie",
			["stack"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:26: in function <Interface\\AddOns\\xVermin\\CharacterFrame.lua:1>",
			["session"] = 876,
			["counter"] = 1,
		}, -- [41]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:26: attempt to concatenate local 'v' (a table value)",
			["time"] = "2020/07/14 21:49:25",
			["locals"] = "itemLink = nil\nr = nil\ng = nil\nb = nil\nitemLink = nil\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = CharacterHeadSlot {\n }\n 2 = CharacterNeckSlot {\n }\n 3 = CharacterShoulderSlot {\n }\n 4 = CharacterBackSlot {\n }\n 5 = CharacterChestSlot {\n }\n 6 = CharacterWristSlot {\n }\n 7 = CharacterHandsSlot {\n }\n 8 = CharacterWaistSlot {\n }\n 9 = CharacterLegsSlot {\n }\n 10 = CharacterFeetSlot {\n }\n 11 = CharacterFinger0Slot {\n }\n 12 = CharacterFinger1Slot {\n }\n 13 = CharacterTrinket0Slot {\n }\n 14 = CharacterTrinket1Slot {\n }\n 15 = CharacterMainHandSlot {\n }\n 16 = CharacterSecondaryHandSlot {\n }\n 17 = CharacterRangedSlot {\n }\n 18 = CharacterAmmoSlot {\n }\n}\n(for control) = 1\ni = 1\nv = CharacterHeadSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136516\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterHeadSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterHeadSlotSearchOverlay {\n }\n icon = CharacterHeadSlotIconTexture {\n }\n}\n(*temporary) = <table> {\n UpdateOnBarHighlightMarksBySpell = <function> defined @Interface\\FrameXML\\ActionButton.lua:70\n ERR_OUT_OF_CHI = \"Not enough chi\"\n DH_HAVOC_CORE_ABILITY_2 = \"Strong melee attack that consumes Fury. If it critical strikes, some Fury is refunded.\"\n MerchantItem9ItemButtonStock = MerchantItem9ItemButtonStock {\n }\n GetTrainerServiceTypeFilter = <function> defined =[C]:-1\n UNIT_NAMES_COMBATLOG_TOOLTIP = \"Color unit names.\"\n SetTrainerServiceTypeFilter = <function> defined =[C]:-1\n LE_GAME_ERR_CHAT_RAID_RESTRICTED_TRIAL = 742\n SPELL_FAILED_CUSTOM_ERROR_71 = \"This partygoer wants to dance with you.\"\n LE_GAME_ERR_PET_SPELL_TARGETS_DEAD = 399\n ERROR_CLUB_TICKET_COUNT_AT_MAX_COMMUNITY = \"Can't create any more invite links for this group.\"\n RecruitAFriendFrame = RecruitAFriendFrame {\n }\n CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdownButtonNormalTexture = CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdownButtonNormalTexture {\n }\n ERR_TRADE_EQUIPPED_BAG = \"You can't trade equipped bags.\"\n PVP_RANK_6_1 = \"Corporal\"\n MultiBarLeftButton7 = MultiBarLeftButton7 {\n }\n InterfaceOptionsNamesPanelUnitNameplatesShowAll = InterfaceOptionsNamesPanelUnitNameplatesShowAll {\n }\n VideoOptionsFrameDefaults = VideoOptionsFrameDefaults {\n }\n MerchantItem2AltCurrencyFrameItem1Text = MerchantItem2AltCurrencyFrameItem1Text {\n }\n OPTION_TOOLTIP_ACTION_BUTTON_USE_KEY_DOWN = \"Action button keybinds will respond on key down, rather than on key up.\"\n BINDING_NAME_NAMEPLATES = \"Show Enemy Name Plates\"\n INSTANCE_UNAVAILABLE_OTHER_TEMPORARILY_DISABLED = \"%s cannot enter. This instance is temporarily disabled.\"\n MultiBarBottomRightButton8Shine5 = MultiBarBottomRightButton8Shine5 {\n }\n IsReferAFriendLinked = <function> defined =[C]:-1\n MAIL_LETTER_TOOLTIP = \"Click to make a permanent\ncopy of this letter.\"\n UnitFrameManaBar_UnregisterDefaultEvents = <function> defined @Interface\\FrameXML\\UnitFrame.lua:602\n ERR_NOAMMO_S = \"%s\"\n CHAT_CONFIG_OTHER_COMBAT = <table> {\n }\n FCFDockOverflowButton_OnClick = <function> defined @Interface\\FrameXML\\FloatingChatFrame.lua:2373\n BOOST2_WARRIOR_COLOSSUSSMASH = \"Use |cFFFFFFFFColossus Smash|r.\n\n|cFFFFFFFFColossus Smash|r increases your damage.\"\n BN_UNABLE_TO_RESOLVE_NAME = \"Unable to whisper '%s'. Blizzard services may be unavailable.\"\n LE_GAME_ERR_RECRUIT_A_FRIEND_FAILED = 952\n CompactRaidFrameManagerDisplayFrameHiddenModeToggleTopRight = CompactRaidFrameManagerDisplayFrameHiddenModeToggleTopRight {\n }\n LE_GAME_ERR_ONLY_ONE_QUIVER = 32\n SpellButton6Cooldown = SpellButton6Cooldown {\n }\n LOSS_OF_CONTROL_DISPLAY_FEAR = \"Feared\"\n Graphics_QualityText = Graphics_QualityText {\n }\n VOICEMACRO_4_Sc_1_FEMALE = \"Help me attack!\"\n StanceButton4FlyoutArrow = StanceButton4FlyoutArrow {\n }\n MultiBarRightButton7Shine9 = MultiBarRightButton7Shine9 {\n }\n BankFrameItem17SearchOverlay = BankFrameItem17SearchOverlay {\n }\n DMG_LCD = \"DMG\"\n VideoOptionsPanel_Cancel = <function> defined @Interface\\SharedXML\\VideoOptionsPanels.lua:315\n HubPanelProfileDefaultFrie",
			["stack"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:26: in function <Interface\\AddOns\\xVermin\\CharacterFrame.lua:1>",
			["session"] = 877,
			["counter"] = 1,
		}, -- [42]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:27: attempt to index local 'normal' (a nil value)",
			["time"] = "2020/07/14 21:50:18",
			["locals"] = "itemLink = nil\nr = nil\ng = nil\nb = nil\nitemLink = nil\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = CharacterHeadSlot {\n }\n 2 = CharacterNeckSlot {\n }\n 3 = CharacterShoulderSlot {\n }\n 4 = CharacterBackSlot {\n }\n 5 = CharacterChestSlot {\n }\n 6 = CharacterWristSlot {\n }\n 7 = CharacterHandsSlot {\n }\n 8 = CharacterWaistSlot {\n }\n 9 = CharacterLegsSlot {\n }\n 10 = CharacterFeetSlot {\n }\n 11 = CharacterFinger0Slot {\n }\n 12 = CharacterFinger1Slot {\n }\n 13 = CharacterTrinket0Slot {\n }\n 14 = CharacterTrinket1Slot {\n }\n 15 = CharacterMainHandSlot {\n }\n 16 = CharacterSecondaryHandSlot {\n }\n 17 = CharacterRangedSlot {\n }\n 18 = CharacterAmmoSlot {\n }\n}\n(for control) = 1\ni = 1\nv = CharacterHeadSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136516\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterHeadSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterHeadSlotSearchOverlay {\n }\n icon = CharacterHeadSlotIconTexture {\n }\n}\nnormal = nil\n(*temporary) = \"ItemSlot1NormalTexture\"\n(*temporary) = nil\n(*temporary) = \"NormalTexture\"\n(*temporary) = CharacterWaistSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136529\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterWaistSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterWaistSlotSearchOverlay {\n }\n icon = CharacterWaistSlotIconTexture {\n }\n}\n(*temporary) = CharacterLegsSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136517\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterLegsSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterLegsSlotSearchOverlay {\n }\n icon = CharacterLegsSlotIconTexture {\n }\n}\n(*temporary) = CharacterFeetSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136513\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterFeetSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterFeetSlotSearchOverlay {\n }\n icon = CharacterFeetSlotIconTexture {\n }\n}\n(*temporary) = CharacterFinger0Slot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136514\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterFinger0SlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterFinger0SlotSearchOverlay {\n }\n icon = CharacterFinger0SlotIconTexture {\n }\n}\n(*temporary) = CharacterFinger1Slot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136514\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterFinger1SlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterFinger1SlotSearchOverlay {\n }\n icon = CharacterFinger1SlotIconTexture {\n }\n}\n(*temporary) = CharacterTrinket0Slot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136528\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterTrinket0SlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterTrinket0SlotSearchOverlay {\n }\n icon = CharacterTrinket0SlotIconTexture {\n }\n}\n(*temporary) = CharacterTrinket1Slot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136528\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterTrinket1SlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterTrinket1SlotSearchOverlay {\n }\n icon = CharacterTrinket1SlotIconTexture {\n }\n}\n(*temporary) = CharacterMainHandSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136518\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterMainHandSl",
			["stack"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:27: in function <Interface\\AddOns\\xVermin\\CharacterFrame.lua:1>",
			["session"] = 878,
			["counter"] = 1,
		}, -- [43]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:28: attempt to index local 'normal' (a nil value)",
			["time"] = "2020/07/14 21:51:23",
			["locals"] = "itemLink = nil\nr = nil\ng = nil\nb = nil\nitemLink = nil\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = CharacterHeadSlot {\n }\n 2 = CharacterNeckSlot {\n }\n 3 = CharacterShoulderSlot {\n }\n 4 = CharacterBackSlot {\n }\n 5 = CharacterChestSlot {\n }\n 6 = CharacterWristSlot {\n }\n 7 = CharacterHandsSlot {\n }\n 8 = CharacterWaistSlot {\n }\n 9 = CharacterLegsSlot {\n }\n 10 = CharacterFeetSlot {\n }\n 11 = CharacterFinger0Slot {\n }\n 12 = CharacterFinger1Slot {\n }\n 13 = CharacterTrinket0Slot {\n }\n 14 = CharacterTrinket1Slot {\n }\n 15 = CharacterMainHandSlot {\n }\n 16 = CharacterSecondaryHandSlot {\n }\n 17 = CharacterRangedSlot {\n }\n 18 = CharacterAmmoSlot {\n }\n}\n(for control) = 1\ni = 1\nv = CharacterHeadSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136516\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterHeadSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterHeadSlotSearchOverlay {\n }\n icon = CharacterHeadSlotIconTexture {\n }\n}\nnormal = nil\n(*temporary) = \"ItemSlot1NormalTexture\"\n(*temporary) = nil\n(*temporary) = \"NormalTexture\"\n(*temporary) = CharacterWaistSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136529\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterWaistSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterWaistSlotSearchOverlay {\n }\n icon = CharacterWaistSlotIconTexture {\n }\n}\n(*temporary) = CharacterLegsSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136517\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterLegsSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterLegsSlotSearchOverlay {\n }\n icon = CharacterLegsSlotIconTexture {\n }\n}\n(*temporary) = CharacterFeetSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136513\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterFeetSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterFeetSlotSearchOverlay {\n }\n icon = CharacterFeetSlotIconTexture {\n }\n}\n(*temporary) = CharacterFinger0Slot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136514\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterFinger0SlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterFinger0SlotSearchOverlay {\n }\n icon = CharacterFinger0SlotIconTexture {\n }\n}\n(*temporary) = CharacterFinger1Slot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136514\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterFinger1SlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterFinger1SlotSearchOverlay {\n }\n icon = CharacterFinger1SlotIconTexture {\n }\n}\n(*temporary) = CharacterTrinket0Slot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136528\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterTrinket0SlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterTrinket0SlotSearchOverlay {\n }\n icon = CharacterTrinket0SlotIconTexture {\n }\n}\n(*temporary) = CharacterTrinket1Slot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136528\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterTrinket1SlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterTrinket1SlotSearchOverlay {\n }\n icon = CharacterTrinket1SlotIconTexture {\n }\n}\n(*temporary) = CharacterMainHandSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n backgroundTextureName = 136518\n IconOverlay = <unnamed> {\n }\n checkRelic = false\n Count = CharacterMainHandSl",
			["stack"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:28: in function <Interface\\AddOns\\xVermin\\CharacterFrame.lua:1>",
			["session"] = 879,
			["counter"] = 1,
		}, -- [44]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:27: Attempt to find 'this' in non-table object (used '.' instead of ':' ?)",
			["time"] = "2020/07/14 21:53:26",
			["locals"] = "",
			["stack"] = "[C]: in function `GetName'\nInterface\\AddOns\\xVermin\\CharacterFrame.lua:27: in function <Interface\\AddOns\\xVermin\\CharacterFrame.lua:1>",
			["session"] = 880,
			["counter"] = 1,
		}, -- [45]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:47: CharacterHeadSlotNormalTexture:SetAllPoints(): trying to anchor to itself",
			["time"] = "2020/07/14 21:56:07",
			["locals"] = "(*temporary) = CharacterHeadSlotNormalTexture {\n 0 = <userdata>\n}\n(*temporary) = CharacterHeadSlotNormalTexture {\n 0 = <userdata>\n}\n",
			["stack"] = "[C]: in function `SetAllPoints'\nInterface\\AddOns\\xVermin\\CharacterFrame.lua:47: in function <Interface\\AddOns\\xVermin\\CharacterFrame.lua:1>",
			["session"] = 883,
			["counter"] = 1,
		}, -- [46]
		{
			["message"] = "Interface\\AddOns\\xVermin\\CharacterFrame.lua:43: CharacterBackSlotNormalTexture:SetAllPoints(): trying to anchor to itself",
			["time"] = "2020/07/14 21:57:48",
			["locals"] = "(*temporary) = CharacterBackSlotNormalTexture {\n 0 = <userdata>\n}\n(*temporary) = CharacterBackSlotNormalTexture {\n 0 = <userdata>\n}\n",
			["stack"] = "[C]: in function `SetAllPoints'\nInterface\\AddOns\\xVermin\\CharacterFrame.lua:43: in function <Interface\\AddOns\\xVermin\\CharacterFrame.lua:1>",
			["session"] = 885,
			["counter"] = 1,
		}, -- [47]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:176: CreateFrame: Unknown frame type 'pf'",
			["time"] = "2020/07/15 12:53:06",
			["locals"] = "(*temporary) = \"pf\"\n",
			["stack"] = "[C]: in function `CreateFrame'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:176: in main chunk",
			["session"] = 896,
			["counter"] = 3,
		}, -- [48]
		{
			["message"] = "[string \"TalentFrame1:CreateBeautyBorder(8)\"]:1: attempt to index global 'TalentFrame1' (a nil value)",
			["time"] = "2020/07/15 13:04:22",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'TalentFrame1' (a nil value)\"\n",
			["stack"] = "[string \"TalentFrame1:CreateBeautyBorder(8)\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 899,
			["counter"] = 1,
		}, -- [49]
		{
			["message"] = "[string \"TalentFrameTalent1RankBorder:CreateBeautyBo...\"]:1: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2020/07/15 13:07:09",
			["locals"] = "(*temporary) = nil\n(*temporary) = TalentFrameTalent1RankBorder {\n 0 = <userdata>\n}\n(*temporary) = 4\n(*temporary) = \"attempt to call method 'CreateBeautyBorder' (a nil value)\"\n",
			["stack"] = "[string \"TalentFrameTalent1RankBorder:CreateBeautyBo...\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 899,
			["counter"] = 1,
		}, -- [50]
		{
			["message"] = "[string \"TalentFrameTalentRank1Border:Hide()\"]:1: attempt to index global 'TalentFrameTalentRank1Border' (a nil value)",
			["time"] = "2020/07/15 13:07:46",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'TalentFrameTalentRank1Border' (a nil value)\"\n",
			["stack"] = "[string \"TalentFrameTalentRank1Border:Hide()\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 899,
			["counter"] = 1,
		}, -- [51]
		{
			["message"] = "[string \"TalentFrameTalent1Slot:CreateBeautyBorder(4...\"]:1: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2020/07/15 13:08:57",
			["locals"] = "(*temporary) = nil\n(*temporary) = TalentFrameTalent1Slot {\n 0 = <userdata>\n}\n(*temporary) = 4\n(*temporary) = \"attempt to call method 'CreateBeautyBorder' (a nil value)\"\n",
			["stack"] = "[string \"TalentFrameTalent1Slot:CreateBeautyBorder(4...\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 900,
			["counter"] = 3,
		}, -- [52]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:2: attempt to concatenate global 'TalentFrameTalent' (a nil value)",
			["time"] = "2020/07/15 16:43:00",
			["locals"] = "(for index) = 1\n(for limit) = 46\n(for step) = 1\ni = 1\n(*temporary) = <table> {\n UpdateOnBarHighlightMarksBySpell = <function> defined @Interface\\FrameXML\\ActionButton.lua:70\n ERR_OUT_OF_CHI = \"Not enough chi\"\n DH_HAVOC_CORE_ABILITY_2 = \"Strong melee attack that consumes Fury. If it critical strikes, some Fury is refunded.\"\n MerchantItem9ItemButtonStock = MerchantItem9ItemButtonStock {\n }\n GetTrainerServiceTypeFilter = <function> defined =[C]:-1\n UNIT_NAMES_COMBATLOG_TOOLTIP = \"Color unit names.\"\n SetTrainerServiceTypeFilter = <function> defined =[C]:-1\n LE_GAME_ERR_CHAT_RAID_RESTRICTED_TRIAL = 742\n SPELL_FAILED_CUSTOM_ERROR_71 = \"This partygoer wants to dance with you.\"\n LE_GAME_ERR_PET_SPELL_TARGETS_DEAD = 399\n ERROR_CLUB_TICKET_COUNT_AT_MAX_COMMUNITY = \"Can't create any more invite links for this group.\"\n RecruitAFriendFrame = RecruitAFriendFrame {\n }\n CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdownButtonNormalTexture = CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdownButtonNormalTexture {\n }\n ERR_TRADE_EQUIPPED_BAG = \"You can't trade equipped bags.\"\n PVP_RANK_6_1 = \"Corporal\"\n MultiBarLeftButton7 = MultiBarLeftButton7 {\n }\n InterfaceOptionsNamesPanelUnitNameplatesShowAll = InterfaceOptionsNamesPanelUnitNameplatesShowAll {\n }\n VideoOptionsFrameDefaults = VideoOptionsFrameDefaults {\n }\n MerchantItem2AltCurrencyFrameItem1Text = MerchantItem2AltCurrencyFrameItem1Text {\n }\n OPTION_TOOLTIP_ACTION_BUTTON_USE_KEY_DOWN = \"Action button keybinds will respond on key down, rather than on key up.\"\n BINDING_NAME_NAMEPLATES = \"Show Enemy Name Plates\"\n INSTANCE_UNAVAILABLE_OTHER_TEMPORARILY_DISABLED = \"%s cannot enter. This instance is temporarily disabled.\"\n MultiBarBottomRightButton8Shine5 = MultiBarBottomRightButton8Shine5 {\n }\n IsReferAFriendLinked = <function> defined =[C]:-1\n MAIL_LETTER_TOOLTIP = \"Click to make a permanent\ncopy of this letter.\"\n UnitFrameManaBar_UnregisterDefaultEvents = <function> defined @Interface\\FrameXML\\UnitFrame.lua:602\n DUNGEON_FLOOR_UPPERBLACKROCKSPIRE3 = \"Hall of Blackhand\"\n CHAT_CONFIG_OTHER_COMBAT = <table> {\n }\n FCFDockOverflowButton_OnClick = <function> defined @Interface\\FrameXML\\FloatingChatFrame.lua:2373\n BOOST2_WARRIOR_COLOSSUSSMASH = \"Use |cFFFFFFFFColossus Smash|r.\n\n|cFFFFFFFFColossus Smash|r increases your damage.\"\n BN_UNABLE_TO_RESOLVE_NAME = \"Unable to whisper '%s'. Blizzard services may be unavailable.\"\n LE_GAME_ERR_RECRUIT_A_FRIEND_FAILED = 952\n CompactRaidFrameManagerDisplayFrameHiddenModeToggleTopRight = CompactRaidFrameManagerDisplayFrameHiddenModeToggleTopRight {\n }\n LE_GAME_ERR_ONLY_ONE_QUIVER = 32\n SpellButton6Cooldown = SpellButton6Cooldown {\n }\n LOSS_OF_CONTROL_DISPLAY_FEAR = \"Feared\"\n Graphics_QualityText = Graphics_QualityText {\n }\n ROGUE_COMBAT_CORE_ABILITY_4 = \"Melee ability with an increased range that consumes Combo Points.\"\n StanceButton4FlyoutArrow = StanceButton4FlyoutArrow {\n }\n MultiBarRightButton7Shine9 = MultiBarRightButton7Shine9 {\n }\n BankFrameItem17SearchOverlay = BankFrameItem17SearchOverlay {\n }\n DMG_LCD = \"DMG\"\n RaidGraphics_EnvironmentalDetailSlider = RaidGraphics_EnvironmentalDetailSlider {\n }\n HubPanelProfileDefaultFriendlyNameColorMode = HubPanelProfileDefaultFriendlyNameColorMode {\n }\n Is64BitClient = <function> defined =[C]:-1\n SecureCmdItemParse = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1111\n SLASH_STOPATTACK1 = \"/stopattack\"\n SortQuestWatches = <function> defined =[C]:-1\n ContainerFrame4Item16Cooldown = ContainerFrame4Item16Cooldown {\n }\n MINIMAP_TRACKING_TRAINER_CLASS = \"Class Trainer\"\n SLASH_DISMOUNT2 = \"/dismount\"\n DUNGEON_FLOOR_DRAGONBLIGHTCHROMIESCENARIO2 = \"Andorhal\"\n PlayerFrame_UpdateReadyCheck = <function> defined @Interface\\FrameXML\\PlayerFrame.lua:345\n EMOTE69_CMD1 = \"/nosepick\"\n WowTokenRedemptionFrameBg = WowTokenRedemptionFrameBg {\n }\n SHIELD_BLOCK_TEMPLATE = \"%d Block\"\n AutoFollowStatus = AutoFollowStatus {\n }\n GuildControlPopupFrame = GuildControlPopupFrame {\n }\n ARENA_CASUAL = \"Skirmish\"\n SendStationeryBackgroundRight = SendStationeryBackgroundRight {\n }\n MultiBarLeftButton11Name = MultiBarLeftB",
			["stack"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:2: in main chunk",
			["session"] = 901,
			["counter"] = 2,
		}, -- [53]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:2: attempt to index field '?' (a nil value)",
			["time"] = "2020/07/15 16:51:34",
			["locals"] = "(for index) = 1\n(for limit) = 46\n(for step) = 1\ni = 1\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"1\"\n(*temporary) = nil\n(*temporary) = \"attempt to index field '?' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:2: in main chunk",
			["session"] = 903,
			["counter"] = 2,
		}, -- [54]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:3: attempt to index field '?' (a nil value)",
			["time"] = "2020/07/15 16:53:01",
			["locals"] = "(for index) = 1\n(for limit) = 46\n(for step) = 1\ni = 1\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"1\"\n(*temporary) = true\n(*temporary) = \"attempt to index field '?' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:3: in main chunk",
			["session"] = 904,
			["counter"] = 1,
		}, -- [55]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:4: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2020/07/15 16:54:02",
			["locals"] = "(for index) = 1\n(for limit) = 46\n(for step) = 1\ni = 1\nframe = \"TalentFrameTalent1\"\nframeSlot = \"TalentFrameTalent1Slot\"\n(*temporary) = nil\n(*temporary) = \"TalentFrameTalent1\"\n(*temporary) = 8\n(*temporary) = \"attempt to call method 'CreateBeautyBorder' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:4: in main chunk",
			["session"] = 905,
			["counter"] = 1,
		}, -- [56]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:4: attempt to index local 'frame' (a nil value)",
			["time"] = "2020/07/15 16:57:11",
			["locals"] = "(for index) = 1\n(for limit) = 46\n(for step) = 1\ni = 1\nframe = nil\nframeSlot = nil\n(*temporary) = \"TalentFrameTalent1Slot\"\n(*temporary) = nil\n(*temporary) = \"Slot\"\n(*temporary) = \"attempt to index local 'frame' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:4: in main chunk",
			["session"] = 906,
			["counter"] = 1,
		}, -- [57]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:9: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2020/07/15 16:59:28",
			["locals"] = "(for index) = 1\n(for limit) = 46\n(for step) = 1\ni = 1\nframe = TalentFrameTalent1 {\n 0 = <userdata>\n beautyBorder = <table> {\n }\n Count = TalentFrameTalent1Count {\n }\n IconBorder = <unnamed> {\n }\n beautyShadow = <table> {\n }\n searchOverlay = TalentFrameTalent1SearchOverlay {\n }\n icon = TalentFrameTalent1IconTexture {\n }\n IconOverlay = <unnamed> {\n }\n}\nframeSlot = TalentFrameTalent1Slot {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = TalentFrameTalent1Slot {\n 0 = <userdata>\n}\n(*temporary) = 8\n(*temporary) = \"attempt to call method 'CreateBeautyBorder' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:9: in function <Interface\\AddOns\\xVermin\\TalentFrame.lua:1>",
			["session"] = 908,
			["counter"] = 2,
		}, -- [58]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:15: Attempt to register unknown event \"PLAYER_TALENT_UPDATE\"",
			["time"] = "2020/07/15 17:03:45",
			["locals"] = "(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = \"PLAYER_TALENT_UPDATE\"\n",
			["stack"] = "[C]: in function `RegisterEvent'\nInterface\\AddOns\\xVermin\\TalentFrame.lua:15: in main chunk",
			["session"] = 909,
			["counter"] = 1,
		}, -- [59]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:19: Attempt to register unknown event \"INSPECT_TALENT_READY\"",
			["time"] = "2020/07/16 19:41:25",
			["locals"] = "(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = \"INSPECT_TALENT_READY\"\n",
			["stack"] = "[C]: in function `RegisterEvent'\nInterface\\AddOns\\xVermin\\TalentFrame.lua:19: in main chunk",
			["session"] = 912,
			["counter"] = 1,
		}, -- [60]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:19: Attempt to register unknown event \"TALENTFRAME_OPENED\"",
			["time"] = "2020/07/16 19:44:43",
			["locals"] = "(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = \"TALENTFRAME_OPENED\"\n",
			["stack"] = "[C]: in function `RegisterEvent'\nInterface\\AddOns\\xVermin\\TalentFrame.lua:19: in main chunk",
			["session"] = 916,
			["counter"] = 4,
		}, -- [61]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:20: Attempt to register unknown event \"TALENTFRAME_SHOW\"",
			["time"] = "2020/07/16 19:53:47",
			["locals"] = "(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = \"TALENTFRAME_SHOW\"\n",
			["stack"] = "[C]: in function `RegisterEvent'\nInterface\\AddOns\\xVermin\\TalentFrame.lua:20: in main chunk",
			["session"] = 917,
			["counter"] = 1,
		}, -- [62]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:19: Attempt to register unknown event \"TALENT_OPENED\"",
			["time"] = "2020/07/16 19:54:11",
			["locals"] = "(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = \"TALENT_OPENED\"\n",
			["stack"] = "[C]: in function `RegisterEvent'\nInterface\\AddOns\\xVermin\\TalentFrame.lua:19: in main chunk",
			["session"] = 918,
			["counter"] = 1,
		}, -- [63]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:19: Attempt to register unknown event \"TALENT_SHOW\"",
			["time"] = "2020/07/16 19:54:59",
			["locals"] = "(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = \"TALENT_SHOW\"\n",
			["stack"] = "[C]: in function `RegisterEvent'\nInterface\\AddOns\\xVermin\\TalentFrame.lua:19: in main chunk",
			["session"] = 919,
			["counter"] = 1,
		}, -- [64]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:17: cannot use '...' outside a vararg function near '...'",
			["time"] = "2020/07/16 19:57:20",
			["locals"] = "",
			["stack"] = "",
			["session"] = 920,
			["counter"] = 4,
		}, -- [65]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:26: cannot use '...' outside a vararg function near '...'",
			["time"] = "2020/07/16 19:58:35",
			["locals"] = "",
			["stack"] = "",
			["session"] = 921,
			["counter"] = 4,
		}, -- [66]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:47: attempt to index field 'TalentFrame' (a nil value)",
			["time"] = "2020/07/16 20:05:46",
			["locals"] = "SkinTalents = <function> defined @Interface\\AddOns\\xVermin\\TalentFrame.lua:1\nLoDMap = <table> {\n Blizzard_TalentUI = <table> {\n }\n}\nTest = <function> defined @Interface\\AddOns\\xVermin\\TalentFrame.lua:23\nf = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"OnEvent\"\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\TalentFrame.lua:23\n(*temporary) = \"attempt to index field 'TalentFrame' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:47: in main chunk",
			["session"] = 927,
			["counter"] = 1,
		}, -- [67]
		{
			["message"] = "[string \"TalentFrame:HookScript(\"]:1: unexpected symbol near '<eof>'",
			["time"] = "2020/07/16 20:06:52",
			["locals"] = "(*temporary) = \"TalentFrame:HookScript(\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 927,
			["counter"] = 1,
		}, -- [68]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:47: attempt to index global 'TalentFrame' (a nil value)",
			["time"] = "2020/07/16 20:07:41",
			["locals"] = "SkinTalents = <function> defined @Interface\\AddOns\\xVermin\\TalentFrame.lua:1\nLoDMap = <table> {\n Blizzard_TalentUI = <table> {\n }\n}\nTest = <function> defined @Interface\\AddOns\\xVermin\\TalentFrame.lua:23\nf = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"OnEvent\"\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\TalentFrame.lua:23\n(*temporary) = \"attempt to index global 'TalentFrame' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:47: in main chunk",
			["session"] = 928,
			["counter"] = 1,
		}, -- [69]
		{
			["message"] = "(null)",
			["time"] = "2020/07/11 19:09:15",
			["session"] = 928,
			["counter"] = 128,
		}, -- [70]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TalentFrame.lua:54: Usage: hooksecurefunc([table,] \"function\", hookfunc)",
			["time"] = "2020/07/16 20:09:34",
			["locals"] = "(*temporary) = <table> {\n UpdateOnBarHighlightMarksBySpell = <function> defined @Interface\\FrameXML\\ActionButton.lua:70\n ERR_OUT_OF_CHI = \"Not enough chi\"\n DH_HAVOC_CORE_ABILITY_2 = \"Strong melee attack that consumes Fury. If it critical strikes, some Fury is refunded.\"\n MerchantItem9ItemButtonStock = MerchantItem9ItemButtonStock {\n }\n GetTrainerServiceTypeFilter = <function> defined =[C]:-1\n UNIT_NAMES_COMBATLOG_TOOLTIP = \"Color unit names.\"\n SetTrainerServiceTypeFilter = <function> defined =[C]:-1\n LE_GAME_ERR_CHAT_RAID_RESTRICTED_TRIAL = 742\n SPELL_FAILED_CUSTOM_ERROR_71 = \"This partygoer wants to dance with you.\"\n LE_GAME_ERR_PET_SPELL_TARGETS_DEAD = 399\n ERROR_CLUB_TICKET_COUNT_AT_MAX_COMMUNITY = \"Can't create any more invite links for this group.\"\n RecruitAFriendFrame = RecruitAFriendFrame {\n }\n CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdownButtonNormalTexture = CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdownButtonNormalTexture {\n }\n ERR_TRADE_EQUIPPED_BAG = \"You can't trade equipped bags.\"\n PVP_RANK_6_1 = \"Corporal\"\n MultiBarLeftButton7 = MultiBarLeftButton7 {\n }\n InterfaceOptionsNamesPanelUnitNameplatesShowAll = InterfaceOptionsNamesPanelUnitNameplatesShowAll {\n }\n VideoOptionsFrameDefaults = VideoOptionsFrameDefaults {\n }\n MerchantItem2AltCurrencyFrameItem1Text = MerchantItem2AltCurrencyFrameItem1Text {\n }\n OPTION_TOOLTIP_ACTION_BUTTON_USE_KEY_DOWN = \"Action button keybinds will respond on key down, rather than on key up.\"\n BINDING_NAME_NAMEPLATES = \"Show Enemy Name Plates\"\n INSTANCE_UNAVAILABLE_OTHER_TEMPORARILY_DISABLED = \"%s cannot enter. This instance is temporarily disabled.\"\n Atr_StackList9 = Atr_StackList9 {\n }\n MultiBarBottomRightButton8Shine5 = MultiBarBottomRightButton8Shine5 {\n }\n IsReferAFriendLinked = <function> defined =[C]:-1\n MAIL_LETTER_TOOLTIP = \"Click to make a permanent\ncopy of this letter.\"\n UnitFrameManaBar_UnregisterDefaultEvents = <function> defined @Interface\\FrameXML\\UnitFrame.lua:602\n ERR_NOAMMO_S = \"%s\"\n CHAT_CONFIG_OTHER_COMBAT = <table> {\n }\n Questie_ItemButton18Shine14 = Questie_ItemButton18Shine14 {\n }\n FCFDockOverflowButton_OnClick = <function> defined @Interface\\FrameXML\\FloatingChatFrame.lua:2373\n BOOST2_WARRIOR_COLOSSUSSMASH = \"Use |cFFFFFFFFColossus Smash|r.\n\n|cFFFFFFFFColossus Smash|r increases your damage.\"\n BN_UNABLE_TO_RESOLVE_NAME = \"Unable to whisper '%s'. Blizzard services may be unavailable.\"\n LE_GAME_ERR_RECRUIT_A_FRIEND_FAILED = 952\n CompactRaidFrameManagerDisplayFrameHiddenModeToggleTopRight = CompactRaidFrameManagerDisplayFrameHiddenModeToggleTopRight {\n }\n LE_GAME_ERR_ONLY_ONE_QUIVER = 32\n SpellButton6Cooldown = SpellButton6Cooldown {\n }\n LOSS_OF_CONTROL_DISPLAY_FEAR = \"Feared\"\n Graphics_QualityText = Graphics_QualityText {\n }\n questieLineFrame38 = questieLineFrame38 {\n }\n VOICEMACRO_4_Sc_1_FEMALE = \"Help me attack!\"\n StanceButton4FlyoutArrow = StanceButton4FlyoutArrow {\n }\n MultiBarRightButton7Shine9 = MultiBarRightButton7Shine9 {\n }\n BankFrameItem17SearchOverlay = BankFrameItem17SearchOverlay {\n }\n DMG_LCD = \"DMG\"\n VideoOptionsPanel_Cancel = <function> defined @Interface\\SharedXML\\VideoOptionsPanels.lua:315\n HubPanelProfileDefaultFriendlyNameColorMode = HubPanelProfileDefaultFriendlyNameColorMode {\n }\n Is64BitClient = <function> defined =[C]:-1\n SecureCmdItemParse = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1111\n SLASH_STOPATTACK1 = \"/stopattack\"\n SortQuestWatches = <function> defined =[C]:-1\n ContainerFrame4Item16Cooldown = ContainerFrame4Item16Cooldown {\n }\n MINIMAP_TRACKING_TRAINER_CLASS = \"Class Trainer\"\n SLASH_DISMOUNT2 = \"/dismount\"\n DUNGEON_FLOOR_DRAGONBLIGHTCHROMIESCENARIO2 = \"Andorhal\"\n PlayerFrame_UpdateReadyCheck = <function> defined @Interface\\FrameXML\\PlayerFrame.lua:345\n EMOTE69_CMD1 = \"/nosepick\"\n WowTokenRedemptionFrameBg = WowTokenRedemptionFrameBg {\n }\n SHIELD_BLOCK_TEMPLATE = \"%d Block\"\n AutoFollowStatus = AutoFollowStatus {\n }\n GuildControlPopupFrame = GuildControlPopupFrame {\n }\n ARENA_CASUAL = \"Skirmish\"\n SendStationeryBackgroundRight = SendStationeryBackgroundRight {\n }\n MultiBarLeftButton11Name = ",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVermin\\TalentFrame.lua:54: in function <Interface\\AddOns\\xVermin\\TalentFrame.lua:52>\n[C]: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:353: in function `UIParentLoadAddOn'\nInterface\\FrameXML\\UIParent.lua:412: in function `TalentFrame_LoadUI'\nInterface\\FrameXML\\UIParent.lua:497: in function `ToggleTalentFrame'\n[string \"TOGGLETALENTS\"]:1: in function <[string \"TOGGLETALENTS\"]:1>",
			["session"] = 929,
			["counter"] = 1,
		}, -- [71]
		{
			["message"] = "[ADDON_ACTION_FORBIDDEN] AddOn 'Auctionator' tried to call the protected function 'CopyToClipboard()'.",
			["time"] = "2020/07/16 20:13:17",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `CopyToClipboard'\n...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua:548: in function `FrameStackTooltip_HandleFrameCommand'\n...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua:518: in function `command'\nInterface\\SharedXML\\KeyCommand.lua:46: in function `Update'\nInterface\\SharedXML\\KeyCommand.lua:110: in function `KeyCommand_Update'\n...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua:727: in function <...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools.lua:726>",
			["session"] = 931,
			["counter"] = 1,
		}, -- [72]
		{
			["message"] = "[string \"TalentFrameTalent1Rank:CreateBeautyBorder(4...\"]:1: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2020/07/15 13:07:25",
			["locals"] = "(*temporary) = nil\n(*temporary) = TalentFrameTalent1Rank {\n 0 = <userdata>\n}\n(*temporary) = 4\n(*temporary) = \"attempt to call method 'CreateBeautyBorder' (a nil value)\"\n",
			["stack"] = "[string \"TalentFrameTalent1Rank:CreateBeautyBorder(4...\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 931,
			["counter"] = 7,
		}, -- [73]
		{
			["message"] = "[string \"print(GetItemInfo(ItemRackMenu1Icon))\"]:1: Usage: GetItemInfo(itemID|\"name\"|\"itemlink\")",
			["time"] = "2020/07/16 20:21:24",
			["locals"] = "(*temporary) = ItemRackMenu1Icon {\n 0 = <userdata>\n}\n",
			["stack"] = "[C]: in function `GetItemInfo'\n[string \"print(GetItemInfo(ItemRackMenu1Icon))\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 933,
			["counter"] = 1,
		}, -- [74]
		{
			["message"] = "Interface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1177: attempt to call field 'GetID' (a nil value)",
			["time"] = "2020/07/16 20:26:11",
			["locals"] = "id = 6\nmenuInclude = nil\nshowButtonMenu = nil\nitemLink = nil\nitemID = \"2589::::::::14:::::::\"\nitemName = \"Linen Cloth\"\nequipSlot = \"\"\nitemTexture = 132889\ncol = 0\nrow = 1\nxpos = 48\nypos = -8\nmax_cols = 1\nbutton = ItemRackMenu1 {\n 0 = <userdata>\n HotKey = ItemRackMenu1HotKey {\n }\n NewActionTexture = <unnamed> {\n }\n Border = ItemRackMenu1Border {\n }\n Flash = ItemRackMenu1Flash {\n }\n icon = ItemRackMenu1Icon {\n }\n AutoCastable = <unnamed> {\n }\n SpellHighlightAnim = <unnamed> {\n }\n SpellHighlightTexture = <unnamed> {\n }\n NormalTexture = ItemRackMenu1NormalTexture {\n }\n FlyoutBorderShadow = ItemRackMenu1FlyoutBorderShadow {\n }\n FlyoutBorder = ItemRackMenu1FlyoutBorder {\n }\n Count = ItemRackMenu1Count {\n }\n AutoCastShine = ItemRackMenu1Shine {\n }\n FlyoutArrow = ItemRackMenu1FlyoutArrow {\n }\n cooldown = ItemRackMenu1Cooldown {\n }\n Name = ItemRackMenu1Name {\n }\n}\n(for index) = 1\n(for limit) = 2\n(for step) = 1\ni = 1\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = 6\n(*temporary) = \"attempt to call field 'GetID' (a nil value)\"\n_ = \"|cffffffff|Hitem:15302::::::::14:::::::|h[Grizzly Belt]|h|r\"\n",
			["stack"] = "Interface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1177: in function `BuildMenu'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1836: in function `DockMenuToCharacterSheet'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1816: in function `PaperDollItemSlotButton_OnEnter'\n[string \"*:OnEnter\"]:1: in function <[string \"*:OnEnter\"]:1>",
			["session"] = 934,
			["counter"] = 1,
		}, -- [75]
		{
			["message"] = "Interface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1202: Usage: GetItemInfo(itemID|\"name\"|\"itemlink\")",
			["time"] = "2020/07/16 20:27:55",
			["locals"] = "(*temporary) = nil\n",
			["stack"] = "[C]: in function `GetItemInfo'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1202: in function `BuildMenu'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1859: in function `DockMenuToCharacterSheet'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1839: in function `PaperDollItemSlotButton_OnEnter'\n[string \"*:OnEnter\"]:1: in function <[string \"*:OnEnter\"]:1>",
			["session"] = 935,
			["counter"] = 1,
		}, -- [76]
		{
			["message"] = "...ace\\AddOns\\UnitFramesImproved\\UnitFramesImproved-1.7.1.lua:441: bad argument #1 to 'pairs' (table expected, got string)",
			["time"] = "2020/07/16 20:29:14",
			["locals"] = "(*temporary) = \"15302::::::::14:::::::\"\n(*temporary) = \"table expected, got string\"\n = <function> defined =[C]:-1\n",
			["stack"] = "[C]: in function `pairs'\n...ace\\AddOns\\UnitFramesImproved\\UnitFramesImproved-1.7.1.lua:441: in function `print_r'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1201: in function `BuildMenu'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1860: in function `DockMenuToCharacterSheet'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1840: in function `PaperDollItemSlotButton_OnEnter'\n[string \"*:OnEnter\"]:1: in function <[string \"*:OnEnter\"]:1>",
			["session"] = 936,
			["counter"] = 1,
		}, -- [77]
		{
			["message"] = "Interface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1179: Usage: GetItemInfo(itemID|\"name\"|\"itemlink\")",
			["time"] = "2020/07/16 20:53:48",
			["locals"] = "(*temporary) = nil\n",
			["stack"] = "[C]: in function `GetItemInfo'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1179: in function `BuildMenu'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1838: in function `DockMenuToCharacterSheet'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:1818: in function `PaperDollItemSlotButton_OnEnter'\n[string \"*:OnEnter\"]:1: in function <[string \"*:OnEnter\"]:1>",
			["session"] = 950,
			["counter"] = 1,
		}, -- [78]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'xVermin' tried to call the protected function 'UNKNOWN()'.",
			["time"] = "2020/07/17 12:51:25",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: ?\n[C]: in function `SendChatMessage'\nInterface\\AddOns\\xVermin\\FrameIDOutput.lua:15: in function <Interface\\AddOns\\xVermin\\FrameIDOutput.lua:7>",
			["session"] = 961,
			["counter"] = 1,
		}, -- [79]
		{
			["message"] = "...\\AddOns\\cargBags_Nivaya\\cargBags\\base\\itembutton.lua:81: Usage: CreateFrame(\"frameType\" [, \"name\"] [, parent] [, \"template\"] [, id])",
			["time"] = "2020/07/11 17:53:14",
			["locals"] = "(*temporary) = \"Button\"\n(*temporary) = \"NivayaSlot1\"\n(*temporary) = \"ItemButtonTemplate\"\n(*temporary) = \"ContainerFrameItemButtonTemplate\"\n",
			["stack"] = "[C]: in function `CreateFrame'\n...\\AddOns\\cargBags_Nivaya\\cargBags\\base\\itembutton.lua:81: in function `Create'\n...\\AddOns\\cargBags_Nivaya\\cargBags\\base\\itembutton.lua:56: in function `New'\nInterface\\AddOns\\cargBags_Nivaya\\cargBags_Nivaya.lua:762: in function <Interface\\AddOns\\cargBags_Nivaya\\cargBags_Nivaya.lua:757>",
			["session"] = 962,
			["counter"] = 225,
		}, -- [80]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'ItemRack' tried to call the protected function 'AttemptToSaveBindings()'.",
			["time"] = "2020/07/11 19:23:02",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `AttemptToSaveBindings'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:2045: in function `SetSetBindings'\nInterface\\AddOns\\ItemRackOptions\\ItemRackOptions.lua:1041: in function `ReconcileSetBindings'\nInterface\\AddOns\\ItemRackOptions\\ItemRackOptions.lua:411: in function <Interface\\AddOns\\ItemRackOptions\\ItemRackOptions.lua:395>\nInterface\\AddOns\\cargBags_Nivaya\\filters-Filters.lua:132: in function `SaveSet'\nInterface\\AddOns\\ItemRackOptions\\ItemRackOptions.lua:272: in function `ButtonOnClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 962,
			["counter"] = 3,
		}, -- [81]
	},
}
