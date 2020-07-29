
BugGrabberDB = {
	["session"] = 1484,
	["lastSanitation"] = 3,
	["errors"] = {
		{
			["message"] = "Interface\\AddOns\\xVermin\\Frames/CharacterFrame.lua:49: attempt to index global 'frame' (a nil value)",
			["time"] = "2020/07/24 16:00:03",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\xVermin\\Frames/CharacterFrame.lua:49: in main chunk",
			["session"] = 1205,
			["counter"] = 1,
		}, -- [1]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:29: attempt to index upvalue 'frame' (a nil value)",
			["time"] = "2020/07/24 17:08:43",
			["locals"] = "(for index) = 1\n(for limit) = 32\n(for step) = 1\ni = 1\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"1\"\n(*temporary) = \"Count\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index upvalue 'frame' (a nil value)\"\nB_spellId = nil\nB_unitCaster = nil\nD_spellId = nil\nD_unitCaster = nil\nframe = nil\nframeBorder = nil\nframeCount = nil\ncolor = nil\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:29: in function <Interface\\AddOns\\xVermin\\SkinBuffs.lua:15>\n[C]: ?\n[C]: in function `TargetFrame_UpdateAuras'\nInterface\\FrameXML\\TargetFrame.lua:131: in function `TargetFrame_Update'\nInterface\\FrameXML\\TargetFrame.lua:150: in function <Interface\\FrameXML\\TargetFrame.lua:142>\n[C]: in function `CameraOrSelectOrMoveStop'\n[string \"CAMERAORSELECTORMOVE\"]:4: in function <[string \"CAMERAORSELECTORMOVE\"]:1>",
			["session"] = 1216,
			["counter"] = 3,
		}, -- [2]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:163: attempt to call method 'SetScript' (a nil value)",
			["time"] = "2020/07/24 19:23:08",
			["locals"] = "ReplacedDebuffTypeColor = <table> {\n  = <table> {\n }\n Disease = <table> {\n }\n Poison = <table> {\n }\n Curse = <table> {\n }\n Magic = <table> {\n }\n none = <table> {\n }\n}\nframe = nil\nframeBorder = nil\nframeCount = nil\ncolor = nil\nB_spellId = nil\nD_spellId = nil\nB_unitCaster = nil\nD_unitCaster = nil\nSkinTarget = <function> defined @Interface\\AddOns\\xVermin\\SkinBuffs.lua:15\nSkinPet = <function> defined @Interface\\AddOns\\xVermin\\SkinBuffs.lua:84\npf = <unnamed> {\n 0 = <userdata>\n}\ntest = <function> defined @Interface\\AddOns\\xVermin\\SkinBuffs.lua:153\n(*temporary) = nil\n(*temporary) = TargetFrameHealthBarText {\n 0 = <userdata>\n}\n(*temporary) = \"OnLoad\"\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\SkinBuffs.lua:153\n(*temporary) = \"attempt to call method 'SetScript' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:163: in main chunk",
			["session"] = 1236,
			["counter"] = 1,
		}, -- [3]
		{
			["message"] = "[string \"print(UnitIsPet(\"target\"))\"]:1: attempt to call global 'UnitIsPet' (a nil value)",
			["time"] = "2020/07/24 19:54:30",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = \"target\"\n(*temporary) = \"attempt to call global 'UnitIsPet' (a nil value)\"\n",
			["stack"] = "[string \"print(UnitIsPet(\"target\"))\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1246,
			["counter"] = 1,
		}, -- [4]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:96: attempt to index upvalue 'frame' (a nil value)",
			["time"] = "2020/07/24 22:58:02",
			["locals"] = "(for index) = 1\n(for limit) = 32\n(for step) = 1\ni = 1\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"1\"\n(*temporary) = \"Count\"\n(*temporary) = 8\n(*temporary) = 1\n(*temporary) = 8\n(*temporary) = \"attempt to index upvalue 'frame' (a nil value)\"\nhasPet = false\nisHunterPet = false\npetName = nil\ntargetName = nil\nB_spellId = 135932\nB_unitCaster = \"target\"\nD_spellId = nil\nD_unitCaster = nil\nframe = nil\nframeBorder = nil\nframeCount = nil\ncolor = nil\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:96: in function <Interface\\AddOns\\xVermin\\SkinBuffs.lua:26>\n[C]: ?\n[C]: in function `TargetFrame_UpdateAuras'\n[string \"*:OnShow\"]:1: in function <[string \"*:OnShow\"]:1>\n[C]: in function `Show'\nInterface\\FrameXML\\TargetFrame.lua:910: in function <Interface\\FrameXML\\TargetFrame.lua:905>\n[C]: ?\n[C]: in function `TargetofTarget_Update'\nInterface\\FrameXML\\TargetFrame.lua:109: in function `TargetFrame_Update'\nInterface\\FrameXML\\TargetFrame.lua:150: in function <Interface\\FrameXML\\TargetFrame.lua:142>\n[C]: in function `CameraOrSelectOrMoveStop'\n[string \"CAMERAORSELECTORMOVE\"]:4: in function <[string \"CAMERAORSELECTORMOVE\"]:1>",
			["session"] = 1275,
			["counter"] = 3,
		}, -- [5]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:101: attempt to index field 'button' (a nil value)",
			["time"] = "2020/07/25 15:03:02",
			["locals"] = "widget = <unnamed> {\n 0 = <userdata>\n}\nbutton = \"BAG_UPDATE\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index field 'button' (a nil value)\"\nmod = <table> {\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:367\n Enable = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:294\n UnregisterAllEvents = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:174\n EnableModule = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:332\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:210\n IterateEmbeds = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:442\n defaultModuleLibraries = <table> {\n }\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:409\n GetOptions = <function> defined @Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:184\n name = \"AdiBags_NewItem\"\n Filter = <function> defined @Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:173\n IsEnabled = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n orderedModules = <table> {\n }\n DisableModule = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:350\n OnBagFrameCreated = <function> defined @Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:111\n baseName = \"AdiBags\"\n priority = 80\n UpdateModuleButton = <function> defined @Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:143\n RegisterMessage = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:90\n UnregisterMessage = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:153\n IsNew = <function> defined @Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:151\n filterName = \"NewItem\"\n uiName = \"Track new items\"\n BAG_NEW_ITEMS_UPDATED = <function> defined @Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:166\n uiDesc = \"Track new items in each bag, displaying a glowing aura over them and putting them in a special section. \"New\" status can be reset by clicking on the small \"N\" button at top left of bags.\"\n IsModule = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:217\n db = <table> {\n }\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:387\n OnDisable = <function> defined @Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:84\n OnEnable = <function> defined @Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:74\n SetEnabledState = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:424\n OnInitialize = <function> defined @Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:51\n enabledState = false\n UpdateButton = <function> defined @Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:133\n RegisterEvent = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:90\n UnregisterAllMessages = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:174\n ShowLegacyGlow = <function> defined @Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:294\n ShowBlizzardGlow = <function> defined @Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:231\n NewModule = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:235\n IterateModules = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:437\n SendMessage = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:59\n defaultModuleState = true\n GetName = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:279\n moduleName = \"NewItem\"\n UnregisterEvent = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:153\n Disable = <function> ",
			["stack"] = "Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:101: in function <Interface\\AddOns\\AdiBags\\modules\\NewItemTracking.lua:94>",
			["session"] = 1284,
			["counter"] = 6,
		}, -- [6]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'kRestack' tried to call the protected function 'resume()'.",
			["time"] = "2020/07/25 15:37:10",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `resume'\nInterface\\AddOns\\kRestack\\kRestack-40000.1.lua:381: in function `kRestack'\nInterface\\AddOns\\kRestack\\kRestack-40000.1.lua:149: in function <Interface\\AddOns\\kRestack\\kRestack.lua:112>",
			["session"] = 1286,
			["counter"] = 1,
		}, -- [7]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:46: attempt to index upvalue 'frame' (a nil value)",
			["time"] = "2020/07/25 16:27:41",
			["locals"] = "(for index) = 1\n(for limit) = 32\n(for step) = 1\ni = 1\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"Count\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index upvalue 'frame' (a nil value)\"\nhasPet = true\nisHunterPet = true\npetName = \"Cat\"\ntargetName = \"Bristleback Hunter\"\nB_spellId = nil\nB_unitCaster = nil\nD_spellId = nil\nD_unitCaster = nil\nframe = nil\nframeBorder = nil\nframeCount = nil\ncolor = <table> {\n b = 0\n g = 0\n r = 0.800000\n}\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:46: in function <Interface\\AddOns\\xVermin\\SkinBuffs.lua:26>\n[C]: ?\n[C]: in function `TargetFrame_UpdateAuras'\nInterface\\FrameXML\\TargetFrame.lua:131: in function `TargetFrame_Update'\nInterface\\FrameXML\\TargetFrame.lua:150: in function <Interface\\FrameXML\\TargetFrame.lua:142>\n[C]: in function `CameraOrSelectOrMoveStop'\n[string \"CAMERAORSELECTORMOVE\"]:4: in function <[string \"CAMERAORSELECTORMOVE\"]:1>",
			["session"] = 1297,
			["counter"] = 2,
		}, -- [8]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:45: attempt to index upvalue 'frame' (a nil value)",
			["time"] = "2020/07/25 16:31:47",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:45: in function <Interface\\AddOns\\xVermin\\SkinBuffs.lua:26>\n[C]: ?\n[C]: in function `TargetFrame_UpdateAuras'\nInterface\\FrameXML\\TargetFrame.lua:197: in function <Interface\\FrameXML\\TargetFrame.lua:142>",
			["session"] = 1299,
			["counter"] = 4,
		}, -- [9]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:47: attempt to index upvalue 'frameBorder' (a nil value)",
			["time"] = "2020/07/25 16:33:35",
			["locals"] = "(for index) = 1\n(for limit) = 32\n(for step) = 1\ni = 1\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = true\n(*temporary) = \"Count\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index upvalue 'frameBorder' (a nil value)\"\nhasPet = true\nisHunterPet = true\npetName = \"Cat\"\ntargetName = \"Mxzq\"\nB_spellId = 136076\nB_unitCaster = \"player\"\nD_spellId = nil\nD_unitCaster = nil\nframe = TargetFrameBuff1 {\n 0 = <userdata>\n unit = \"target\"\n}\nframeBorder = nil\nframeCount = TargetFrameBuff1Count {\n 0 = <userdata>\n}\ncolor = <table> {\n b = 0\n g = 0\n r = 0.800000\n}\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:47: in function <Interface\\AddOns\\xVermin\\SkinBuffs.lua:26>\n[C]: ?\n[C]: in function `TargetFrame_UpdateAuras'\nInterface\\FrameXML\\TargetFrame.lua:131: in function `TargetFrame_Update'\nInterface\\FrameXML\\TargetFrame.lua:150: in function <Interface\\FrameXML\\TargetFrame.lua:142>\n[C]: ?\n[C]: in function `TargetUnit'\nInterface\\FrameXML\\SecureTemplates.lua:480: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\nInterface\\FrameXML\\SecureTemplates.lua:656: in function <Interface\\FrameXML\\SecureTemplates.lua:648>",
			["session"] = 1300,
			["counter"] = 67,
		}, -- [10]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:61: attempt to index upvalue 'frame' (a nil value)",
			["time"] = "2020/07/25 16:34:57",
			["locals"] = "(for index) = 1\n(for limit) = 32\n(for step) = 1\ni = 1\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = false\n(*temporary) = \"Count\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index upvalue 'frame' (a nil value)\"\nhasPet = true\nisHunterPet = true\npetName = \"Cat\"\ntargetName = \"Bristleback Geomancer\"\nB_spellId = nil\nB_unitCaster = nil\nD_spellId = nil\nD_unitCaster = nil\nframe = nil\nframeBorder = nil\nframeCount = nil\ncolor = <table> {\n b = 0\n g = 0\n r = 0.800000\n}\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:61: in function <Interface\\AddOns\\xVermin\\SkinBuffs.lua:26>\n[C]: ?\n[C]: in function `TargetFrame_UpdateAuras'\nInterface\\FrameXML\\TargetFrame.lua:131: in function `TargetFrame_Update'\nInterface\\FrameXML\\TargetFrame.lua:150: in function <Interface\\FrameXML\\TargetFrame.lua:142>\n[C]: in function `CameraOrSelectOrMoveStop'\n[string \"CAMERAORSELECTORMOVE\"]:4: in function <[string \"CAMERAORSELECTORMOVE\"]:1>",
			["session"] = 1301,
			["counter"] = 48,
		}, -- [11]
		{
			["message"] = "[string \"CastSpellByName(“Aspect of the Hawk”)\"]:1: unexpected symbol near '�'",
			["time"] = "2020/07/25 22:29:30",
			["locals"] = "(*temporary) = \"CastSpellByName(“Aspect of the Hawk”)\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1303,
			["counter"] = 2,
		}, -- [12]
		{
			["message"] = "[string \"ChangeActionBarPage(7);\"]:1: ChangeActionBarPage() needs a page in the range 1 to 6",
			["time"] = "2020/07/25 22:39:15",
			["locals"] = "(*temporary) = 7\n",
			["stack"] = "[C]: in function `ChangeActionBarPage'\n[string \"ChangeActionBarPage(7);\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1304,
			["counter"] = 1,
		}, -- [13]
		{
			["message"] = "[string \"MiniMapTrackingIcon:CreateBeautyBorder(6)\"]:1: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2020/07/26 10:41:20",
			["locals"] = "(*temporary) = nil\n(*temporary) = MiniMapTrackingIcon {\n 0 = <userdata>\n}\n(*temporary) = 6\n(*temporary) = \"attempt to call method 'CreateBeautyBorder' (a nil value)\"\n",
			["stack"] = "[string \"MiniMapTrackingIcon:CreateBeautyBorder(6)\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1312,
			["counter"] = 1,
		}, -- [14]
		{
			["message"] = "[string \"MiniMapBackDrop:Hide()\"]:1: attempt to index global 'MiniMapBackDrop' (a nil value)",
			["time"] = "2020/07/26 10:45:07",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'MiniMapBackDrop' (a nil value)\"\n",
			["stack"] = "[string \"MiniMapBackDrop:Hide()\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1312,
			["counter"] = 1,
		}, -- [15]
		{
			["message"] = "[string \"local name, texture, active, category = Get...\"]:1: attempt to call global 'GetTrackingInfo' (a nil value)",
			["time"] = "2020/07/26 10:54:30",
			["locals"] = "(*temporary) = nil\n(*temporary) = 1\n(*temporary) = \"attempt to call global 'GetTrackingInfo' (a nil value)\"\n",
			["stack"] = "[string \"local name, texture, active, category = Get...\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1318,
			["counter"] = 1,
		}, -- [16]
		{
			["message"] = "[string \"print(GetNumTrackingTypes())\"]:1: attempt to call global 'GetNumTrackingTypes' (a nil value)",
			["time"] = "2020/07/26 10:55:10",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = \"attempt to call global 'GetNumTrackingTypes' (a nil value)\"\n",
			["stack"] = "[string \"print(GetNumTrackingTypes())\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1318,
			["counter"] = 1,
		}, -- [17]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TrackingIcon.lua:60: attempt to call global 'GetNumTrackingTypes' (a nil value)",
			["time"] = "2020/07/26 10:55:59",
			["locals"] = "TrackingIconFrame = CustomTrackingIconFrame {\n 0 = <userdata>\n Icon = <unnamed> {\n }\n beautyBorder = <table> {\n }\n beautyShadow = <table> {\n }\n}\nTrackingIconMinerals = <function> defined @Interface\\AddOns\\xVermin\\TrackingIcon.lua:23\nTrackingIconHerbs = <function> defined @Interface\\AddOns\\xVermin\\TrackingIcon.lua:32\nInitializeTracking = <function> defined @Interface\\AddOns\\xVermin\\TrackingIcon.lua:41\n(*temporary) = nil\n(*temporary) = \"attempt to call global 'GetNumTrackingTypes' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\TrackingIcon.lua:60: in main chunk",
			["session"] = 1319,
			["counter"] = 1,
		}, -- [18]
		{
			["message"] = "[string \"SetTracking(1,true)\"]:1: attempt to call global 'SetTracking' (a nil value)",
			["time"] = "2020/07/26 10:58:34",
			["locals"] = "(*temporary) = nil\n(*temporary) = 1\n(*temporary) = true\n(*temporary) = \"attempt to call global 'SetTracking' (a nil value)\"\n",
			["stack"] = "[string \"SetTracking(1,true)\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1319,
			["counter"] = 1,
		}, -- [19]
		{
			["message"] = "[string \"SetTracking(nil)\"]:1: attempt to call global 'SetTracking' (a nil value)",
			["time"] = "2020/07/26 10:58:43",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to call global 'SetTracking' (a nil value)\"\n",
			["stack"] = "[string \"SetTracking(nil)\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1319,
			["counter"] = 1,
		}, -- [20]
		{
			["message"] = "Interface\\AddOns\\xVermin\\TrackingIcon.lua:115: attempt to index global 'self' (a nil value)",
			["time"] = "2020/07/26 11:47:48",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'self' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\TrackingIcon.lua:115: in function <Interface\\AddOns\\xVermin\\TrackingIcon.lua:114>\n[C]: in function `Show'\n[string \"*:OnEvent\"]:5: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 1334,
			["counter"] = 1,
		}, -- [21]
		{
			["message"] = "Couldn't open Interface\\AddOns\\AtlasLootClassic\\AtlasLootClassic.toc",
			["time"] = "2020/07/26 13:26:58",
			["session"] = 1336,
			["counter"] = 2,
		}, -- [22]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: AdiBagsItemButton114Count:SetPoint(): Unknown region point",
			["time"] = "2020/07/26 13:32:39",
			["locals"] = "(*temporary) = AdiBagsItemButton114Count {\n 0 = <userdata>\n}\n(*temporary) = \"RIGHTBOTTOM\"\n(*temporary) = -2\n(*temporary) = -2\n",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:610: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:561: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:554>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1340,
			["counter"] = 1,
		}, -- [23]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: AdiBagsItemButton18Count:SetPoint(): Unknown region point",
			["time"] = "2020/07/26 13:32:39",
			["locals"] = "(*temporary) = AdiBagsItemButton18Count {\n 0 = <userdata>\n}\n(*temporary) = \"RIGHTBOTTOM\"\n(*temporary) = -2\n(*temporary) = -2\n",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:610: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:561: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:554>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1340,
			["counter"] = 1,
		}, -- [24]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: AdiBagsItemButton69Count:SetPoint(): Unknown region point",
			["time"] = "2020/07/26 13:32:39",
			["locals"] = "(*temporary) = AdiBagsItemButton69Count {\n 0 = <userdata>\n}\n(*temporary) = \"RIGHTBOTTOM\"\n(*temporary) = -2\n(*temporary) = -2\n",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:610: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:561: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:554>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1340,
			["counter"] = 1,
		}, -- [25]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: AdiBagsItemButton55Count:SetPoint(): Unknown region point",
			["time"] = "2020/07/26 13:32:39",
			["locals"] = "(*temporary) = AdiBagsItemButton55Count {\n 0 = <userdata>\n}\n(*temporary) = \"RIGHTBOTTOM\"\n(*temporary) = -2\n(*temporary) = -2\n",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:610: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:561: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:554>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1340,
			["counter"] = 1,
		}, -- [26]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: AdiBagsItemButton101Count:SetPoint(): Unknown region point",
			["time"] = "2020/07/26 13:32:39",
			["locals"] = "(*temporary) = AdiBagsItemButton101Count {\n 0 = <userdata>\n}\n(*temporary) = \"RIGHTBOTTOM\"\n(*temporary) = -2\n(*temporary) = -2\n",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:610: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:561: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:554>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1340,
			["counter"] = 1,
		}, -- [27]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: AdiBagsItemButton6Count:SetPoint(): Unknown region point",
			["time"] = "2020/07/26 13:32:39",
			["locals"] = "(*temporary) = AdiBagsItemButton6Count {\n 0 = <userdata>\n}\n(*temporary) = \"RIGHTBOTTOM\"\n(*temporary) = -2\n(*temporary) = -2\n",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:610: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:561: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:554>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1340,
			["counter"] = 1,
		}, -- [28]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: AdiBagsItemButton131Count:SetPoint(): Unknown region point",
			["time"] = "2020/07/26 13:32:39",
			["locals"] = "(*temporary) = AdiBagsItemButton131Count {\n 0 = <userdata>\n}\n(*temporary) = \"RIGHTBOTTOM\"\n(*temporary) = -2\n(*temporary) = -2\n",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:610: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:561: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:554>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1340,
			["counter"] = 1,
		}, -- [29]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: AdiBagsItemButton88Count:SetPoint(): Unknown region point",
			["time"] = "2020/07/26 13:32:39",
			["locals"] = "(*temporary) = AdiBagsItemButton88Count {\n 0 = <userdata>\n}\n(*temporary) = \"RIGHTBOTTOM\"\n(*temporary) = -2\n(*temporary) = -2\n",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:610: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:561: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:554>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1340,
			["counter"] = 1,
		}, -- [30]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: AdiBagsItemButton150Count:SetPoint(): Unknown region point",
			["time"] = "2020/07/26 13:32:39",
			["locals"] = "(*temporary) = AdiBagsItemButton150Count {\n 0 = <userdata>\n}\n(*temporary) = \"RIGHTBOTTOM\"\n(*temporary) = -2\n(*temporary) = -2\n",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:610: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:561: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:554>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1340,
			["counter"] = 1,
		}, -- [31]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: AdiBagsItemButton107Count:SetPoint(): Unknown region point",
			["time"] = "2020/07/26 13:32:39",
			["locals"] = "(*temporary) = AdiBagsItemButton107Count {\n 0 = <userdata>\n}\n(*temporary) = \"RIGHTBOTTOM\"\n(*temporary) = -2\n(*temporary) = -2\n",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:333: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:610: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:561: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:554>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1340,
			["counter"] = 1,
		}, -- [32]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:331: attempt to perform arithmetic on global 'ount' (a nil value)",
			["time"] = "2020/07/26 13:36:16",
			["locals"] = "self = AdiBagsItemButton125 {\n NormalTexture = AdiBagsItemButton125NormalTexture {\n }\n bag = 1\n BattlepayItemTexture = <unnamed> {\n }\n beautyShadow = <table> {\n }\n IconOverlay = <unnamed> {\n }\n BagStaticTop = <unnamed> {\n }\n IconBorder = <unnamed> {\n }\n flashAnim = <unnamed> {\n }\n icon = AdiBagsItemButton125IconTexture {\n }\n container = AdiBagsContainer1 {\n }\n acquired = true\n UpdateTooltip = <function> defined @Interface\\FrameXML\\ContainerFrame.lua:1298\n ExtendedOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n UpgradeIcon = <unnamed> {\n }\n NewItemTexture = <unnamed> {\n }\n Cooldown = AdiBagsItemButton125Cooldown {\n }\n bagFamily = 1\n BagStaticBottom = <unnamed> {\n }\n flash = <unnamed> {\n }\n ExtendedSlot = <unnamed> {\n }\n IconQuestTexture = AdiBagsItemButton125IconQuestTexture {\n }\n hasItem = true\n IconTexture = AdiBagsItemButton125IconTexture {\n }\n JunkIcon = <unnamed> {\n }\n Stock = AdiBagsItemButton125Stock {\n }\n slot = 3\n count = 2000\n stack = AdiBagsStackButton1 {\n }\n GetCount = <function> defined @Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:466\n texture = 132382\n timeSinceUpgradeCheck = 0\n itemLink = \"|cffffffff|Hitem:2515::::::::22:::::::|h[Sharp Arrow]|h|r\"\n Count = AdiBagsItemButton125Count {\n }\n itemId = 2515\n 0 = <userdata>\n searchOverlay = AdiBagsItemButton125SearchOverlay {\n }\n newitemglowAnim = <unnamed> {\n }\n ExtendedOverlay2 = <unnamed> {\n }\n}\ncount = 2000\nshortened = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"Fonts\\ARIALN.ttf\"\n(*temporary) = 14\n(*temporary) = \"THINOUTLINE\"\n(*temporary) = \"attempt to perform arithmetic on global 'ount' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:331: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:613: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:564: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:557>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1344,
			["counter"] = 1,
		}, -- [33]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:331: attempt to call global 'format_num' (a nil value)",
			["time"] = "2020/07/26 13:36:35",
			["locals"] = "self = AdiBagsItemButton40 {\n NormalTexture = AdiBagsItemButton40NormalTexture {\n }\n bag = 1\n BattlepayItemTexture = <unnamed> {\n }\n beautyShadow = <table> {\n }\n IconOverlay = <unnamed> {\n }\n BagStaticTop = <unnamed> {\n }\n IconBorder = <unnamed> {\n }\n flashAnim = <unnamed> {\n }\n icon = AdiBagsItemButton40IconTexture {\n }\n container = AdiBagsContainer1 {\n }\n acquired = true\n UpdateTooltip = <function> defined @Interface\\FrameXML\\ContainerFrame.lua:1298\n ExtendedOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n UpgradeIcon = <unnamed> {\n }\n NewItemTexture = <unnamed> {\n }\n Cooldown = AdiBagsItemButton40Cooldown {\n }\n bagFamily = 1\n BagStaticBottom = <unnamed> {\n }\n flash = <unnamed> {\n }\n ExtendedSlot = <unnamed> {\n }\n IconQuestTexture = AdiBagsItemButton40IconQuestTexture {\n }\n hasItem = true\n IconTexture = AdiBagsItemButton40IconTexture {\n }\n JunkIcon = <unnamed> {\n }\n Stock = AdiBagsItemButton40Stock {\n }\n slot = 3\n count = 2000\n stack = AdiBagsStackButton1 {\n }\n GetCount = <function> defined @Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:466\n texture = 132382\n timeSinceUpgradeCheck = 0\n itemLink = \"|cffffffff|Hitem:2515::::::::22:::::::|h[Sharp Arrow]|h|r\"\n Count = AdiBagsItemButton40Count {\n }\n itemId = 2515\n 0 = <userdata>\n searchOverlay = AdiBagsItemButton40SearchOverlay {\n }\n newitemglowAnim = <unnamed> {\n }\n ExtendedOverlay2 = <unnamed> {\n }\n}\ncount = 2000\nshortened = nil\n(*temporary) = nil\n(*temporary) = 1\n(*temporary) = 2\n(*temporary) = \"attempt to call global 'format_num' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:331: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:613: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:564: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:557>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1345,
			["counter"] = 1,
		}, -- [34]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:332: attempt to perform arithmetic on local 'placeValue' (a string value)",
			["time"] = "2020/07/26 13:42:17",
			["locals"] = "self = AdiBagsItemButton44 {\n NormalTexture = AdiBagsItemButton44NormalTexture {\n }\n bag = 1\n BattlepayItemTexture = <unnamed> {\n }\n beautyShadow = <table> {\n }\n IconOverlay = <unnamed> {\n }\n BagStaticTop = <unnamed> {\n }\n IconBorder = <unnamed> {\n }\n flashAnim = <unnamed> {\n }\n icon = AdiBagsItemButton44IconTexture {\n }\n container = AdiBagsContainer1 {\n }\n acquired = true\n UpdateTooltip = <function> defined @Interface\\FrameXML\\ContainerFrame.lua:1298\n ExtendedOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n UpgradeIcon = <unnamed> {\n }\n NewItemTexture = <unnamed> {\n }\n Cooldown = AdiBagsItemButton44Cooldown {\n }\n bagFamily = 1\n BagStaticBottom = <unnamed> {\n }\n flash = <unnamed> {\n }\n ExtendedSlot = <unnamed> {\n }\n IconQuestTexture = AdiBagsItemButton44IconQuestTexture {\n }\n hasItem = true\n IconTexture = AdiBagsItemButton44IconTexture {\n }\n JunkIcon = <unnamed> {\n }\n Stock = AdiBagsItemButton44Stock {\n }\n slot = 7\n count = 1999\n stack = AdiBagsStackButton1 {\n }\n GetCount = <function> defined @Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:467\n texture = 132382\n timeSinceUpgradeCheck = 0\n itemLink = \"|cffffffff|Hitem:2515::::::::22:::::::|h[Sharp Arrow]|h|r\"\n Count = AdiBagsItemButton44Count {\n }\n itemId = 2515\n 0 = <userdata>\n searchOverlay = AdiBagsItemButton44SearchOverlay {\n }\n newitemglowAnim = <unnamed> {\n }\n ExtendedOverlay2 = <unnamed> {\n }\n}\ncount = 1999\nplaceValue = \"%.1999f\"\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = 1.999000\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = \"THINOUTLINE\"\n(*temporary) = \"attempt to perform arithmetic on local 'placeValue' (a string value)\"\nformat = <function> defined =[C]:-1\n",
			["stack"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:332: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:614: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:565: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:558>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1349,
			["counter"] = 1,
		}, -- [35]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:336: attempt to call global 'sprintf' (a nil value)",
			["time"] = "2020/07/26 13:50:04",
			["locals"] = "self = AdiBagsItemButton27 {\n NormalTexture = AdiBagsItemButton27NormalTexture {\n }\n bag = 1\n BattlepayItemTexture = <unnamed> {\n }\n beautyShadow = <table> {\n }\n IconOverlay = <unnamed> {\n }\n BagStaticTop = <unnamed> {\n }\n IconBorder = <unnamed> {\n }\n flashAnim = <unnamed> {\n }\n icon = AdiBagsItemButton27IconTexture {\n }\n container = AdiBagsContainer1 {\n }\n acquired = true\n UpdateTooltip = <function> defined @Interface\\FrameXML\\ContainerFrame.lua:1298\n ExtendedOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n UpgradeIcon = <unnamed> {\n }\n NewItemTexture = <unnamed> {\n }\n Cooldown = AdiBagsItemButton27Cooldown {\n }\n bagFamily = 1\n BagStaticBottom = <unnamed> {\n }\n flash = <unnamed> {\n }\n ExtendedSlot = <unnamed> {\n }\n IconQuestTexture = AdiBagsItemButton27IconQuestTexture {\n }\n hasItem = true\n IconTexture = AdiBagsItemButton27IconTexture {\n }\n JunkIcon = <unnamed> {\n }\n Stock = AdiBagsItemButton27Stock {\n }\n slot = 7\n count = 1999\n stack = AdiBagsStackButton1 {\n }\n GetCount = <function> defined @Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:472\n texture = 132382\n timeSinceUpgradeCheck = 0\n itemLink = \"|cffffffff|Hitem:2515::::::::22:::::::|h[Sharp Arrow]|h|r\"\n Count = AdiBagsItemButton27Count {\n }\n itemId = 2515\n 0 = <userdata>\n searchOverlay = AdiBagsItemButton27SearchOverlay {\n }\n newitemglowAnim = <unnamed> {\n }\n ExtendedOverlay2 = <unnamed> {\n }\n}\ncount = 1999\nplaceValue = \"%.1f\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"%.2f\"\n(*temporary) = 1999\n(*temporary) = \"attempt to call global 'sprintf' (a nil value)\"\nformat = <function> defined =[C]:-1\n",
			["stack"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:336: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:619: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:570: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:563>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1353,
			["counter"] = 1,
		}, -- [36]
		{
			["message"] = "Interface\\AddOns\\NovaWorldBuffs\\NWBData.lua:900: attempt to index local 'vv' (a number value)",
			["time"] = "2020/07/26 13:50:06",
			["stack"] = "Interface\\AddOns\\NovaWorldBuffs\\NWBData.lua:900: in function `receivedData'\nInterface\\AddOns\\NovaWorldBuffs\\NWBData.lua:165: in function `?'\n...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:119: in function <...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:119>\n[C]: ?\n...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:29: in function <...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:25>\n...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:64: in function `Fire'\n...face\\AddOns\\Details\\Libs\\AceComm-3.0\\AceComm-3.0-12.lua:218: in function `OnReceiveMultipartLast'\n...face\\AddOns\\Details\\Libs\\AceComm-3.0\\AceComm-3.0-12.lua:256: in function <...face\\AddOns\\Details\\Libs\\AceComm-3.0\\AceComm-3.0.lua:246>",
			["session"] = 1353,
			["counter"] = 1,
		}, -- [37]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:334: attempt to perform arithmetic on global 'num' (a nil value)",
			["time"] = "2020/07/26 14:09:12",
			["locals"] = "self = AdiBagsItemButton113 {\n NormalTexture = AdiBagsItemButton113NormalTexture {\n }\n bag = 1\n BattlepayItemTexture = <unnamed> {\n }\n beautyShadow = <table> {\n }\n IconOverlay = <unnamed> {\n }\n BagStaticTop = <unnamed> {\n }\n IconBorder = <unnamed> {\n }\n flashAnim = <unnamed> {\n }\n icon = AdiBagsItemButton113IconTexture {\n }\n container = AdiBagsContainer1 {\n }\n acquired = true\n UpdateTooltip = <function> defined @Interface\\FrameXML\\ContainerFrame.lua:1298\n ExtendedOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n UpgradeIcon = <unnamed> {\n }\n NewItemTexture = <unnamed> {\n }\n Cooldown = AdiBagsItemButton113Cooldown {\n }\n bagFamily = 1\n BagStaticBottom = <unnamed> {\n }\n flash = <unnamed> {\n }\n ExtendedSlot = <unnamed> {\n }\n IconQuestTexture = AdiBagsItemButton113IconQuestTexture {\n }\n hasItem = true\n IconTexture = AdiBagsItemButton113IconTexture {\n }\n JunkIcon = <unnamed> {\n }\n Stock = AdiBagsItemButton113Stock {\n }\n slot = 7\n count = 1999\n stack = AdiBagsStackButton1 {\n }\n GetCount = <function> defined @Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:469\n texture = 132382\n timeSinceUpgradeCheck = 0\n itemLink = \"|cffffffff|Hitem:2515::::::::22:::::::|h[Sharp Arrow]|h|r\"\n Count = AdiBagsItemButton113Count {\n }\n itemId = 2515\n 0 = <userdata>\n searchOverlay = AdiBagsItemButton113SearchOverlay {\n }\n newitemglowAnim = <unnamed> {\n }\n ExtendedOverlay2 = <unnamed> {\n }\n}\ncount = 1999\nmult = 10\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = nil\n(*temporary) = \"THINOUTLINE\"\n(*temporary) = \"attempt to perform arithmetic on global 'num' (a nil value)\"\nformat = <function> defined =[C]:-1\n",
			["stack"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:334: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:616: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:567: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:560>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1357,
			["counter"] = 1,
		}, -- [38]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:330: attempt to perform arithmetic on global 'mult' (a nil value)",
			["time"] = "2020/07/26 14:12:59",
			["locals"] = "self = AdiBagsItemButton112 {\n NormalTexture = AdiBagsItemButton112NormalTexture {\n }\n bag = 1\n BattlepayItemTexture = <unnamed> {\n }\n beautyShadow = <table> {\n }\n IconOverlay = <unnamed> {\n }\n BagStaticTop = <unnamed> {\n }\n IconBorder = <unnamed> {\n }\n flashAnim = <unnamed> {\n }\n icon = AdiBagsItemButton112IconTexture {\n }\n container = AdiBagsContainer1 {\n }\n acquired = true\n UpdateTooltip = <function> defined @Interface\\FrameXML\\ContainerFrame.lua:1298\n ExtendedOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n UpgradeIcon = <unnamed> {\n }\n NewItemTexture = <unnamed> {\n }\n Cooldown = AdiBagsItemButton112Cooldown {\n }\n bagFamily = 1\n BagStaticBottom = <unnamed> {\n }\n flash = <unnamed> {\n }\n ExtendedSlot = <unnamed> {\n }\n IconQuestTexture = AdiBagsItemButton112IconQuestTexture {\n }\n hasItem = true\n IconTexture = AdiBagsItemButton112IconTexture {\n }\n JunkIcon = <unnamed> {\n }\n Stock = AdiBagsItemButton112Stock {\n }\n slot = 7\n count = 1999\n stack = AdiBagsStackButton1 {\n }\n GetCount = <function> defined @Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:464\n texture = 132382\n timeSinceUpgradeCheck = 0\n itemLink = \"|cffffffff|Hitem:2515::::::::22:::::::|h[Sharp Arrow]|h|r\"\n Count = AdiBagsItemButton112Count {\n }\n itemId = 2515\n 0 = <userdata>\n searchOverlay = AdiBagsItemButton112SearchOverlay {\n }\n newitemglowAnim = <unnamed> {\n }\n ExtendedOverlay2 = <unnamed> {\n }\n}\ncount = 1999\n(*temporary) = 19\n(*temporary) = nil\n(*temporary) = 19\n(*temporary) = 12\n(*temporary) = \"THINOUTLINE\"\n(*temporary) = \"attempt to perform arithmetic on global 'mult' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:330: in function `UpdateCount'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:312: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:611: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:562: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:555>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:117: in function <Interface\\AddOns\\AdiBags\\widgets\\Section.lua:115>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:898: in function `PrepareSections'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:1004: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:499: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:486>\n[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Utility.lua:88: in function <Interface\\AddOns\\AdiBags\\core\\Utility.lua:80>\nInterface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:118: in function <Interface\\AddOns\\AdiBags\\widgets\\LayeredRegion.lua:107>",
			["session"] = 1360,
			["counter"] = 1,
		}, -- [39]
		{
			["message"] = "Interface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:829: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2020/07/26 15:03:52",
			["locals"] = "self = <table> {\n options = <table> {\n }\n defaultOptions = <table> {\n }\n secAnchor = <unnamed> {\n }\n announceHook = <function> defined @Interface\\AddOns\\DBM-Core\\DBM-Core.lua:6721\n smallBars = <table> {\n }\n mainAnchor = <unnamed> {\n }\n bars = <table> {\n }\n hugeBars = <table> {\n }\n numBars = 8\n}\ntimer = 10\nid = \"%s	Test Bar\"\nicon = 136116\nhuge = nil\nsmall = nil\ncolor = nil\nisDummy = nil\ncolorType = 0\ninlineIcon = nil\nkeep = nil\nfade = nil\ncountdown = 0\ncountdownMax = 4\nnewBar = <table> {\n totalTime = 10\n lastUpdate = 2542790.050000\n next = <table> {\n }\n id = \"%s	Test Bar\"\n owner = <table> {\n }\n delta = 0.018000\n countdownMax = 4\n countdown = 0\n colorType = 0\n curTime = 2542790.034000\n timer = 10\n frame = DBT_Bar_11 {\n }\n}\n(*temporary) = nil\n(*temporary) = <table> {\n totalTime = 10\n lastUpdate = 2542790.050000\n next = <table> {\n }\n id = \"%s	Test Bar\"\n owner = <table> {\n }\n delta = 0.018000\n countdownMax = 4\n countdown = 0\n colorType = 0\n curTime = 2542790.034000\n timer = 10\n frame = DBT_Bar_11 {\n }\n}\n(*temporary) = 4\n(*temporary) = \"attempt to call method 'CreateBeautyBorder' (a nil value)\"\nGetTime = <function> defined =[C]:-1\nnext = <function> defined =[C]:-1\nunusedBarObjects = <table> {\n}\ncreateBarFrame = <function> defined @Interface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:775\nmt = <table> {\n __index = <table> {\n }\n}\n",
			["stack"] = "Interface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:829: in function `CreateBar'\nInterface\\AddOns\\DBM-Core\\DBM-Core-1.13.13b.lua:9804: in function `Start'\nInterface\\AddOns\\DBM-Core\\DBM-Core-1.13.13b.lua:6688: in function `DemoMode'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1389: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1389>",
			["session"] = 1368,
			["counter"] = 1,
		}, -- [40]
		{
			["message"] = "[string \"DBT_Bar_1BarIcon1:CreateBeautyBorder(6)\"]:1: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2020/07/26 15:06:46",
			["locals"] = "(*temporary) = nil\n(*temporary) = DBT_Bar_1BarIcon1 {\n 0 = <userdata>\n}\n(*temporary) = 6\n(*temporary) = \"attempt to call method 'CreateBeautyBorder' (a nil value)\"\n",
			["stack"] = "[string \"DBT_Bar_1BarIcon1:CreateBeautyBorder(6)\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1369,
			["counter"] = 4,
		}, -- [41]
		{
			["message"] = "Interface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:899: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2020/07/26 15:05:18",
			["locals"] = "self = <table> {\n options = <table> {\n }\n defaultOptions = <table> {\n }\n secAnchor = <unnamed> {\n }\n announceHook = <function> defined @Interface\\AddOns\\DBM-Core\\DBM-Core.lua:6721\n smallBars = <table> {\n }\n mainAnchor = <unnamed> {\n }\n bars = <table> {\n }\n hugeBars = <table> {\n }\n numBars = 1\n}\ntimer = 25\nid = \"dummy1\"\nicon = 136116\nhuge = nil\nsmall = true\ncolor = nil\nisDummy = true\ncolorType = 1\ninlineIcon = nil\nkeep = nil\nfade = nil\ncountdown = nil\ncountdownMax = nil\nnewBar = <table> {\n totalTime = 25\n lastUpdate = 2542875.855000\n fadingIn = 0\n small = true\n id = \"dummy1\"\n owner = <table> {\n }\n colorType = 1\n timer = 25\n frame = DBT_Bar_1 {\n }\n}\nnewFrame = DBT_Bar_1 {\n 0 = <userdata>\n obj = <table> {\n }\n}\nenlargeTime = 11\nimportantBar = false\n(*temporary) = nil\n(*temporary) = <table> {\n totalTime = 25\n lastUpdate = 2542875.855000\n fadingIn = 0\n small = true\n id = \"dummy1\"\n owner = <table> {\n }\n colorType = 1\n timer = 25\n frame = DBT_Bar_1 {\n }\n}\n(*temporary) = 6\n(*temporary) = \"attempt to call method 'CreateBeautyBorder' (a nil value)\"\nGetTime = <function> defined =[C]:-1\nnext = <function> defined =[C]:-1\nunusedBarObjects = <table> {\n}\ncreateBarFrame = <function> defined @Interface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:775\nmt = <table> {\n __index = <table> {\n }\n}\n",
			["stack"] = "Interface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:899: in function `CreateBar'\nInterface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:919: in function `CreateDummyBar'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1685: in function `?'\nInterface\\AddOns\\DBM-Core\\DBM-Core-1.13.13b.lua:2580: in function `LoadGUI'\nInterface\\AddOns\\DBM-Core\\DBM-Core-1.13.13b.lua:2609: in function `OnClick'\nInterface\\AddOns\\ChocolateBar\\Chocolate.lua:289: in function <Interface\\AddOns\\ChocolateBar\\Chocolate.lua:286>",
			["session"] = 1369,
			["counter"] = 10,
		}, -- [42]
		{
			["message"] = "Interface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:1432: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2020/07/26 15:13:51",
			["locals"] = "self = <table> {\n totalTime = 25\n lastUpdate = 2543388.879000\n fadingIn = 0\n small = true\n id = \"dummy1\"\n owner = <table> {\n }\n colorType = 1\n timer = 25\n frame = DBT_Bar_1 {\n }\n}\nframe = DBT_Bar_1 {\n 0 = <userdata>\n obj = <table> {\n }\n}\nframe_name = \"DBT_Bar_1\"\nbar = DBT_Bar_1Bar {\n 0 = <userdata>\n}\nspark = DBT_Bar_1BarSpark {\n 0 = <userdata>\n}\ntexture = DBT_Bar_1BarTexture {\n 0 = <userdata>\n}\nicon1 = DBT_Bar_1BarIcon1 {\n 0 = <userdata>\n}\nicon2 = DBT_Bar_1BarIcon2 {\n 0 = <userdata>\n}\nname = DBT_Bar_1BarName {\n 0 = <userdata>\n}\ntimer = DBT_Bar_1BarTimer {\n 0 = <userdata>\n}\nbarOptions = <table> {\n StartColorPR = 1\n Scale = 0.900000\n HugeBarsEnabled = false\n EnlargeBarsPercent = 0.125000\n HugeBarYOffset = 12\n EndColorPR = 0.501961\n ExpandUpwardsLarge = true\n ExpandUpwards = true\n TimerPoint = \"CENTER\"\n EndColorDG = 0\n Alpha = 0.800000\n HugeTimerPoint = \"CENTER\"\n StartColorIR = 0.470588\n StartColorUIR = 1\n StartColorAG = 0.545098\n EndColorDR = 1\n HugeBarXOffset = 0\n StartColorRR = 0.501961\n StartColorUIG = 1\n HugeScale = 1.200000\n BarYOffset = 2\n StartColorDG = 0.301961\n StartColorAR = 0.376471\n EndColorAER = 1\n StartColorIB = 1\n EndColorAEB = 0.247059\n HugeTimerX = -12\n BarXOffset = 0\n EndColorB = 0\n EndColorDB = 1\n FontSize = 14\n EndColorIB = 1\n EndColorRB = 0.301961\n TimerX = -218.666656\n EndColorIR = 0.047059\n EndColorRR = 0.109804\n Texture = \"Interface\\Addons\\SharedMedia\\statusbar\\Glamour2\"\n BarStyle = \"DBM\"\n EnlargeBarTime = 11\n StartColorDR = 0.901961\n Heigh = 14\n EndColorAB = 1\n Width = 200\n EndColorPG = 0.411765\n EndColorIG = 0.878431\n EndColorAEG = 0.043137\n StartColorAEB = 0.458824\n HugeTimerY = -143\n FontFlag = \"None\"\n ClickThrough = true\n HugeAlpha = 1\n StartColorB = 0\n Height = 24\n TDecimal = 11\n StartColorAB = 1\n StartColorAER = 1\n EndColorUIG = 0.921569\n StartColorRG = 1\n EndColorG = 0\n StartColorRB = 0.501961\n StartColorIG = 0.968627\n EndColorUIR = 1\n EndColorRG = 1\n StartColorUIB = 0.062745\n StartColorG = 0.701961\n StartColorR = 1\n HugeWidth = 280\n EndColorR = 1\n StartColorPB = 0.419608\n TimerY = 8.832896\n StartColorAEG = 0.466667\n EndColorAG = 0.384314\n EndColorPB = 0.286275\n StartColorDB = 1\n EndColorAR = 0.149020\n StartColorPG = 0.776471\n EndColorUIB = 0.011765\n}\nsparkEnabled = true\nenlarged = nil\nbarTextColorRed = 1\nbarTextColorGreen = 1\nbarTextColorBlue = 1\nbarHeight = 24\nbarWidth = 200\nbarHugeWidth = 280\n(*temporary) = nil\n(*temporary) = DBT_Bar_1BarIcon1 {\n 0 = <userdata>\n}\n(*temporary) = 6\n(*temporary) = \"attempt to call method 'CreateBeautyBorder' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:1432: in function `ApplyStyle'\nInterface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:897: in function `CreateBar'\nInterface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:918: in function `CreateDummyBar'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1685: in function `?'\nInterface\\AddOns\\DBM-Core\\DBM-Core-1.13.13b.lua:2580: in function `LoadGUI'\nInterface\\AddOns\\DBM-Core\\DBM-Core-1.13.13b.lua:2609: in function `OnClick'\nInterface\\AddOns\\ChocolateBar\\Chocolate.lua:289: in function <Interface\\AddOns\\ChocolateBar\\Chocolate.lua:286>",
			["session"] = 1372,
			["counter"] = 1,
		}, -- [43]
		{
			["message"] = "Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2288: Invalid option: TDecimal",
			["time"] = "2020/07/26 15:36:12",
			["locals"] = "(*temporary) = \"Invalid option: TDecimal\"\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:662: in function `SetOption'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2288: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2283>\n[C]: ?\n[C]: in function `SetValue'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2278: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2274>\n[C]: in function `Show'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1302: in function `DisplayFrame'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1230: in function `OnButtonClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1376,
			["counter"] = 3,
		}, -- [44]
		{
			["message"] = "Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2082: Invalid option: StartColorUIR",
			["time"] = "2020/07/26 15:36:12",
			["locals"] = "(*temporary) = \"Invalid option: StartColorUIR\"\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:662: in function `SetOption'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2082: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2081>\n[C]: in function `SetColorRGB'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2061: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2061>\n[C]: in function `Show'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1302: in function `DisplayFrame'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1230: in function `OnButtonClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1377,
			["counter"] = 6,
		}, -- [45]
		{
			["message"] = "Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2088: Invalid option: EndColorUIR",
			["time"] = "2020/07/26 15:36:12",
			["locals"] = "(*temporary) = \"Invalid option: EndColorUIR\"\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:662: in function `SetOption'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2088: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2087>\n[C]: in function `SetColorRGB'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2071: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2071>\n[C]: in function `Show'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1302: in function `DisplayFrame'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1230: in function `OnButtonClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1377,
			["counter"] = 6,
		}, -- [46]
		{
			["message"] = "Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2288: Invalid option: EnlargeBarTime",
			["time"] = "2020/07/26 15:36:12",
			["locals"] = "(*temporary) = \"Invalid option: EnlargeBarTime\"\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:662: in function `SetOption'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2288: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2283>\n[C]: ?\n[C]: in function `SetValue'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2278: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2274>\n[C]: in function `Show'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1302: in function `DisplayFrame'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1230: in function `OnButtonClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1377,
			["counter"] = 4,
		}, -- [47]
		{
			["message"] = "Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2288: Invalid option: Alpha",
			["time"] = "2020/07/26 15:36:12",
			["locals"] = "(*temporary) = \"Invalid option: Alpha\"\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:662: in function `SetOption'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2288: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2283>\n[C]: ?\n[C]: in function `SetValue'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2278: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2274>\n[C]: in function `Show'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1302: in function `DisplayFrame'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1230: in function `OnButtonClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1377,
			["counter"] = 4,
		}, -- [48]
		{
			["message"] = "Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2288: Invalid option: HugeAlpha",
			["time"] = "2020/07/26 15:36:12",
			["locals"] = "(*temporary) = \"Invalid option: HugeAlpha\"\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:662: in function `SetOption'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2288: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2283>\n[C]: ?\n[C]: in function `SetValue'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2278: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2274>\n[C]: in function `Show'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1302: in function `DisplayFrame'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1230: in function `OnButtonClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1377,
			["counter"] = 4,
		}, -- [49]
		{
			["message"] = "Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2083: Invalid option: StartColorUIG",
			["time"] = "2020/07/26 15:48:54",
			["locals"] = "(*temporary) = \"Invalid option: StartColorUIG\"\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:686: in function `SetOption'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2083: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2081>\n[C]: in function `SetColorRGB'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2061: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2061>\n[C]: in function `Show'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1302: in function `DisplayFrame'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1230: in function `OnButtonClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1378,
			["counter"] = 1,
		}, -- [50]
		{
			["message"] = "Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2089: Invalid option: EndColorUIG",
			["time"] = "2020/07/26 15:48:54",
			["locals"] = "(*temporary) = \"Invalid option: EndColorUIG\"\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:686: in function `SetOption'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2089: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2087>\n[C]: in function `SetColorRGB'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2071: in function <Interface\\AddOns\\DBM-GUI\\DBM-GUI.lua:2071>\n[C]: in function `Show'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1302: in function `DisplayFrame'\nInterface\\AddOns\\DBM-GUI\\DBM-GUI.lua:1230: in function `OnButtonClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1378,
			["counter"] = 1,
		}, -- [51]
		{
			["message"] = "Interface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:1522: The option Font requires a string value. (tried to assign a nil value)",
			["time"] = "2020/07/26 15:50:16",
			["locals"] = "(*temporary) = \"The option Font requires a string value. (tried to assign a nil value)\"\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:725: in function `SetOption'\nInterface\\AddOns\\DBM-StatusBarTimers\\DBT.lua:1522: in function `SetSkin'\nInterface\\AddOns\\DBM-Karma-Skin\\DBM-Karma-Skin.lua:7: in main chunk",
			["session"] = 1379,
			["counter"] = 1,
		}, -- [52]
		{
			["message"] = "Interface\\AddOns\\Talented\\ui\\arrows.lua:7: attempt to index local 'parent' (a nil value)",
			["time"] = "2020/07/27 14:16:37",
			["locals"] = "parent = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'parent' (a nil value)\"\nNORMAL_FONT_COLOR = <table> {\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 0\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 0.820000\n r = 1\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\narrows = <table> {\n used = <table> {\n }\n available = <table> {\n }\n}\n",
			["stack"] = "Interface\\AddOns\\Talented\\ui\\arrows.lua:7: in function <Interface\\AddOns\\Talented\\ui\\arrows.lua:6>\nInterface\\AddOns\\Talented\\ui\\arrows.lua:22: in function `MakeArrow'\nInterface\\AddOns\\Talented\\ui\\lines.lua:48: in function <Interface\\AddOns\\Talented\\ui\\lines.lua:30>\nInterface\\AddOns\\Talented\\ui\\lines.lua:166: in function `DrawLine'\nInterface\\AddOns\\Talented\\view-View.lua:127: in function `SetClass'\nInterface\\AddOns\\Talented\\view-View.lua:157: in function `SetTemplate'\nInterface\\AddOns\\Talented\\core.lua:269: in function `SetTemplate'\nInterface\\AddOns\\Talented\\core.lua:357: in function `Update'\nInterface\\AddOns\\Talented\\core.lua:346: in function <Interface\\AddOns\\Talented\\core.lua:343>\n(tail call): ?\n[string \"TOGGLETALENTS\"]:1: in function <[string \"TOGGLETALENTS\"]:1>",
			["session"] = 1399,
			["counter"] = 1,
		}, -- [53]
		{
			["message"] = "Interface\\AddOns\\Talented\\ui\\buttons.lua:70: attempt to index field 'slot' (a nil value)",
			["time"] = "2020/07/27 14:24:06",
			["locals"] = "parent = <unnamed> {\n overlay = <unnamed> {\n }\n topleft = <unnamed> {\n }\n topright = <unnamed> {\n }\n bottomleft = <unnamed> {\n }\n bottomright = <unnamed> {\n }\n name = <unnamed> {\n }\n view = <table> {\n }\n tab = 1\n 0 = <userdata>\n clear = <unnamed> {\n }\n}\nbutton = <unnamed> {\n 0 = <userdata>\n texture = <unnamed> {\n }\n}\nt = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = <unnamed> {\n 0 = <userdata>\n texture = <unnamed> {\n }\n}\n(*temporary) = <userdata>\n(*temporary) = \"attempt to index field 'slot' (a nil value)\"\nCreateFrame = <function> defined =[C]:-1\nCreateTexture = <function> defined @Interface\\AddOns\\Talented\\ui\\buttons.lua:4\nMakeRankFrame = <function> defined @Interface\\AddOns\\Talented\\ui\\buttons.lua:31\nButton_OnEnter = <function> defined @Interface\\AddOns\\Talented\\ui\\buttons.lua:17\nButton_OnLeave = <function> defined @Interface\\AddOns\\Talented\\ui\\buttons.lua:22\nButton_OnClick = <function> defined @Interface\\AddOns\\Talented\\ui\\buttons.lua:26\nbuttons = <table> {\n used = <table> {\n }\n available = <table> {\n }\n}\n",
			["stack"] = "Interface\\AddOns\\Talented\\ui\\buttons.lua:70: in function <Interface\\AddOns\\Talented\\ui\\buttons.lua:41>\nInterface\\AddOns\\Talented\\ui\\buttons.lua:90: in function `MakeButton'\nInterface\\AddOns\\Talented\\view-View.lua:111: in function `SetClass'\nInterface\\AddOns\\Talented\\view-View.lua:157: in function `SetTemplate'\nInterface\\AddOns\\Talented\\core.lua:269: in function `SetTemplate'\nInterface\\AddOns\\Talented\\core.lua:357: in function `Update'\nInterface\\AddOns\\Talented\\core.lua:346: in function <Interface\\AddOns\\Talented\\core.lua:343>\n(tail call): ?\n[string \"TOGGLETALENTS\"]:1: in function <[string \"TOGGLETALENTS\"]:1>",
			["session"] = 1405,
			["counter"] = 1,
		}, -- [54]
		{
			["message"] = "Interface\\AddOns\\Talented\\view-View.lua:211: attempt to index field 'slot' (a nil value)",
			["time"] = "2020/07/27 14:24:51",
			["locals"] = "self = <table> {\n name = \"base\"\n class = \"HUNTER\"\n frame = TalentedFrame {\n }\n template = <table> {\n }\n elements = <table> {\n }\n}\ntemplate = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n name = \"Current\"\n class = \"HUNTER\"\n}\ntarget = nil\ntotal = 0\ninfo = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n}\nat_cap = false\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n}\n(for control) = 1\ntab = 1\ntree = <table> {\n numtalents = 16\n talents = <table> {\n }\n info = <table> {\n }\n}\ncount = 2\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n 4 = <table> {\n }\n 5 = <table> {\n }\n 6 = <table> {\n }\n 7 = <table> {\n }\n 8 = <table> {\n }\n 9 = <table> {\n }\n 10 = <table> {\n }\n 11 = <table> {\n }\n 12 = <table> {\n }\n 13 = <table> {\n }\n 14 = <table> {\n }\n 15 = <table> {\n }\n 16 = <table> {\n }\n}\n(for control) = 1\nindex = 1\n_talent = <table> {\n info = <table> {\n }\n}\nrank = 2\nbutton = <unnamed> {\n 0 = <userdata>\n beautyShadow = <table> {\n }\n id = 1\n rank = <unnamed> {\n }\n beautyBorder = <table> {\n }\n texture = <unnamed> {\n }\n}\ncolor = <table> {\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 0.100000\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 1\n r = 0.100000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\nstate = \"available\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = true\n(*temporary) = \"available\"\n(*temporary) = <table> {\n tipValues = <table> {\n }\n name = \"Improved Aspect of the Hawk\"\n ranks = 5\n column = 2\n icon = 136076\n row = 1\n tips = \"While Aspect of the Hawk is active, all normal ranged attacks have a %d%% chance of increasing ranged attack speed by 30%% for 12 sec.\"\n}\n(*temporary) = 0\n(*temporary) = 14\n(*temporary) = 2\n(*temporary) = 5\n(*temporary) = 1\n(*temporary) = 14\n(*temporary) = \"attempt to index field 'slot' (a nil value)\"\nTalented = <table> {\n CreateTemplateMenu = <function> defined @Interface\\AddOns\\Talented\\ui\\menu.lua:65\n defaults = <table> {\n }\n LoadAddOn = <function> defined @Interface\\AddOns\\Talented\\core.lua:74\n OpenOptionsFrame = <function> defined @Interface\\AddOns\\Talented\\ui\\menu.lua:26\n MakeArrow = <function> defined @Interface\\AddOns\\Talented\\ui\\arrows.lua:17\n GetTalentPrereqs = <function> defined @Interface\\AddOns\\Talented\\spell.lua:234\n UnregisterComm = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:153\n HideTooltipInfo = <function> defined @Interface\\AddOns\\Talented\\tips.lua:134\n DataAddonLoaded = <function> defined @Interface\\AddOns\\Talented\\talents.lua:151\n GetDefaultMode = <function> defined @Interface\\AddOns\\Talented\\core.lua:283\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:409\n UpdateTemplateName = <function> defined @Interface\\AddOns\\Talented\\core.lua:123\n GetMode = <function> defined @Interface\\AddOns\\Talented\\core.lua:54\n SetTemplate = <function> defined @Interface\\AddOns\\Talented\\core.lua:262\n SetMode = <function> defined @Interface\\AddOns\\Talented\\core.lua:58\n RegisterMessage = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:90\n UnregisterMessage = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:153\n Update = <function> defined @Interface\\AddOns\\Talented\\core.lua:353\n hooks = <table> {\n }",
			["stack"] = "Interface\\AddOns\\Talented\\view-View.lua:211: in function `Update'\nInterface\\AddOns\\Talented\\view-View.lua:138: in function `SetClass'\nInterface\\AddOns\\Talented\\view-View.lua:157: in function `SetTemplate'\nInterface\\AddOns\\Talented\\core.lua:269: in function `SetTemplate'\nInterface\\AddOns\\Talented\\core.lua:357: in function `Update'\nInterface\\AddOns\\Talented\\core.lua:346: in function <Interface\\AddOns\\Talented\\core.lua:343>\n(tail call): ?\n[string \"TOGGLETALENTS\"]:1: in function <[string \"TOGGLETALENTS\"]:1>",
			["session"] = 1406,
			["counter"] = 1,
		}, -- [55]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'whoaThickFrames_Classic' tried to call the protected function 'CompactRaidFrame3:ClearAllPoints()'.",
			["time"] = "2020/07/27 15:37:48",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `ClearAllPoints'\nInterface\\FrameXML\\FlowContainer.lua:157: in function `FlowContainer_DoLayout'\nInterface\\FrameXML\\FlowContainer.lua:17: in function `FlowContainer_ResumeUpdates'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:185: in function `CompactRaidFrameContainer_LayoutFrames'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:130: in function `CompactRaidFrameContainer_TryUpdate'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:57: in function `CompactRaidFrameContainer_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 1416,
			["counter"] = 1,
		}, -- [56]
		{
			["message"] = "Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua:1117: attempt to call global 'TEXT' (a nil value)",
			["time"] = "2020/07/27 20:36:04",
			["locals"] = "info = <table> {\n}\n(*temporary) = nil\n(*temporary) = \"All Slots\"\n(*temporary) = \"attempt to call global 'TEXT' (a nil value)\"\natsw_currentinvslotfilter = <table> {\n}\n",
			["stack"] = "Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua:1117: in function `ATSWFilterFrame_LoadInvSlots'\nInterface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua:1112: in function `initFunction'\nInterface\\FrameXML\\UIDropDownMenu.lua:79: in function `UIDropDownMenu_Initialize'\nInterface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua:1099: in function `ATSWInvSlotDropDown_OnLoad'\n[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 1422,
			["counter"] = 1,
		}, -- [57]
		{
			["message"] = "Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua:1072: attempt to call global 'TEXT' (a nil value)",
			["time"] = "2020/07/27 20:36:04",
			["locals"] = "info = <table> {\n}\n(*temporary) = nil\n(*temporary) = \"All Subclasses\"\n(*temporary) = \"attempt to call global 'TEXT' (a nil value)\"\natsw_currentsubclassfilter = <table> {\n}\n",
			["stack"] = "Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua:1072: in function `ATSWFilterFrame_LoadSubClasses'\nInterface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua:1067: in function `initFunction'\nInterface\\FrameXML\\UIDropDownMenu.lua:79: in function `UIDropDownMenu_Initialize'\nInterface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua:1054: in function `ATSWSubClassDropDown_OnLoad'\n[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 1422,
			["counter"] = 1,
		}, -- [58]
		{
			["message"] = "Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua:371: attempt to call global 'IsTradeSkillLinked' (a nil value)",
			["time"] = "2020/07/27 20:36:26",
			["locals"] = "self = ATSWFrame {\n 0 = <userdata>\n}\nevent = \"TRADE_SKILL_SHOW\"\nversion = \"1.13.5\"\nbuild = \"35186\"\ndate = \"Jul 14 2020\"\nlocale = \"enUS\"\n(*temporary) = nil\n(*temporary) = \"attempt to call global 'IsTradeSkillLinked' (a nil value)\"\natsw_bankopened = false\natsw_processing = false\natsw_processingtimeout = 0\natsw_retries = 0\natsw_retrydelay = 0\natsw_scans = 0\natsw_updating = false\natsw_incombat = false\n",
			["stack"] = "Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua:371: in function `ATSWFrame_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1422,
			["counter"] = 1,
		}, -- [59]
		{
			["message"] = "[string \"ATSWRankFrame:OnLoad\"]:1: attempt to index global 'this' (a nil value)",
			["time"] = "2020/07/27 20:37:33",
			["locals"] = "self = ATSWRankFrame {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'this' (a nil value)\"\n",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 1423,
			["counter"] = 1,
		}, -- [60]
		{
			["message"] = "[string \"ATSWSkill1:OnLoad\"]:1: attempt to index global 'this' (a nil value)",
			["time"] = "2020/07/27 20:37:33",
			["locals"] = "self = ATSWSkill1 {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'this' (a nil value)\"\n",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 1423,
			["counter"] = 1,
		}, -- [61]
		{
			["message"] = "[string \"ATSWSkill2:OnLoad\"]:1: attempt to index global 'this' (a nil value)",
			["time"] = "2020/07/27 20:37:33",
			["locals"] = "self = ATSWSkill2 {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'this' (a nil value)\"\n",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 1423,
			["counter"] = 1,
		}, -- [62]
		{
			["message"] = "[string \"ATSWSkill3:OnLoad\"]:1: attempt to index global 'this' (a nil value)",
			["time"] = "2020/07/27 20:37:33",
			["locals"] = "self = ATSWSkill3 {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'this' (a nil value)\"\n",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 1423,
			["counter"] = 1,
		}, -- [63]
		{
			["message"] = "[string \"ATSWSkill4:OnLoad\"]:1: attempt to index global 'this' (a nil value)",
			["time"] = "2020/07/27 20:37:33",
			["locals"] = "self = ATSWSkill4 {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'this' (a nil value)\"\n",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 1423,
			["counter"] = 1,
		}, -- [64]
		{
			["message"] = "[string \"ATSWSkill5:OnLoad\"]:1: attempt to index global 'this' (a nil value)",
			["time"] = "2020/07/27 20:37:33",
			["locals"] = "self = ATSWSkill5 {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'this' (a nil value)\"\n",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 1423,
			["counter"] = 1,
		}, -- [65]
		{
			["message"] = "[string \"ATSWSkill6:OnLoad\"]:1: attempt to index global 'this' (a nil value)",
			["time"] = "2020/07/27 20:37:33",
			["locals"] = "self = ATSWSkill6 {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'this' (a nil value)\"\n",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 1423,
			["counter"] = 1,
		}, -- [66]
		{
			["message"] = "[string \"ATSWSkill7:OnLoad\"]:1: attempt to index global 'this' (a nil value)",
			["time"] = "2020/07/27 20:37:33",
			["locals"] = "self = ATSWSkill7 {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'this' (a nil value)\"\n",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 1423,
			["counter"] = 1,
		}, -- [67]
		{
			["message"] = "[string \"ATSWSkill8:OnLoad\"]:1: attempt to index global 'this' (a nil value)",
			["time"] = "2020/07/27 20:37:33",
			["locals"] = "self = ATSWSkill8 {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'this' (a nil value)\"\n",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 1423,
			["counter"] = 1,
		}, -- [68]
		{
			["message"] = "[string \"ATSWSkill9:OnLoad\"]:1: attempt to index global 'this' (a nil value)",
			["time"] = "2020/07/27 20:37:33",
			["locals"] = "self = ATSWSkill9 {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'this' (a nil value)\"\n",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 1423,
			["counter"] = 1,
		}, -- [69]
		{
			["message"] = "Error loading Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw_abstraction.lua",
			["session"] = 1423,
			["time"] = "2020/07/27 20:37:46",
			["counter"] = 4,
		}, -- [70]
		{
			["message"] = "...dOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons-2.1.0.lua:548: attempt to index field '?' (a nil value)",
			["time"] = "2020/07/27 21:40:22",
			["locals"] = "srti = <table> {\n defaults = <table> {\n }\n PrintHelp = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:86\n AreModifiersDown = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:508\n Print = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:74\n SetRaidTarget = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:522\n Show = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:427\n UpdateSaved = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:357\n ShowFromBinding = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:412\n frame = SRTIRadialMenu {\n }\n version = \"2.1.0\"\n IsNameplateUnderMouse = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:468\n}\niconStrings = <table> {\n square = 6\n silver = 5\n triangle = 4\n skull = 8\n purple = 3\n remove = 0\n moon = 5\n star = 1\n orange = 2\n red = 7\n clear = 0\n diamond = 3\n blue = 6\n x = 7\n white = 8\n green = 4\n cross = 7\n yellow = 1\n circle = 2\n none = 0\n}\niconNames = <table> {\n 1 = \"remove icon\"\n 2 = \"yellow star\"\n 3 = \"orange circle\"\n 4 = \"purple diamond\"\n 5 = \"green triangle\"\n 6 = \"silver moon\"\n 7 = \"blue square\"\n 8 = \"red cross\"\n 9 = \"white skull\"\n}\nthirdParty = <table> {\n 1 = \"PugLax\"\n}\nclickFrameScripts = <table> {\n}\nclickFrames = <table> {\n 1 = \"WorldFrame\"\n 2 = \"TargetFrame\"\n 3 = \"FocusFrame\"\n 4 = \"Boss1TargetFrame\"\n 5 = \"Boss2TargetFrame\"\n 6 = \"Boss3TargetFrame\"\n 7 = \"Boss4TargetFrame\"\n 8 = \"Boss5TargetFrame\"\n}\nthirdPartyFrameScripts = <table> {\n}\nprint = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:82\nthirdPartyUF = <table> {\n Perl_Config = <table> {\n }\n Stuf = <table> {\n }\n PitBull4 = <table> {\n }\n XPerl = <table> {\n }\n ShadowedUnitFrames = <table> {\n }\n}\norigSetRaidTarget = <function> defined =[C]:-1\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = \"WorldFrame\"\n 2 = \"TargetFrame\"\n 3 = \"FocusFrame\"\n 4 = \"Boss1TargetFrame\"\n 5 = \"Boss2TargetFrame\"\n 6 = \"Boss3TargetFrame\"\n 7 = \"Boss4TargetFrame\"\n 8 = \"Boss5TargetFrame\"\n}\n(for control) = 3\n_ = 3\nframeName = \"FocusFrame\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"OnMouseUp\"\n(*temporary) = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:552\n(*temporary) = \"attempt to index field '?' (a nil value)\"\n",
			["stack"] = "...dOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons-2.1.0.lua:548: in main chunk",
			["session"] = 1425,
			["counter"] = 1,
		}, -- [71]
		{
			["message"] = "...dOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons-2.1.0.lua:370: attempt to call field 'Options' (a nil value)",
			["time"] = "2020/07/27 21:40:22",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"attempt to call field 'Options' (a nil value)\"\nsrti = <table> {\n defaults = <table> {\n }\n PrintHelp = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:86\n AreModifiersDown = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:508\n Print = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:74\n SetRaidTarget = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:522\n Show = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:427\n UpdateSaved = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:357\n ShowFromBinding = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:412\n frame = SRTIRadialMenu {\n }\n version = \"2.1.0\"\n IsNameplateUnderMouse = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:468\n}\n",
			["stack"] = "...dOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons-2.1.0.lua:370: in function `UpdateSaved'\n...dOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons-2.1.0.lua:386: in function <...dOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:382>",
			["session"] = 1425,
			["counter"] = 1,
		}, -- [72]
		{
			["message"] = "...dOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons-2.1.0.lua:395: attempt to call field 'RegisterExternalUFPrebuilt' (a nil value)",
			["time"] = "2020/07/27 21:40:30",
			["locals"] = "self = SRTIRadialMenu {\n origShow = <function> defined =[C]:-1\n Show = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:137\n 0 = <userdata>\n}\nevent = \"PLAYER_LOGIN\"\naddon = nil\n(*temporary) = nil\n(*temporary) = \"attempt to call field 'RegisterExternalUFPrebuilt' (a nil value)\"\nsrti = <table> {\n defaults = <table> {\n }\n PrintHelp = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:86\n AreModifiersDown = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:508\n Print = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:74\n SetRaidTarget = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:522\n Show = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:427\n UpdateSaved = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:357\n ShowFromBinding = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:412\n frame = SRTIRadialMenu {\n }\n version = \"2.1.0\"\n IsNameplateUnderMouse = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:468\n}\nthirdPartyUF = <table> {\n Perl_Config = <table> {\n }\n Stuf = <table> {\n }\n PitBull4 = <table> {\n }\n XPerl = <table> {\n }\n ShadowedUnitFrames = <table> {\n }\n}\n",
			["stack"] = "...dOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons-2.1.0.lua:395: in function <...dOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:382>",
			["session"] = 1425,
			["counter"] = 2,
		}, -- [73]
		{
			["message"] = "...dOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons-2.1.0.lua:552: attempt to call field 'OnMouseUp' (a nil value)",
			["time"] = "2020/07/27 21:40:37",
			["locals"] = "self = WorldFrame {\n 0 = <userdata>\n}\narg1 = \"LeftButton\"\n(*temporary) = nil\n(*temporary) = WorldFrame {\n 0 = <userdata>\n}\n(*temporary) = \"LeftButton\"\n(*temporary) = \"attempt to call field 'OnMouseUp' (a nil value)\"\nsrti = <table> {\n defaults = <table> {\n }\n PrintHelp = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:86\n AreModifiersDown = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:508\n Print = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:74\n SetRaidTarget = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:522\n Show = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:427\n UpdateSaved = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:357\n ShowFromBinding = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:412\n frame = SRTIRadialMenu {\n }\n version = \"2.1.0\"\n IsNameplateUnderMouse = <function> defined @Interface\\AddOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:468\n}\n",
			["stack"] = "...dOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons-2.1.0.lua:552: in function <...dOns\\SimpleRaidTargetIcons\\SimpleRaidTargetIcons.lua:552>",
			["session"] = 1425,
			["counter"] = 5,
		}, -- [74]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Experience.lua:124: attempt to perform arithmetic on global 'petPercent' (a nil value)",
			["time"] = "2020/07/28 08:43:12",
			["locals"] = "(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\Experience.lua:32\n(*temporary) = nil\n(*temporary) = \"pet (23):\n6712 / 7350 (91%)\"\n(*temporary) = <userdata>\n(*temporary) = \"):\n\"\n(*temporary) = \"6712\"\n(*temporary) = \" / \"\n(*temporary) = \"7350\"\n(*temporary) = \" (\"\n(*temporary) = \"91\"\n(*temporary) = \"%)\"\n(*temporary) = \"attempt to perform arithmetic on global 'petPercent' (a nil value)\"\nnxp = 6371\ngained = 6371\ncxp = 0\nhmmm = -1\nmxp = 0\ncmtk = CustomContainer_CombatMobsToKill {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\npercent = Infinite\n_ = 1\nrested = 2\noutput = \"player (24): [rested x2] \n0 / 0 (nan%)\"\nPlayerExpFrame = PlayerExpFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nr = 0\ng = 1\nb = 0\nColorGradient = <function> defined @Interface\\AddOns\\xVermin\\Experience.lua:32\nclass = \"HUNTER\"\npcxp = 6712\npmxp = 7350\nppercent = 91\nPetExpFrame = PetExpFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Experience.lua:124: in function <Interface\\AddOns\\xVermin\\Experience.lua:87>",
			["session"] = 1427,
			["counter"] = 1,
		}, -- [75]
		{
			["message"] = "[ADDON_ACTION_FORBIDDEN] AddOn 'Details' tried to call the protected function 'AcceptBattlefieldPort()'.",
			["time"] = "2020/07/28 10:12:16",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `AcceptBattlefieldPort'\nInterface\\FrameXML\\StaticPopup.lua:689: in function `OnAccept'\nInterface\\FrameXML\\StaticPopup.lua:5002: in function `StaticPopup_OnClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1435,
			["counter"] = 1,
		}, -- [76]
		{
			["message"] = "Interface\\AddOns\\PerfectRaid\\Dongle.lua:363: Attempt to register unknown event \"UNIT_HEAL_PREDICTION\"",
			["time"] = "2020/07/28 10:14:02",
			["stack"] = "Interface\\AddOns\\PerfectRaid\\Dongle.lua:456: in function `TriggerMessage'\nInterface\\AddOns\\PerfectRaid\\PerfectRaid_Config.lua:151: in function `SaveOptions'\nInterface\\AddOns\\PerfectRaid\\PerfectRaid_Config.lua:123: in function <Interface\\AddOns\\PerfectRaid\\PerfectRaid_Config.lua:123>",
			["session"] = 1435,
			["counter"] = 1,
		}, -- [77]
		{
			["message"] = "Interface\\AddOns\\PerfectRaid\\Dongle.lua:378: Attempt to unregister unknown event \"UNIT_HEAL_PREDICTION\"",
			["time"] = "2020/07/28 10:14:10",
			["stack"] = "Interface\\AddOns\\PerfectRaid\\Dongle.lua:456: in function `TriggerMessage'\nInterface\\AddOns\\PerfectRaid\\PerfectRaid_Config.lua:151: in function `SaveOptions'\nInterface\\AddOns\\PerfectRaid\\PerfectRaid_Config.lua:123: in function <Interface\\AddOns\\PerfectRaid\\PerfectRaid_Config.lua:123>",
			["session"] = 1435,
			["counter"] = 1,
		}, -- [78]
		{
			["message"] = "...ns\\TellMeWhen\\Components\\Core\\Common\\PlayerNames.lua:96: attempt to concatenate field '?' (a nil value)",
			["time"] = "2020/07/28 10:14:11",
			["locals"] = "InCombatSkipped",
			["stack"] = "...ns\\TellMeWhen\\Components\\Core\\Common\\PlayerNames.lua:96: in function `?'\n...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:119: in function <...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:119>\n[C]: ?\n...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:29: in function <...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:25>\n...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:64: in function `Fire'\n...ce\\AddOns\\Details\\Libs\\AceEvent-3.0\\AceEvent-3.0-4.lua:120: in function <...ce\\AddOns\\Details\\Libs\\AceEvent-3.0\\AceEvent-3.0.lua:119>",
			["session"] = 1435,
			["counter"] = 4,
		}, -- [79]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Experience.lua:30: attempt to concatenate local 'nxp' (a nil value)",
			["time"] = "2020/07/28 16:43:37",
			["locals"] = "_ = \"Hunter\"\nclass = \"HUNTER\"\n_ = 3\nr = nil\ng = nil\nb = nil\nnxp = nil\nhmmm = nil\ngained = nil\nnum = nil\nsegment = nil\nrelperc = nil\nr1 = nil\nr2 = nil\ng1 = nil\ng2 = nil\nb1 = nil\nb2 = nil\nf = nil\nPetExpFrame = nil\nPlayerExpFrame = nil\npercent = nil\nrested = nil\noutput = nil\npcxp = nil\npmxp = nil\nppercent = nil\ncmtk = nil\ncxp = 0\nmxp = 0\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = \"of -> cxp: 0\"\n(*temporary) = \"nxp: \"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to concatenate local 'nxp' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Experience.lua:30: in main chunk",
			["session"] = 1446,
			["counter"] = 2,
		}, -- [80]
		{
			["message"] = "(null)",
			["session"] = 1446,
			["time"] = "2020/07/24 16:00:06",
			["counter"] = 21,
		}, -- [81]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Experience.lua:114: attempt to call field 'text' (a table value)",
			["time"] = "2020/07/28 16:57:56",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\xVermin\\Experience.lua:114: in function <Interface\\AddOns\\xVermin\\Experience.lua:95>",
			["session"] = 1451,
			["counter"] = 1,
		}, -- [82]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'xVermin' tried to call the protected function 'CompactRaidFrame1:ClearAllPoints()'.",
			["time"] = "2020/07/28 17:21:11",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `ClearAllPoints'\nInterface\\FrameXML\\FlowContainer.lua:157: in function `FlowContainer_DoLayout'\nInterface\\FrameXML\\FlowContainer.lua:17: in function `FlowContainer_ResumeUpdates'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:185: in function `CompactRaidFrameContainer_LayoutFrames'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:130: in function `CompactRaidFrameContainer_TryUpdate'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:57: in function `CompactRaidFrameContainer_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 1456,
			["counter"] = 1,
		}, -- [83]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'ItemRack' tried to call the protected function 'AttemptToSaveBindings()'.",
			["time"] = "2020/07/24 16:00:07",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `AttemptToSaveBindings'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:2062: in function `SetSetBindings'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:544: in function `InitCore'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:281: in function `func'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:982: in function `OnUpdate'\n[string \"*:OnUpdate\"]:1: in function <[string \"*:OnUpdate\"]:1>",
			["session"] = 1462,
			["counter"] = 9,
		}, -- [84]
		{
			["message"] = "Interface\\AddOns\\Aptechka\\frame.lua:98: attempt to index local 'mh' (a number value)",
			["time"] = "2020/07/29 12:16:19",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\Aptechka\\frame.lua:98: in function <Interface\\AddOns\\Aptechka\\frame.lua:95>\nInterface\\AddOns\\Aptechka\\frame.lua:988: in function `SetJob'\nInterface\\AddOns\\Aptechka\\Aptechka-1.13.54.lua:2469: in function <Interface\\AddOns\\Aptechka\\Aptechka.lua:2403>\nInterface\\AddOns\\Aptechka\\Aptechka-1.13.54.lua:2482: in function <Interface\\AddOns\\Aptechka\\Aptechka.lua:2479>\nInterface\\AddOns\\Aptechka\\Aptechka-1.13.54.lua:1136: in function `?'\nInterface\\AddOns\\Aptechka\\Aptechka-1.13.54.lua:8: in function <Interface\\AddOns\\Aptechka\\Aptechka.lua:7>",
			["session"] = 1470,
			["counter"] = 46,
		}, -- [85]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Experience.lua:92: attempt to call method 'SetText' (a nil value)",
			["time"] = "2020/07/29 12:27:08",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n}\nevent = \"UNIT_PET\"\nisInitialLogin = \"player\"\nisReloadingUi = nil\n(*temporary) = nil\n(*temporary) = CustomContainer_CombatXPcurrent {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n(*temporary) = \"982 (XP)\"\n(*temporary) = \"attempt to call method 'SetText' (a nil value)\"\ncxp = 982\nmxp = 34000\nnxp = 982\ngained = 0\nhmmm = nil\ncmtk = CustomContainer_CombatMobsToKill {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\npercent = nil\n_ = 3\nrested = nil\noutput = nil\nPlayerExpFrame = PlayerExpFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nr = nil\ng = nil\nb = nil\nColorGradient = <function> defined @Interface\\AddOns\\xVermin\\Experience.lua:7\nclass = \"HUNTER\"\npcxp = nil\npmxp = nil\nppercent = nil\nPetExpFrame = PetExpFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Experience.lua:92: in function <Interface\\AddOns\\xVermin\\Experience.lua:79>",
			["session"] = 1472,
			["counter"] = 3,
		}, -- [86]
	},
}
