
BugGrabberDB = {
	["session"] = 1978,
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
			["message"] = "Interface\\AddOns\\xVermin\\Experience.lua:114: attempt to call field 'text' (a table value)",
			["time"] = "2020/07/28 16:57:56",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\xVermin\\Experience.lua:114: in function <Interface\\AddOns\\xVermin\\Experience.lua:95>",
			["session"] = 1451,
			["counter"] = 1,
		}, -- [81]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'xVermin' tried to call the protected function 'CompactRaidFrame1:ClearAllPoints()'.",
			["time"] = "2020/07/28 17:21:11",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `ClearAllPoints'\nInterface\\FrameXML\\FlowContainer.lua:157: in function `FlowContainer_DoLayout'\nInterface\\FrameXML\\FlowContainer.lua:17: in function `FlowContainer_ResumeUpdates'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:185: in function `CompactRaidFrameContainer_LayoutFrames'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:130: in function `CompactRaidFrameContainer_TryUpdate'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:57: in function `CompactRaidFrameContainer_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 1456,
			["counter"] = 1,
		}, -- [82]
		{
			["message"] = "Interface\\AddOns\\Aptechka\\frame.lua:98: attempt to index local 'mh' (a number value)",
			["time"] = "2020/07/29 12:16:19",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\Aptechka\\frame.lua:98: in function <Interface\\AddOns\\Aptechka\\frame.lua:95>\nInterface\\AddOns\\Aptechka\\frame.lua:988: in function `SetJob'\nInterface\\AddOns\\Aptechka\\Aptechka-1.13.54.lua:2469: in function <Interface\\AddOns\\Aptechka\\Aptechka.lua:2403>\nInterface\\AddOns\\Aptechka\\Aptechka-1.13.54.lua:2482: in function <Interface\\AddOns\\Aptechka\\Aptechka.lua:2479>\nInterface\\AddOns\\Aptechka\\Aptechka-1.13.54.lua:1136: in function `?'\nInterface\\AddOns\\Aptechka\\Aptechka-1.13.54.lua:8: in function <Interface\\AddOns\\Aptechka\\Aptechka.lua:7>",
			["session"] = 1470,
			["counter"] = 46,
		}, -- [83]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Experience.lua:92: attempt to call method 'SetText' (a nil value)",
			["time"] = "2020/07/29 12:27:08",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n}\nevent = \"UNIT_PET\"\nisInitialLogin = \"player\"\nisReloadingUi = nil\n(*temporary) = nil\n(*temporary) = CustomContainer_CombatXPcurrent {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n(*temporary) = \"982 (XP)\"\n(*temporary) = \"attempt to call method 'SetText' (a nil value)\"\ncxp = 982\nmxp = 34000\nnxp = 982\ngained = 0\nhmmm = nil\ncmtk = CustomContainer_CombatMobsToKill {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\npercent = nil\n_ = 3\nrested = nil\noutput = nil\nPlayerExpFrame = PlayerExpFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nr = nil\ng = nil\nb = nil\nColorGradient = <function> defined @Interface\\AddOns\\xVermin\\Experience.lua:7\nclass = \"HUNTER\"\npcxp = nil\npmxp = nil\nppercent = nil\nPetExpFrame = PetExpFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Experience.lua:92: in function <Interface\\AddOns\\xVermin\\Experience.lua:79>",
			["session"] = 1472,
			["counter"] = 3,
		}, -- [84]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SortBags.lua:606: attempt to index global 'AdiBagsContainer1' (a nil value)",
			["time"] = "2020/07/31 11:22:35",
			["locals"] = "_G = <table> {\n UpdateOnBarHighlightMarksBySpell = <function> defined @Interface\\FrameXML\\ActionButton.lua:70\n ERR_OUT_OF_CHI = \"Not enough chi\"\n DH_HAVOC_CORE_ABILITY_2 = \"Strong melee attack that consumes Fury. If it critical strikes, some Fury is refunded.\"\n MerchantItem9ItemButtonStock = MerchantItem9ItemButtonStock {\n }\n GetTrainerServiceTypeFilter = <function> defined =[C]:-1\n UNIT_NAMES_COMBATLOG_TOOLTIP = \"Color unit names.\"\n SetTrainerServiceTypeFilter = <function> defined =[C]:-1\n LE_GAME_ERR_CHAT_RAID_RESTRICTED_TRIAL = 742\n SPELL_FAILED_CUSTOM_ERROR_71 = \"This partygoer wants to dance with you.\"\n LE_GAME_ERR_PET_SPELL_TARGETS_DEAD = 399\n ERROR_CLUB_TICKET_COUNT_AT_MAX_COMMUNITY = \"Can't create any more invite links for this group.\"\n RecruitAFriendFrame = RecruitAFriendFrame {\n }\n CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdownButtonNormalTexture = CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdownButtonNormalTexture {\n }\n ERR_TRADE_EQUIPPED_BAG = \"You can't trade equipped bags.\"\n PVP_RANK_6_1 = \"Corporal\"\n MultiBarLeftButton7 = MultiBarLeftButton7 {\n }\n InterfaceOptionsNamesPanelUnitNameplatesShowAll = InterfaceOptionsNamesPanelUnitNameplatesShowAll {\n }\n VideoOptionsFrameDefaults = VideoOptionsFrameDefaults {\n }\n MerchantItem2AltCurrencyFrameItem1Text = MerchantItem2AltCurrencyFrameItem1Text {\n }\n DetailsWindowOptionsBarTextEditorEntryNumberLines = DetailsWindowOptionsBarTextEditorEntryNumberLines {\n }\n OPTION_TOOLTIP_ACTION_BUTTON_USE_KEY_DOWN = \"Action button keybinds will respond on key down, rather than on key up.\"\n BINDING_NAME_NAMEPLATES = \"Show Enemy Name Plates\"\n INSTANCE_UNAVAILABLE_OTHER_TEMPORARILY_DISABLED = \"%s cannot enter. This instance is temporarily disabled.\"\n MultiBarBottomRightButton8Shine5 = MultiBarBottomRightButton8Shine5 {\n }\n IsReferAFriendLinked = <function> defined =[C]:-1\n MAIL_LETTER_TOOLTIP = \"Click to make a permanent\ncopy of this letter.\"\n UnitFrameManaBar_UnregisterDefaultEvents = <function> defined @Interface\\FrameXML\\UnitFrame.lua:602\n ERR_NOAMMO_S = \"%s\"\n CHAT_CONFIG_OTHER_COMBAT = <table> {\n }\n FCFDockOverflowButton_OnClick = <function> defined @Interface\\FrameXML\\FloatingChatFrame.lua:2373\n BOOST2_WARRIOR_COLOSSUSSMASH = \"Use |cFFFFFFFFColossus Smash|r.\n\n|cFFFFFFFFColossus Smash|r increases your damage.\"\n BN_UNABLE_TO_RESOLVE_NAME = \"Unable to whisper '%s'. Blizzard services may be unavailable.\"\n LE_GAME_ERR_RECRUIT_A_FRIEND_FAILED = 952\n CompactRaidFrameManagerDisplayFrameHiddenModeToggleTopRight = CompactRaidFrameManagerDisplayFrameHiddenModeToggleTopRight {\n }\n LE_GAME_ERR_ONLY_ONE_QUIVER = 32\n SpellButton6Cooldown = SpellButton6Cooldown {\n }\n AdiBagsItemButton4IconQuestTexture = AdiBagsItemButton4IconQuestTexture {\n }\n LOSS_OF_CONTROL_DISPLAY_FEAR = \"Feared\"\n Graphics_QualityText = Graphics_QualityText {\n }\n VOICEMACRO_4_Sc_1_FEMALE = \"Help me attack!\"\n StanceButton4FlyoutArrow = StanceButton4FlyoutArrow {\n }\n MultiBarRightButton7Shine9 = MultiBarRightButton7Shine9 {\n }\n BankFrameItem17SearchOverlay = BankFrameItem17SearchOverlay {\n }\n DMG_LCD = \"DMG\"\n VideoOptionsPanel_Cancel = <function> defined @Interface\\SharedXML\\VideoOptionsPanels.lua:315\n HubPanelProfileDefaultFriendlyNameColorMode = HubPanelProfileDefaultFriendlyNameColorMode {\n }\n Is64BitClient = <function> defined =[C]:-1\n SecureCmdItemParse = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1111\n SLASH_STOPATTACK1 = \"/stopattack\"\n SortQuestWatches = <function> defined =[C]:-1\n ContainerFrame4Item16Cooldown = ContainerFrame4Item16Cooldown {\n }\n MINIMAP_TRACKING_TRAINER_CLASS = \"Class Trainer\"\n SLASH_DISMOUNT2 = \"/dismount\"\n DUNGEON_FLOOR_DRAGONBLIGHTCHROMIESCENARIO2 = \"Andorhal\"\n PlayerFrame_UpdateReadyCheck = <function> defined @Interface\\FrameXML\\PlayerFrame.lua:345\n EMOTE69_CMD1 = \"/nosepick\"\n WowTokenRedemptionFrameBg = WowTokenRedemptionFrameBg {\n }\n SHIELD_BLOCK_TEMPLATE = \"%d Block\"\n AutoFollowStatus = AutoFollowStatus {\n }\n GuildControlPopupFrame = GuildControlPopupFrame {\n }\n ARENA_CASUAL = \"Skirmish\"\n SendStationeryBackgroundRight = SendStationeryBackgroundRight {\n }\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SortBags.lua:606: in main chunk",
			["session"] = 1496,
			["counter"] = 1,
		}, -- [85]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\core\\Hooks.lua:77: Usage: GetContainerNumSlots(index)",
			["time"] = "2020/07/31 11:24:35",
			["locals"] = "(*temporary) = nil\n",
			["stack"] = "[C]: ?\nInterface\\AddOns\\AdiBags\\core\\Hooks.lua:77: in function `GetContainerFrame'\nInterface\\AddOns\\AdiBags\\core\\Hooks.lua:164: in function <Interface\\AddOns\\AdiBags\\core\\Hooks.lua:159>\n(tail call): ?\n[string \"ToggleBag()\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1496,
			["counter"] = 1,
		}, -- [86]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SortBags.lua:606: attempt to index global 'ToggleBag' (a function value)",
			["time"] = "2020/07/31 11:24:55",
			["locals"] = "_G = <table> {\n UpdateOnBarHighlightMarksBySpell = <function> defined @Interface\\FrameXML\\ActionButton.lua:70\n ERR_OUT_OF_CHI = \"Not enough chi\"\n DH_HAVOC_CORE_ABILITY_2 = \"Strong melee attack that consumes Fury. If it critical strikes, some Fury is refunded.\"\n MerchantItem9ItemButtonStock = MerchantItem9ItemButtonStock {\n }\n GetTrainerServiceTypeFilter = <function> defined =[C]:-1\n UNIT_NAMES_COMBATLOG_TOOLTIP = \"Color unit names.\"\n SetTrainerServiceTypeFilter = <function> defined =[C]:-1\n LE_GAME_ERR_CHAT_RAID_RESTRICTED_TRIAL = 742\n SPELL_FAILED_CUSTOM_ERROR_71 = \"This partygoer wants to dance with you.\"\n LE_GAME_ERR_PET_SPELL_TARGETS_DEAD = 399\n ERROR_CLUB_TICKET_COUNT_AT_MAX_COMMUNITY = \"Can't create any more invite links for this group.\"\n RecruitAFriendFrame = RecruitAFriendFrame {\n }\n CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdownButtonNormalTexture = CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdownButtonNormalTexture {\n }\n ERR_TRADE_EQUIPPED_BAG = \"You can't trade equipped bags.\"\n PVP_RANK_6_1 = \"Corporal\"\n MultiBarLeftButton7 = MultiBarLeftButton7 {\n }\n InterfaceOptionsNamesPanelUnitNameplatesShowAll = InterfaceOptionsNamesPanelUnitNameplatesShowAll {\n }\n VideoOptionsFrameDefaults = VideoOptionsFrameDefaults {\n }\n MerchantItem2AltCurrencyFrameItem1Text = MerchantItem2AltCurrencyFrameItem1Text {\n }\n DetailsWindowOptionsBarTextEditorEntryNumberLines = DetailsWindowOptionsBarTextEditorEntryNumberLines {\n }\n OPTION_TOOLTIP_ACTION_BUTTON_USE_KEY_DOWN = \"Action button keybinds will respond on key down, rather than on key up.\"\n BINDING_NAME_NAMEPLATES = \"Show Enemy Name Plates\"\n INSTANCE_UNAVAILABLE_OTHER_TEMPORARILY_DISABLED = \"%s cannot enter. This instance is temporarily disabled.\"\n MultiBarBottomRightButton8Shine5 = MultiBarBottomRightButton8Shine5 {\n }\n IsReferAFriendLinked = <function> defined =[C]:-1\n MAIL_LETTER_TOOLTIP = \"Click to make a permanent\ncopy of this letter.\"\n UnitFrameManaBar_UnregisterDefaultEvents = <function> defined @Interface\\FrameXML\\UnitFrame.lua:602\n ERR_NOAMMO_S = \"%s\"\n CHAT_CONFIG_OTHER_COMBAT = <table> {\n }\n FCFDockOverflowButton_OnClick = <function> defined @Interface\\FrameXML\\FloatingChatFrame.lua:2373\n BOOST2_WARRIOR_COLOSSUSSMASH = \"Use |cFFFFFFFFColossus Smash|r.\n\n|cFFFFFFFFColossus Smash|r increases your damage.\"\n BN_UNABLE_TO_RESOLVE_NAME = \"Unable to whisper '%s'. Blizzard services may be unavailable.\"\n LE_GAME_ERR_RECRUIT_A_FRIEND_FAILED = 952\n CompactRaidFrameManagerDisplayFrameHiddenModeToggleTopRight = CompactRaidFrameManagerDisplayFrameHiddenModeToggleTopRight {\n }\n LE_GAME_ERR_ONLY_ONE_QUIVER = 32\n SpellButton6Cooldown = SpellButton6Cooldown {\n }\n AdiBagsItemButton4IconQuestTexture = AdiBagsItemButton4IconQuestTexture {\n }\n LOSS_OF_CONTROL_DISPLAY_FEAR = \"Feared\"\n Graphics_QualityText = Graphics_QualityText {\n }\n VOICEMACRO_4_Sc_1_FEMALE = \"Help me attack!\"\n StanceButton4FlyoutArrow = StanceButton4FlyoutArrow {\n }\n MultiBarRightButton7Shine9 = MultiBarRightButton7Shine9 {\n }\n BankFrameItem17SearchOverlay = BankFrameItem17SearchOverlay {\n }\n DMG_LCD = \"DMG\"\n VideoOptionsPanel_Cancel = <function> defined @Interface\\SharedXML\\VideoOptionsPanels.lua:315\n HubPanelProfileDefaultFriendlyNameColorMode = HubPanelProfileDefaultFriendlyNameColorMode {\n }\n Is64BitClient = <function> defined =[C]:-1\n SecureCmdItemParse = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1111\n SLASH_STOPATTACK1 = \"/stopattack\"\n SortQuestWatches = <function> defined =[C]:-1\n ContainerFrame4Item16Cooldown = ContainerFrame4Item16Cooldown {\n }\n MINIMAP_TRACKING_TRAINER_CLASS = \"Class Trainer\"\n SLASH_DISMOUNT2 = \"/dismount\"\n DUNGEON_FLOOR_DRAGONBLIGHTCHROMIESCENARIO2 = \"Andorhal\"\n PlayerFrame_UpdateReadyCheck = <function> defined @Interface\\FrameXML\\PlayerFrame.lua:345\n EMOTE69_CMD1 = \"/nosepick\"\n WowTokenRedemptionFrameBg = WowTokenRedemptionFrameBg {\n }\n SHIELD_BLOCK_TEMPLATE = \"%d Block\"\n AutoFollowStatus = AutoFollowStatus {\n }\n GuildControlPopupFrame = GuildControlPopupFrame {\n }\n ARENA_CASUAL = \"Skirmish\"\n SendStationeryBackgroundRight = SendStationeryBackgroundRight {\n }\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SortBags.lua:606: in main chunk",
			["session"] = 1497,
			["counter"] = 1,
		}, -- [87]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SortBags.lua:606: attempt to index global 'OpenAllBags' (a function value)",
			["time"] = "2020/07/31 11:27:57",
			["locals"] = "_G = <table> {\n UpdateOnBarHighlightMarksBySpell = <function> defined @Interface\\FrameXML\\ActionButton.lua:70\n ERR_OUT_OF_CHI = \"Not enough chi\"\n DH_HAVOC_CORE_ABILITY_2 = \"Strong melee attack that consumes Fury. If it critical strikes, some Fury is refunded.\"\n MerchantItem9ItemButtonStock = MerchantItem9ItemButtonStock {\n }\n GetTrainerServiceTypeFilter = <function> defined =[C]:-1\n UNIT_NAMES_COMBATLOG_TOOLTIP = \"Color unit names.\"\n SetTrainerServiceTypeFilter = <function> defined =[C]:-1\n LE_GAME_ERR_CHAT_RAID_RESTRICTED_TRIAL = 742\n SPELL_FAILED_CUSTOM_ERROR_71 = \"This partygoer wants to dance with you.\"\n LE_GAME_ERR_PET_SPELL_TARGETS_DEAD = 399\n ERROR_CLUB_TICKET_COUNT_AT_MAX_COMMUNITY = \"Can't create any more invite links for this group.\"\n RecruitAFriendFrame = RecruitAFriendFrame {\n }\n CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdownButtonNormalTexture = CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdownButtonNormalTexture {\n }\n ERR_TRADE_EQUIPPED_BAG = \"You can't trade equipped bags.\"\n PVP_RANK_6_1 = \"Corporal\"\n MultiBarLeftButton7 = MultiBarLeftButton7 {\n }\n InterfaceOptionsNamesPanelUnitNameplatesShowAll = InterfaceOptionsNamesPanelUnitNameplatesShowAll {\n }\n VideoOptionsFrameDefaults = VideoOptionsFrameDefaults {\n }\n MerchantItem2AltCurrencyFrameItem1Text = MerchantItem2AltCurrencyFrameItem1Text {\n }\n DetailsWindowOptionsBarTextEditorEntryNumberLines = DetailsWindowOptionsBarTextEditorEntryNumberLines {\n }\n OPTION_TOOLTIP_ACTION_BUTTON_USE_KEY_DOWN = \"Action button keybinds will respond on key down, rather than on key up.\"\n BINDING_NAME_NAMEPLATES = \"Show Enemy Name Plates\"\n INSTANCE_UNAVAILABLE_OTHER_TEMPORARILY_DISABLED = \"%s cannot enter. This instance is temporarily disabled.\"\n MultiBarBottomRightButton8Shine5 = MultiBarBottomRightButton8Shine5 {\n }\n IsReferAFriendLinked = <function> defined =[C]:-1\n MAIL_LETTER_TOOLTIP = \"Click to make a permanent\ncopy of this letter.\"\n UnitFrameManaBar_UnregisterDefaultEvents = <function> defined @Interface\\FrameXML\\UnitFrame.lua:602\n ERR_NOAMMO_S = \"%s\"\n CHAT_CONFIG_OTHER_COMBAT = <table> {\n }\n FCFDockOverflowButton_OnClick = <function> defined @Interface\\FrameXML\\FloatingChatFrame.lua:2373\n BOOST2_WARRIOR_COLOSSUSSMASH = \"Use |cFFFFFFFFColossus Smash|r.\n\n|cFFFFFFFFColossus Smash|r increases your damage.\"\n BN_UNABLE_TO_RESOLVE_NAME = \"Unable to whisper '%s'. Blizzard services may be unavailable.\"\n LE_GAME_ERR_RECRUIT_A_FRIEND_FAILED = 952\n CompactRaidFrameManagerDisplayFrameHiddenModeToggleTopRight = CompactRaidFrameManagerDisplayFrameHiddenModeToggleTopRight {\n }\n LE_GAME_ERR_ONLY_ONE_QUIVER = 32\n SpellButton6Cooldown = SpellButton6Cooldown {\n }\n AdiBagsItemButton4IconQuestTexture = AdiBagsItemButton4IconQuestTexture {\n }\n LOSS_OF_CONTROL_DISPLAY_FEAR = \"Feared\"\n Graphics_QualityText = Graphics_QualityText {\n }\n VOICEMACRO_4_Sc_1_FEMALE = \"Help me attack!\"\n StanceButton4FlyoutArrow = StanceButton4FlyoutArrow {\n }\n MultiBarRightButton7Shine9 = MultiBarRightButton7Shine9 {\n }\n BankFrameItem17SearchOverlay = BankFrameItem17SearchOverlay {\n }\n DMG_LCD = \"DMG\"\n VideoOptionsPanel_Cancel = <function> defined @Interface\\SharedXML\\VideoOptionsPanels.lua:315\n HubPanelProfileDefaultFriendlyNameColorMode = HubPanelProfileDefaultFriendlyNameColorMode {\n }\n Is64BitClient = <function> defined =[C]:-1\n SecureCmdItemParse = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1111\n SLASH_STOPATTACK1 = \"/stopattack\"\n SortQuestWatches = <function> defined =[C]:-1\n ContainerFrame4Item16Cooldown = ContainerFrame4Item16Cooldown {\n }\n MINIMAP_TRACKING_TRAINER_CLASS = \"Class Trainer\"\n SLASH_DISMOUNT2 = \"/dismount\"\n DUNGEON_FLOOR_DRAGONBLIGHTCHROMIESCENARIO2 = \"Andorhal\"\n PlayerFrame_UpdateReadyCheck = <function> defined @Interface\\FrameXML\\PlayerFrame.lua:345\n EMOTE69_CMD1 = \"/nosepick\"\n WowTokenRedemptionFrameBg = WowTokenRedemptionFrameBg {\n }\n SHIELD_BLOCK_TEMPLATE = \"%d Block\"\n AutoFollowStatus = AutoFollowStatus {\n }\n GuildControlPopupFrame = GuildControlPopupFrame {\n }\n ARENA_CASUAL = \"Skirmish\"\n SendStationeryBackgroundRight = SendStationeryBackgroundRight {\n }\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SortBags.lua:606: in main chunk",
			["session"] = 1498,
			["counter"] = 1,
		}, -- [88]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SortBags.lua:617: attempt to concatenate local 'event' (a table value)",
			["time"] = "2020/07/31 11:28:42",
			["locals"] = "event = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = \"frame event: \"\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = \"attempt to concatenate local 'event' (a table value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SortBags.lua:617: in function <Interface\\AddOns\\xVermin\\SortBags.lua:616>",
			["session"] = 1499,
			["counter"] = 13,
		}, -- [89]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SortBags.lua:583: attempt to perform arithmetic on local 'quality' (a nil value)",
			["time"] = "2020/07/31 11:32:24",
			["locals"] = "container = 0\nposition = 2\nlink = \"|cffffffff|Hitem:11138::::::::5:::::::|h[]|h|r\"\n_ = 13\n_ = 25\nitemID = 11138\nenchantID = \"\"\nsuffixID = \"\"\nuniqueID = \"\"\n_ = nil\n_ = nil\nquality = nil\n_ = nil\n_ = nil\n_ = nil\n_ = nil\nstack = nil\nslot = nil\n_ = nil\nsellPrice = nil\nclassId = nil\nsubClassId = nil\ncharges = 1\nusable = nil\nsoulbound = nil\nquest = nil\nconjured = nil\nsortKey = <table> {\n 1 = 11\n}\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = <table> {\n 1 = 11\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to perform arithmetic on local 'quality' (a nil value)\"\nMOUNTS = <table> {\n 19030 = true\n 18778 = true\n 21324 = true\n 18786 = true\n 18788 = true\n 18790 = true\n 18794 = true\n 18796 = true\n 18798 = true\n 5655 = true\n 5656 = true\n 8586 = true\n 8588 = true\n 8591 = true\n 8592 = true\n 8595 = true\n 5665 = true\n 19872 = true\n 5668 = true\n 1132 = true\n 18241 = true\n 18243 = true\n 18245 = true\n 5864 = true\n 19902 = true\n 12302 = true\n 12303 = true\n 18767 = true\n 13322 = true\n 18773 = true\n 18902 = true\n 18777 = true\n 13327 = true\n 8629 = true\n 13329 = true\n 18785 = true\n 18787 = true\n 18789 = true\n 5873 = true\n 18793 = true\n 18795 = true\n 18797 = true\n 2414 = true\n 13086 = true\n 12326 = true\n 12330 = true\n 21176 = true\n 21323 = true\n 21321 = true\n 21218 = true\n 13335 = true\n 13328 = true\n 18791 = true\n 13334 = true\n 13333 = true\n 13332 = true\n 13331 = true\n 13317 = true\n 5872 = true\n 12351 = true\n 8631 = true\n 12353 = true\n 12354 = true\n 15292 = true\n 15277 = true\n 15293 = true\n 8632 = true\n 18247 = true\n 18242 = true\n 18244 = true\n 18246 = true\n 18248 = true\n 13326 = true\n 8563 = true\n 13321 = true\n 8628 = true\n 18766 = true\n 15290 = true\n 2411 = true\n 18772 = true\n 18774 = true\n 18776 = true\n}\nSPECIAL = <table> {\n 5462 = true\n 17117 = true\n 11511 = true\n 13289 = true\n 13347 = true\n 17696 = true\n}\nKEYS = <table> {\n 13544 = true\n 20402 = true\n 9240 = true\n 12324 = true\n 12384 = true\n 17191 = true\n 16309 = true\n}\nTOOLS = <table> {\n 6218 = true\n 15846 = true\n 7005 = true\n 19727 = true\n 6339 = true\n 6219 = true\n 5956 = true\n 11145 = true\n 11130 = true\n 16207 = true\n 6256 = true\n 6367 = true\n 12709 = true\n 9149 = true\n 6365 = true\n 10498 = true\n 2901 = true\n}\nENCHANTING_MATERIALS = <table> {\n 10940 = true\n 11134 = true\n 16203 = true\n 11135 = true\n 11174 = true\n 16204 = true\n 11082 = true\n 11137 = true\n 11083 = true\n 10998 = true\n 20725 = true\n 11138 = true\n 11084 = true\n 11139 = true\n 11178 = true\n 10938 = true\n 14344 = true\n 14343 = true\n 11177 = true\n 10939 = true\n 10978 = true\n 11175 = true\n 16202 = true\n 11176 = true\n}\nHERBS = <table> {\n 13467 = true\n 13465 = true\n 13466 = true\n 3369 = true\n 13468 = true\n 13464 = true\n 3355 = true\n 2447 = true\n 2449 = true\n 8153 = true\n 2453 = true\n 3819 = true\n 3356 = true\n 3358 = true\n 8836 = true\n 13463 = true\n 3821 = true\n 765 = true\n 8839 = true\n 8845 = true\n 8831 = true\n 4625 = true\n 8838 = true\n 8846 = true\n 2450 = true\n 2452 = true\n 3818 = true\n 3820 = true\n 3357 = true\n 785 = true\n}\nitemStacks = <table> {\n 6948::::1:1 = 1\n}\nitemSortKeys = <table> {\n 6948::::1:1 = <table> {\n }\n}\nCLASSES = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n 4 = <table> {\n }\n 5 = <table> {\n }\n}\nitemClasses = <table> {\n}\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SortBags.lua:583: in function `Item'\nInterface\\AddOns\\xVermin\\SortBags.lua:446: in function `Initialize'\nInterface\\AddOns\\xVermin\\SortBags.lua:237: in function `Start'\nInterface\\AddOns\\xVermin\\SortBags.lua:15: in function `SortBags'\nInterface\\AddOns\\xVermin\\SortBags.lua:617: in function <Interface\\AddOns\\xVermin\\SortBags.lua:616>",
			["session"] = 1502,
			["counter"] = 5,
		}, -- [90]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:69: Usage: TargetFrameDebuff1Count:SetPoint(\"point\" [, region or nil] [, \"relativePoint\"] [, offsetX, offsetY])",
			["time"] = "2020/07/31 14:58:11",
			["locals"] = "InCombatSkipped",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\xVermin\\SkinBuffs.lua:69: in function <Interface\\AddOns\\xVermin\\SkinBuffs.lua:15>\n[C]: ?\n[C]: in function `TargetFrame_UpdateAuras'\nInterface\\FrameXML\\TargetFrame.lua:197: in function <Interface\\FrameXML\\TargetFrame.lua:142>",
			["session"] = 1520,
			["counter"] = 202,
		}, -- [91]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SortBags.lua:568: attempt to compare number with nil",
			["time"] = "2020/07/31 16:58:20",
			["locals"] = "container = 1\nposition = 3\nlink = \"|cffffffff|Hitem:3030::::::::26:::::::|h[]|h|r\"\n_ = 13\n_ = 24\nitemID = 3030\nenchantID = \"\"\nsuffixID = \"\"\nuniqueID = \"\"\n_ = nil\n_ = nil\nquality = nil\n_ = nil\n_ = nil\n_ = nil\n_ = nil\nstack = nil\nslot = nil\n_ = nil\nsellPrice = nil\nclassId = nil\nsubClassId = nil\ncharges = 1\nusable = nil\nsoulbound = nil\nquest = nil\nconjured = nil\nsortKey = <table> {\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = 1\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to compare number with nil\"\nMOUNTS = <table> {\n 19030 = true\n 18778 = true\n 21324 = true\n 18786 = true\n 18788 = true\n 18790 = true\n 18794 = true\n 18796 = true\n 18798 = true\n 5655 = true\n 5656 = true\n 8586 = true\n 8588 = true\n 8591 = true\n 8592 = true\n 8595 = true\n 5665 = true\n 19872 = true\n 5668 = true\n 1132 = true\n 18241 = true\n 18243 = true\n 18245 = true\n 5864 = true\n 19902 = true\n 12302 = true\n 12303 = true\n 18767 = true\n 13322 = true\n 18773 = true\n 18902 = true\n 18777 = true\n 13327 = true\n 8629 = true\n 13329 = true\n 18785 = true\n 18787 = true\n 18789 = true\n 5873 = true\n 18793 = true\n 18795 = true\n 18797 = true\n 2414 = true\n 13086 = true\n 12326 = true\n 12330 = true\n 21176 = true\n 21323 = true\n 21321 = true\n 21218 = true\n 13335 = true\n 13328 = true\n 18791 = true\n 13334 = true\n 13333 = true\n 13332 = true\n 13331 = true\n 13317 = true\n 5872 = true\n 12351 = true\n 8631 = true\n 12353 = true\n 12354 = true\n 15292 = true\n 15277 = true\n 15293 = true\n 8632 = true\n 18247 = true\n 18242 = true\n 18244 = true\n 18246 = true\n 18248 = true\n 13326 = true\n 8563 = true\n 13321 = true\n 8628 = true\n 18766 = true\n 15290 = true\n 2411 = true\n 18772 = true\n 18774 = true\n 18776 = true\n}\nSPECIAL = <table> {\n 5462 = true\n 17117 = true\n 11511 = true\n 13289 = true\n 13347 = true\n 17696 = true\n}\nKEYS = <table> {\n 13544 = true\n 20402 = true\n 9240 = true\n 12324 = true\n 12384 = true\n 17191 = true\n 16309 = true\n}\nTOOLS = <table> {\n 6218 = true\n 15846 = true\n 7005 = true\n 19727 = true\n 6339 = true\n 6219 = true\n 5956 = true\n 11145 = true\n 11130 = true\n 16207 = true\n 6256 = true\n 6367 = true\n 12709 = true\n 9149 = true\n 6365 = true\n 10498 = true\n 2901 = true\n}\nENCHANTING_MATERIALS = <table> {\n 10940 = true\n 11134 = true\n 16203 = true\n 11135 = true\n 11174 = true\n 16204 = true\n 11082 = true\n 11137 = true\n 11083 = true\n 10998 = true\n 20725 = true\n 11138 = true\n 11084 = true\n 11139 = true\n 11178 = true\n 10938 = true\n 14344 = true\n 14343 = true\n 11177 = true\n 10939 = true\n 10978 = true\n 11175 = true\n 16202 = true\n 11176 = true\n}\nHERBS = <table> {\n 13467 = true\n 13465 = true\n 13466 = true\n 3369 = true\n 13468 = true\n 13464 = true\n 3355 = true\n 2447 = true\n 2449 = true\n 8153 = true\n 2453 = true\n 3819 = true\n 3356 = true\n 3358 = true\n 8836 = true\n 13463 = true\n 3821 = true\n 765 = true\n 8839 = true\n 8845 = true\n 8831 = true\n 4625 = true\n 8838 = true\n 8846 = true\n 2450 = true\n 2452 = true\n 3818 = true\n 3820 = true\n 3357 = true\n 785 = true\n}\nitemStacks = <table> {\n}\nitemSortKeys = <table> {\n}\nCLASSES = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n 4 = <table> {\n }\n 5 = <table> {\n }\n}\nitemClasses = <table> {\n}\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SortBags.lua:568: in function `Item'\nInterface\\AddOns\\xVermin\\SortBags.lua:446: in function `Initialize'\nInterface\\AddOns\\xVermin\\SortBags.lua:237: in function `Start'\nInterface\\AddOns\\xVermin\\SortBags.lua:15: in function `SortBags'\nInterface\\AddOns\\xVermin\\SortBags.lua:619: in function <Interface\\AddOns\\xVermin\\SortBags.lua:618>",
			["session"] = 1529,
			["counter"] = 7,
		}, -- [92]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SortBags.lua:459: attempt to perform arithmetic on field '?' (a nil value)",
			["time"] = "2020/07/31 17:21:16",
			["locals"] = "free = <table> {\n}\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 3030::::1:0 = 1282\n}\n(for control) = \"3030::::1:0\"\nitem = \"3030::::1:0\"\ncount = 1282\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = nil\n(*temporary) = 1\n(*temporary) = 0\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to perform arithmetic on field '?' (a nil value)\"\nmodel = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n 4 = <table> {\n }\n 5 = <table> {\n }\n 6 = <table> {\n }\n 7 = <table> {\n }\n 8 = <table> {\n }\n 9 = <table> {\n }\n 10 = <table> {\n }\n 11 = <table> {\n }\n 12 = <table> {\n }\n 13 = <table> {\n }\n 14 = <table> {\n }\n 15 = <table> {\n }\n 16 = <table> {\n }\n 17 = <table> {\n }\n 18 = <table> {\n }\n 19 = <table> {\n }\n 20 = <table> {\n }\n 21 = <table> {\n }\n 22 = <table> {\n }\n 23 = <table> {\n }\n 24 = <table> {\n }\n 25 = <table> {\n }\n 26 = <table> {\n }\n 27 = <table> {\n }\n 28 = <table> {\n }\n 29 = <table> {\n }\n 30 = <table> {\n }\n}\ncounts = <table> {\n 3030::::1:0 = 1282\n}\nitemStacks = <table> {\n}\nitemClasses = <table> {\n 3030::::1:0 = 1\n}\nitemSortKeys = <table> {\n 3030::::1:0 = <table> {\n }\n}\nCONTAINERS = <table> {\n 1 = 0\n 2 = 1\n 3 = 2\n 4 = 3\n 5 = 4\n}\ninsert = <function> defined @Interface\\AddOns\\xVermin\\SortBags.lua:416\nassign = <function> defined @Interface\\AddOns\\xVermin\\SortBags.lua:424\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SortBags.lua:459: in function `Initialize'\nInterface\\AddOns\\xVermin\\SortBags.lua:237: in function `Start'\nInterface\\AddOns\\xVermin\\SortBags.lua:15: in function `SortBags'\nInterface\\AddOns\\xVermin\\SortBags.lua:619: in function <Interface\\AddOns\\xVermin\\SortBags.lua:618>",
			["session"] = 1531,
			["counter"] = 8,
		}, -- [93]
		{
			["message"] = "[string \"print(numberOfFreeSlots, BagType = GetContainerNumFreeSlots(1))\"]:1: ')' expected near '='",
			["time"] = "2020/07/31 18:05:49",
			["locals"] = "(*temporary) = \"print(numberOfFreeSlots, BagType = GetContainerNumFreeSlots(1))\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1532,
			["counter"] = 1,
		}, -- [94]
		{
			["message"] = "Interface\\AddOns\\xVermin\\AutoSellJunk.lua:25: attempt to index global 'cpxf' (a nil value)",
			["time"] = "2020/07/31 18:08:49",
			["locals"] = "AutoSellJunk = <function> defined @Interface\\AddOns\\xVermin\\AutoSellJunk.lua:1\nf = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = CustomContainer_CombatFreeBagSpace {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = \"CENTER\"\n(*temporary) = 0\n(*temporary) = 2\n(*temporary) = \"attempt to index global 'cpxf' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\AutoSellJunk.lua:25: in main chunk",
			["session"] = 1533,
			["counter"] = 1,
		}, -- [95]
		{
			["message"] = "Interface\\AddOns\\xVermin\\AutoSellJunk.lua:38: attempt to perform arithmetic on local 'fs' (a nil value)",
			["time"] = "2020/07/31 18:12:26",
			["locals"] = "AutoSellJunk = <function> defined @Interface\\AddOns\\xVermin\\AutoSellJunk.lua:1\nf = <unnamed> {\n 0 = <userdata>\n}\nnumberOfFreeSlots = 2\nBagType = 0\nfs = nil\n(for index) = 0\n(for limit) = 4\n(for step) = 1\nbag = 0\n(*temporary) = 2\n(*temporary) = 0\n(*temporary) = 2\n(*temporary) = 0\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to perform arithmetic on local 'fs' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\AutoSellJunk.lua:38: in main chunk",
			["session"] = 1536,
			["counter"] = 1,
		}, -- [96]
		{
			["message"] = "Interface\\AddOns\\xVermin\\AutoSellJunk.lua:39: attempt to perform arithmetic on upvalue 'fs' (a nil value)",
			["time"] = "2020/07/31 18:19:21",
			["locals"] = "(for index) = 0\n(for limit) = 4\n(for step) = 1\nbag = 0\n(*temporary) = nil\n(*temporary) = 2\n(*temporary) = 2\n(*temporary) = 0\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to perform arithmetic on upvalue 'fs' (a nil value)\"\nnumberOfFreeSlots = 2\nBagType = 0\nfs = nil\n",
			["stack"] = "Interface\\AddOns\\xVermin\\AutoSellJunk.lua:39: in function <Interface\\AddOns\\xVermin\\AutoSellJunk.lua:35>\nInterface\\AddOns\\xVermin\\AutoSellJunk.lua:50: in function <Interface\\AddOns\\xVermin\\AutoSellJunk.lua:49>",
			["session"] = 1542,
			["counter"] = 7,
		}, -- [97]
		{
			["message"] = "...terface\\AddOns\\TrackEverything\\Core\\Service\\Icon.lua:59: attempt to index field 'minimapButton' (a nil value)",
			["time"] = "2020/08/01 09:15:46",
			["stack"] = "...terface\\AddOns\\TrackEverything\\Core\\Service\\Icon.lua:59: in function <...terface\\AddOns\\TrackEverything\\Core\\Service\\Icon.lua:29>\n[C]: ?\n...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:70: in function <...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:65>\n...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:498: in function `InitializeAddon'\n...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:613: in function <...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:605>",
			["session"] = 1562,
			["counter"] = 1,
		}, -- [98]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Unit.lua:67: attempt to compare number with string",
			["time"] = "2020/08/01 10:03:12",
			["locals"] = "(*temporary) = \"0\"\n(*temporary) = \"%d\"\n(*temporary) = 0\n(*temporary) = \"0\"\n(*temporary) = 0\n(*temporary) = 9.099999\n(*temporary) = \"attempt to compare number with string\"\nspeed = \"0\"\nus = CustomContainer_CombatUnitSpeed {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Unit.lua:67: in function <Interface\\AddOns\\xVermin\\Unit.lua:65>\n[C]: ?",
			["session"] = 1572,
			["counter"] = 227,
		}, -- [99]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:285: Usage: GetContainerItemID(index, slot)",
			["time"] = "2020/08/01 11:38:52",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n",
			["stack"] = "[C]: ?\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:285: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:255: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:243>\n[C]: in function `Show'\n[string \"AdiBagsItemButton37:Show()\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1582,
			["counter"] = 1,
		}, -- [100]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/AdiBags.lua:38: attempt to index local 'AdiBagsContainer' (a nil value)",
			["time"] = "2020/08/01 11:41:42",
			["locals"] = "AdiBagsContainer = nil\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = nil\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\Addons/AdiBags.lua:16\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\Addons/AdiBags.lua:16\n(*temporary) = nil\n(*temporary) = 4\n(*temporary) = \"attempt to index local 'AdiBagsContainer' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Addons/AdiBags.lua:38: in main chunk",
			["session"] = 1585,
			["counter"] = 2,
		}, -- [101]
		{
			["message"] = "[string \"Backpack:Show()\"]:1: attempt to index global 'Backpack' (a nil value)",
			["time"] = "2020/08/01 11:44:29",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'Backpack' (a nil value)\"\n",
			["stack"] = "[string \"Backpack:Show()\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1585,
			["counter"] = 1,
		}, -- [102]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:236: attempt to index local 'a' (a nil value)",
			["time"] = "2020/08/01 14:07:21",
			["locals"] = "a = nil\nb = <table> {\n conj = false\n name = \"Dwarven Mild\"\n lvl = 15\n id = 422\n hp = 552\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'a' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\BestFood.lua:236: in function <Interface\\AddOns\\xVermin\\BestFood.lua:235>\n[C]: in function `sort'\nInterface\\AddOns\\xVermin\\BestFood.lua:160: in function `Sorted'\nInterface\\AddOns\\xVermin\\BestFood.lua:107: in function `UpdateMacros'\nInterface\\AddOns\\xVermin\\BestFood.lua:50: in function <Interface\\AddOns\\xVermin\\BestFood.lua:45>",
			["session"] = 1589,
			["counter"] = 10,
		}, -- [103]
		{
			["message"] = "Error loading Interface\\AddOns\\xVermin\\Inspect-Inspect.lua",
			["session"] = 1605,
			["time"] = "2020/08/02 10:06:15",
			["counter"] = 3,
		}, -- [104]
		{
			["message"] = "Interface\\AddOns\\xVermin\\PlayerTargetSetMark.lua:6: attempt to call global 'SetMark' (a nil value)",
			["time"] = "2020/08/02 10:06:24",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"attempt to call global 'SetMark' (a nil value)\"\nmark = true\n",
			["stack"] = "Interface\\AddOns\\xVermin\\PlayerTargetSetMark.lua:6: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1605,
			["counter"] = 1,
		}, -- [105]
		{
			["message"] = "Interface\\AddOns\\xVermin\\PlayerTargetSetMark.lua:6: attempt to call global 'ClearMark' (a nil value)",
			["time"] = "2020/08/02 10:08:28",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"attempt to call global 'ClearMark' (a nil value)\"\nmark = true\n",
			["stack"] = "Interface\\AddOns\\xVermin\\PlayerTargetSetMark.lua:6: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1607,
			["counter"] = 1,
		}, -- [106]
		{
			["message"] = "...Details\\Libs\\DF\\Details-Framework-Classic\\slider.lua:847: Details! Framework: OnSwitch() -NONAME- error: ...nterface\\AddOns\\Details\\classes\\classe_instancia.lua:937: DetailsBaseFrame1:SetPoint(): DetailsBaseFrame2 is dependent on this",
			["time"] = "2020/08/02 10:26:25",
			["locals"] = "(*temporary) = \"Details! Framework: OnSwitch() -NONAME- error: ...nterface\\AddOns\\Details\\classes\\classe_instancia.lua:937: DetailsBaseFrame1:SetPoint(): DetailsBaseFrame2 is dependent on this\"\n",
			["stack"] = "[C]: in function `error'\n...Details\\Libs\\DF\\Details-Framework-Classic\\slider.lua:847: in function <...Details\\Libs\\DF\\Details-Framework-Classic\\slider.lua:794>",
			["session"] = 1609,
			["counter"] = 6,
		}, -- [107]
		{
			["message"] = "...nterface\\AddOns\\Details\\classes\\classe_instancia.lua:937: DetailsBaseFrame1:SetPoint(): DetailsBaseFrame2 is dependent on this",
			["time"] = "2020/08/02 10:33:40",
			["locals"] = "(*temporary) = DetailsBaseFrame1 {\n 0 = <userdata>\n faded = false\n statusbar = DetailsStatusBar1 {\n }\n resize_esquerda = Details_Resize_Esquerda1 {\n }\n fading_out = false\n instance = <table> {\n }\n hidden = false\n button_down = DetailsScrollDown1 {\n }\n button_up = DetailsScrollUp1 {\n }\n rodape = <table> {\n }\n button_stretch = DetailsButtonStretch1 {\n }\n scroll_middle = <unnamed> {\n }\n barra_esquerda = <unnamed> {\n }\n anti_menu_overlap = Details_WindowFrameAntiMenuOverlap1 {\n }\n barra_fundo = <unnamed> {\n }\n cabecalho = <table> {\n }\n isMoving = false\n _instance = <table> {\n }\n DOWNFrame = DetailsDownFrame1 {\n }\n lock_button = Details_Lock_Button1 {\n }\n fading_in = false\n UPFrame = DetailsUpFrameInstance1 {\n }\n BoxBarrasAltura = 136.640854\n UPFrameLeftPart = DetailsUpFrameLeftPart1 {\n }\n scroll_down = <unnamed> {\n }\n scroll_up = <unnamed> {\n }\n isLocked = true\n wallpaper = <unnamed> {\n }\n fadeInfo = <table> {\n }\n barra_direita = <unnamed> {\n }\n UPFrameConnect = DetailsAntiGap1 {\n }\n alert = DetailsAlertFrame1 {\n }\n resize_direita = Details_Resize_Direita1 {\n }\n}\n(*temporary) = \"TOPRIGHT\"\n(*temporary) = DetailsBaseFrame2 {\n 0 = <userdata>\n faded = false\n statusbar = DetailsStatusBar2 {\n }\n resize_esquerda = Details_Resize_Esquerda2 {\n }\n fading_out = false\n instance = <table> {\n }\n hidden = false\n button_down = DetailsScrollDown2 {\n }\n button_up = DetailsScrollUp2 {\n }\n rodape = <table> {\n }\n button_stretch = DetailsButtonStretch2 {\n }\n scroll_middle = <unnamed> {\n }\n barra_esquerda = <unnamed> {\n }\n anti_menu_overlap = Details_WindowFrameAntiMenuOverlap2 {\n }\n barra_fundo = <unnamed> {\n }\n cabecalho = <table> {\n }\n isMoving = false\n _instance = <table> {\n }\n DOWNFrame = DetailsDownFrame2 {\n }\n lock_button = Details_Lock_Button2 {\n }\n fading_in = false\n UPFrame = DetailsUpFrameInstance2 {\n }\n BoxBarrasAltura = 136.640854\n UPFrameLeftPart = DetailsUpFrameLeftPart2 {\n }\n scroll_down = <unnamed> {\n }\n scroll_up = <unnamed> {\n }\n isLocked = true\n wallpaper = <unnamed> {\n }\n fadeInfo = <table> {\n }\n barra_direita = <unnamed> {\n }\n UPFrameConnect = DetailsAntiGap2 {\n }\n alert = DetailsAlertFrame2 {\n }\n resize_direita = Details_Resize_Direita2 {\n }\n}\n(*temporary) = \"TOPLEFT\"\n",
			["stack"] = "[C]: in function `SetPoint'\n...nterface\\AddOns\\Details\\classes\\classe_instancia.lua:937: in function `BaseFrameSnap'\nInterface\\AddOns\\Details\\gumps\\janela_principal.lua:788: in function <Interface\\AddOns\\Details\\gumps\\janela_principal.lua:773>\nInterface\\AddOns\\Details\\gumps\\janela_principal.lua:1061: in function <Interface\\AddOns\\Details\\gumps\\janela_principal.lua:1048>",
			["session"] = 1609,
			["counter"] = 1,
		}, -- [108]
		{
			["message"] = "Interface\\FrameXML\\FloatingChatFrame.lua:1221: attempt to perform arithmetic on a nil value",
			["time"] = "2020/08/02 11:45:49",
			["locals"] = "chatFrame = ChatFrame2 {\n SetJustifyV = <function> defined =[C]:-1\n RefreshIfNecessary = <function> defined =[C]:-1\n OnPostShow = <function> defined =[C]:-1\n CalculateLineAlphaValueFromTimestamp = <function> defined =[C]:-1\n ScrollUp = <function> defined =[C]:-1\n tellTimer = 1011394.778000\n isDisplayDirty = false\n GetFading = <function> defined =[C]:-1\n IsTextCopyable = <function> defined =[C]:-1\n shouldFadeAfterInactivity = true\n SetIndentedWordWrap = <function> defined =[C]:-1\n GetJustifyV = <function> defined =[C]:-1\n SetFont = <function> defined =[C]:-1\n GetMaxLines = <function> defined =[C]:-1\n GetIndentedWordWrap = <function> defined =[C]:-1\n buttonSide = \"right\"\n GetFont = <function> defined =[C]:-1\n SetMaxLines = <function> defined =[C]:-1\n CalculateSelectingCharacterIndicesForVisibleLine = <function> defined =[C]:-1\n PageUp = <function> defined =[C]:-1\n RefreshDisplay = <function> defined =[C]:-1\n SetFontObject = <function> defined =[C]:-1\n textIsCopyable = false\n SetOnScrollChangedCallback = <function> defined =[C]:-1\n CalculateNumVisibleLines = <function> defined =[C]:-1\n overrideFadeTimestamp = 1016503.376000\n MarkDisplayDirty = <function> defined =[C]:-1\n GetMessageInfo = <function> defined =[C]:-1\n GetOnScrollChangedCallback = <function> defined =[C]:-1\n AtTop = <function> defined =[C]:-1\n GetFontObject = <function> defined =[C]:-1\n fontStringPool = <table> {\n }\n CanEffectivelyFade = <function> defined =[C]:-1\n OnPreSizeChanged = <function> defined =[C]:-1\n OnPostMouseUp = <function> defined =[C]:-1\n GetSpacing = <function> defined =[C]:-1\n OnPreLoad = <function> defined =[C]:-1\n SetSpacing = <function> defined =[C]:-1\n name = \"Combat Log\"\n CalculateLineSpacing = <function> defined =[C]:-1\n AddMessage = <function> defined =[C]:-1\n InitializeFontableFrame = <function> defined =[C]:-1\n GetShadowColor = <function> defined =[C]:-1\n isUninteractable = false\n SetOnTextCopiedCallback = <function> defined =[C]:-1\n mouseOutTime = 0\n originalShow = <function> defined =[C]:-1\n AcquireFontString = <function> defined =[C]:-1\n TransformMessages = <function> defined =[C]:-1\n SetShadowColor = <function> defined =[C]:-1\n buttonFrame = ChatFrame2ButtonFrame {\n }\n HasFontObject = <function> defined =[C]:-1\n GetOnTextCopiedCallback = <function> defined =[C]:-1\n SetFading = <function> defined =[C]:-1\n OnPostHide = <function> defined =[C]:-1\n alternativeDefaultLanguage = \"Orcish\"\n isInitialized = 1\n ScrollByAmount = <function> defined =[C]:-1\n GetInsertMode = <function> defined =[C]:-1\n SetTimeVisible = <function> defined =[C]:-1\n hasOwnFontObject = true\n Clear = <function> defined =[C]:-1\n oldAlpha = 0\n channelList = <table> {\n }\n GetTimeVisible = <function> defined =[C]:-1\n MarkLayoutDirty = <function> defined =[C]:-1\n SetTextCopyable = <function> defined =[C]:-1\n Show = <function> defined @Interface\\FrameXML\\FrameLocks.lua:135\n BackFillMessage = <function> defined =[C]:-1\n UnpackageEntry = <function> defined =[C]:-1\n FontStringContainer = <unnamed> {\n }\n SetShadowOffset = <function> defined =[C]:-1\n messageTypeList = <table> {\n }\n flashTimer = 0\n timeVisibleSecs = 120\n PackageEntry = <function> defined =[C]:-1\n MakeFontObjectCustom = <function> defined =[C]:-1\n SetPoint = <function> defined @Interface\\AddOns\\xVermin\\Chat.lua:193\n fontObject = table: 00000180152F1ED0 {\n }\n SetInsertMode = <function> defined =[C]:-1\n mouseInTime = 0\n originalHide = <function> defined =[C]:-1\n ScrollDown = <function> defined =[C]:-1\n zoneChannelList = <table> {\n }\n SetScrollOffset = <function> defined =[C]:-1\n hasBeenFaded = true\n onDisplayRefreshedCallback = <function> defined =[C]:-1\n insertMode = 2\n ResetSelectingText = <function> defined =[C]:-1\n defaultLanguage = \"Orcish\"\n Hide = <function> defined @Interface\\FrameXML\\FrameLocks.lua:131\n GetTextColor = <function> defined =[C]:-1\n ResetAllFadeTimes = <function> defined =[C]:-1\n CombatLogQuickButtonFrame = CombatLogQuickButtonFrame_Custom {\n }\n scrollOffset = 0\n GatherSelectedText = <function> defined =[C]:-1\n isLayoutDirty = false\n ScrollToBottomButton = <unnamed> {\n }\n GetNumVisibleLines =",
			["stack"] = "Interface\\FrameXML\\FloatingChatFrame.lua:1221: in function `FCF_SavePositionAndDimensions'\nInterface\\FrameXML\\FloatingChatFrame.lua:1286: in function `FCF_StopDragging'\nInterface\\FrameXML\\FloatingChatFrame.lua:1318: in function `FCFTab_OnDragStop'\nInterface\\FrameXML\\FloatingChatFrame.lua:1309: in function <Interface\\FrameXML\\FloatingChatFrame.lua:1291>",
			["session"] = 1609,
			["counter"] = 142,
		}, -- [109]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'ItemRack' tried to call the protected function 'AttemptToSaveBindings()'.",
			["time"] = "2020/07/24 16:00:07",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `AttemptToSaveBindings'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:2062: in function `SetSetBindings'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:544: in function `InitCore'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:281: in function `func'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:982: in function `OnUpdate'\n[string \"*:OnUpdate\"]:1: in function <[string \"*:OnUpdate\"]:1>",
			["session"] = 1610,
			["counter"] = 11,
		}, -- [110]
		{
			["message"] = "[ADDON_ACTION_FORBIDDEN] AddOn 'Details' tried to call the protected function 'CopyToClipboard()'.",
			["time"] = "2020/08/02 16:33:14",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `CopyToClipboard'\n...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua:548: in function `FrameStackTooltip_HandleFrameCommand'\n...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua:518: in function `command'\nInterface\\SharedXML\\KeyCommand.lua:46: in function `Update'\nInterface\\SharedXML\\KeyCommand.lua:110: in function `KeyCommand_Update'\n...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua:727: in function <...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools.lua:726>",
			["session"] = 1618,
			["counter"] = 1,
		}, -- [111]
		{
			["message"] = "[string \"MailItem1Button.16a58d70fd0:Hide()\"]:1: malformed number near '.16a58d70fd0'",
			["time"] = "2020/08/02 16:42:00",
			["locals"] = "(*temporary) = \"MailItem1Button.16a58d70fd0:Hide()\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1619,
			["counter"] = 1,
		}, -- [112]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Frames/MailBoxFrame.lua:58: attempt to call global 'SkinMailBox' (a nil value)",
			["time"] = "2020/08/02 16:44:08",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"attempt to call global 'SkinMailBox' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Frames/MailBoxFrame.lua:58: in function <Interface\\AddOns\\xVermin\\Frames/MailBoxFrame.lua:57>\n[C]: in function `Show'\nInterface\\FrameXML\\UIParent.lua:2087: in function `SetUIPanel'\nInterface\\FrameXML\\UIParent.lua:1932: in function `ShowUIPanel'\nInterface\\FrameXML\\UIParent.lua:1793: in function <Interface\\FrameXML\\UIParent.lua:1789>\n[C]: in function `SetAttribute'\nInterface\\FrameXML\\UIParent.lua:2535: in function `ShowUIPanel'\nInterface\\FrameXML\\MailFrame.lua:52: in function <Interface\\FrameXML\\MailFrame.lua:50>\n[C]: in function `TurnOrActionStop'\n[string \"TURNORACTION\"]:4: in function <[string \"TURNORACTION\"]:1>",
			["session"] = 1620,
			["counter"] = 1,
		}, -- [113]
		{
			["message"] = "[string \"SaveBindings()\"]:1: attempt to call global 'SaveBindings' (a nil value)",
			["time"] = "2020/08/02 19:31:44",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"attempt to call global 'SaveBindings' (a nil value)\"\n",
			["stack"] = "[string \"SaveBindings()\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1630,
			["counter"] = 1,
		}, -- [114]
		{
			["message"] = "[string \"SaveBindings(1)\"]:1: attempt to call global 'SaveBindings' (a nil value)",
			["time"] = "2020/08/02 19:32:12",
			["locals"] = "(*temporary) = nil\n(*temporary) = 1\n(*temporary) = \"attempt to call global 'SaveBindings' (a nil value)\"\n",
			["stack"] = "[string \"SaveBindings(1)\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1630,
			["counter"] = 1,
		}, -- [115]
		{
			["message"] = "[string \"Loadbindings(1)\"]:1: attempt to call global 'Loadbindings' (a nil value)",
			["time"] = "2020/08/02 19:33:47",
			["locals"] = "(*temporary) = nil\n(*temporary) = 1\n(*temporary) = \"attempt to call global 'Loadbindings' (a nil value)\"\n",
			["stack"] = "[string \"Loadbindings(1)\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1630,
			["counter"] = 1,
		}, -- [116]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Bindings.lua:112: attempt to call global 'SaveBindings' (a nil value)",
			["time"] = "2020/08/02 19:55:55",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"attempt to call global 'SaveBindings' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Bindings.lua:112: in function <Interface\\AddOns\\xVermin\\Bindings.lua:1>\nInterface\\AddOns\\xVermin\\Bindings.lua:218: in function <Interface\\AddOns\\xVermin\\Bindings.lua:217>",
			["session"] = 1648,
			["counter"] = 1,
		}, -- [117]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Unit.lua:76: attempt to index upvalue 'color' (a nil value)",
			["time"] = "2020/08/02 20:11:24",
			["locals"] = "(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = 0\n(*temporary) = 7\n(*temporary) = \"attempt to index upvalue 'color' (a nil value)\"\nspeed = \"0\"\nus = CustomContainer_CombatUnitSpeed {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\ncolor = nil\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Unit.lua:76: in function <Interface\\AddOns\\xVermin\\Unit.lua:68>\n[C]: ?",
			["session"] = 1652,
			["counter"] = 7,
		}, -- [118]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Unit.lua:25: attempt to index upvalue 'color' (a nil value)",
			["time"] = "2020/08/02 20:11:24",
			["locals"] = "(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index upvalue 'color' (a nil value)\"\ncus = CustomContainer_CombatUnitState {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\ncolor = nil\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Unit.lua:25: in function <Interface\\AddOns\\xVermin\\Unit.lua:16>\n[C]: ?\n[C]: ?",
			["session"] = 1652,
			["counter"] = 567,
		}, -- [119]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Unit.lua:77: attempt to index upvalue 'color' (a nil value)",
			["time"] = "2020/08/02 20:12:29",
			["locals"] = "(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = 0\n(*temporary) = 7\n(*temporary) = \"attempt to index upvalue 'color' (a nil value)\"\nspeed = \"0\"\nus = CustomContainer_CombatUnitSpeed {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\ncolor = nil\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Unit.lua:77: in function <Interface\\AddOns\\xVermin\\Unit.lua:69>\n[C]: ?",
			["session"] = 1653,
			["counter"] = 7,
		}, -- [120]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Unit.lua:26: attempt to index upvalue 'color' (a nil value)",
			["time"] = "2020/08/02 20:12:29",
			["locals"] = "(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index upvalue 'color' (a nil value)\"\ncus = CustomContainer_CombatUnitState {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\ncolor = nil\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Unit.lua:26: in function <Interface\\AddOns\\xVermin\\Unit.lua:17>\n[C]: ?\n[C]: ?",
			["session"] = 1653,
			["counter"] = 257,
		}, -- [121]
		{
			["message"] = "Error loading Interface\\AddOns\\xVermin\\Bags.lua",
			["time"] = "2020/08/02 20:13:03",
			["session"] = 1654,
			["counter"] = 3,
		}, -- [122]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:411: attempt to compare number with nil",
			["time"] = "2020/08/02 20:39:46",
			["locals"] = "self = AdiBagsItemButton42 {\n NormalTexture = AdiBagsItemButton42NormalTexture {\n }\n bag = 0\n BattlepayItemTexture = <unnamed> {\n }\n beautyShadow = <table> {\n }\n IconOverlay = <unnamed> {\n }\n BagStaticTop = <unnamed> {\n }\n IconBorder = <unnamed> {\n }\n flashAnim = <unnamed> {\n }\n icon = AdiBagsItemButton42IconTexture {\n }\n container = AdiBagsContainer1 {\n }\n acquired = true\n UpdateTooltip = <function> defined @Interface\\FrameXML\\ContainerFrame.lua:1298\n ExtendedOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n UpgradeIcon = <unnamed> {\n }\n NewItemTexture = <unnamed> {\n }\n Cooldown = AdiBagsItemButton42Cooldown {\n }\n bagFamily = 0\n BagStaticBottom = <unnamed> {\n }\n flash = <unnamed> {\n }\n ExtendedSlot = <unnamed> {\n }\n IconQuestTexture = AdiBagsItemButton42IconQuestTexture {\n }\n hasItem = true\n IconTexture = AdiBagsItemButton42IconTexture {\n }\n JunkIcon = <unnamed> {\n }\n Stock = AdiBagsItemButton42Stock {\n }\n slot = 1\n count = 2\n section = AdiBagsSection1 {\n }\n texture = 132793\n timeSinceUpgradeCheck = 0\n itemLink = \"|cffffffff|Hitem:5350::::::::4:::::::|h[]|h|r\"\n Count = AdiBagsItemButton42Count {\n }\n itemId = 5350\n 0 = <userdata>\n searchOverlay = AdiBagsItemButton42SearchOverlay {\n }\n newitemglowAnim = <unnamed> {\n }\n ExtendedOverlay2 = <unnamed> {\n }\n}\nisolatedEvent = nil\ntexture = nil\nr = nil\ng = nil\nb = nil\na = nil\nx1 = nil\nx2 = nil\ny1 = nil\ny2 = nil\nblendMode = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = 1\n(*temporary) = 1\n(*temporary) = 1\n(*temporary) = AdiBagsItemButton42 {\n NormalTexture = AdiBagsItemButton42NormalTexture {\n }\n bag = 0\n BattlepayItemTexture = <unnamed> {\n }\n beautyShadow = <table> {\n }\n IconOverlay = <unnamed> {\n }\n BagStaticTop = <unnamed> {\n }\n IconBorder = <unnamed> {\n }\n flashAnim = <unnamed> {\n }\n icon = AdiBagsItemButton42IconTexture {\n }\n container = AdiBagsContainer1 {\n }\n acquired = true\n UpdateTooltip = <function> defined @Interface\\FrameXML\\ContainerFrame.lua:1298\n ExtendedOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n UpgradeIcon = <unnamed> {\n }\n NewItemTexture = <unnamed> {\n }\n Cooldown = AdiBagsItemButton42Cooldown {\n }\n bagFamily = 0\n BagStaticBottom = <unnamed> {\n }\n flash = <unnamed> {\n }\n ExtendedSlot = <unnamed> {\n }\n IconQuestTexture = AdiBagsItemButton42IconQuestTexture {\n }\n hasItem = true\n IconTexture = AdiBagsItemButton42IconTexture {\n }\n JunkIcon = <unnamed> {\n }\n Stock = AdiBagsItemButton42Stock {\n }\n slot = 1\n count = 2\n section = AdiBagsSection1 {\n }\n texture = 132793\n timeSinceUpgradeCheck = 0\n itemLink = \"|cffffffff|Hitem:5350::::::::4:::::::|h[]|h|r\"\n Count = AdiBagsItemButton42Count {\n }\n itemId = 5350\n 0 = <userdata>\n searchOverlay = AdiBagsItemButton42SearchOverlay {\n }\n newitemglowAnim = <unnamed> {\n }\n ExtendedOverlay2 = <unnamed> {\n }\n}\n(*temporary) = 1\n(*temporary) = 1\n(*temporary) = 1\n(*temporary) = 1\n(*temporary) = \"attempt to compare number with nil\"\nGetBorder = <function> defined @Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:371\naddon = <table> {\n AcquireItemButton = <function> defined @Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:154\n modules = <table> {\n }\n UpdateFilters = <function> defined @Interface\\AddOns\\AdiBags\\core\\Filters.lua:86\n SecureHook = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceHook-3.0\\AceHook-3.0.lua:336\n GetInteractingWindow = <function> defined @Interface\\AddOns\\AdiBags\\core\\Core.lua:469\n ConfigChanged = <function> defined @Interface\\AddOns\\AdiBags\\core\\Core.lua:389\n GetSlotId = <function> defined @Interface\\AddOns\\AdiBags\\core\\Utility.lua:56\n Filter = <function> defined @Interface\\AddOns\\AdiBags\\core\\Filters.lua:147\n IsEnabled = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n Reconfigure = <function> defined @Interface\\AddOns\\AdiBags\\core\\Core.lua:205\n SetupTooltip = <function> defined @Interface\\AddOns\\AdiBags\\core\\Utility.lua:113\n RegisterMessage = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:90\n UnregisterMessage = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\C",
			["stack"] = "Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:411: in function `UpdateBorder'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:313: in function `Update'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:290: in function `FullUpdate'\nInterface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:255: in function <Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:243>\n[C]: in function `Show'\nInterface\\AddOns\\AdiBags\\widgets\\Section.lua:266: in function `AddItemButton'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:712: in function `DispatchItem'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:756: in function `UpdateButtons'\nInterface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:349: in function `?'\n...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:119: in function <...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:119>\n[C]: ?\n...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:29: in function <...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:25>\n...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:64: in function `SendMessage'\nInterface\\AddOns\\AdiBags\\core\\Core.lua:376: in function `?'\n...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:119: in function <...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:119>\n[C]: ?\n...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:29: in function <...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:25>\n...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:64: in function <...ags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:59>\n(tail call): ?",
			["session"] = 1663,
			["counter"] = 1,
		}, -- [123]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Experience.lua:107: attempt to concatenate local 'event' (a nil value)",
			["time"] = "2020/08/02 21:33:29",
			["locals"] = "self = nil\nevent = nil\nisInitialLogin = nil\nisReloadingUi = nil\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = \"Event: \"\n(*temporary) = nil\n(*temporary) = true\n(*temporary) = true\n(*temporary) = true\n(*temporary) = true\n(*temporary) = true\n(*temporary) = nil\n(*temporary) = true\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\Chat.lua:40\n(*temporary) = \"attempt to concatenate local 'event' (a nil value)\"\nNewXP = 4\ngained = 0\nCurrentXP = 4\nXPToLVL = 896\nMaxXP = 900\ncolor = <table> {\n colorStr = \"fff48cba\"\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 0.730000\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 0.550000\n r = 0.960000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\nhmmm = nil\ncmtk = CustomContainer_CombatMobsToKill {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\npercent = nil\n_ = 7\nrested = nil\noutput = nil\nPlayerExpFrame = PlayerExpFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nr = nil\ng = nil\nb = nil\nColorGradient = <function> defined @Interface\\AddOns\\xVermin\\Experience.lua:9\nclass = \"SHAMAN\"\npcxp = nil\npmxp = nil\nppercent = nil\nPetExpFrame = nil\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Experience.lua:107: in function <Interface\\AddOns\\xVermin\\Experience.lua:96>\nInterface\\AddOns\\xVermin\\Experience.lua:202: in function <Interface\\AddOns\\xVermin\\Experience.lua:192>",
			["session"] = 1673,
			["counter"] = 2,
		}, -- [124]
		{
			["message"] = "Interface\\AddOns\\xVermin\\DamageFont.lua:1: attempt to index global 'DamageFont' (a nil value)",
			["time"] = "2020/08/04 18:00:49",
			["locals"] = "(*temporary) = nil\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\DamageFont.lua:1\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'DamageFont' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\DamageFont.lua:1: in main chunk",
			["session"] = 1680,
			["counter"] = 2,
		}, -- [125]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Chat-Chat.lua:251: attempt to call global 'SetChatChannels' (a nil value)",
			["time"] = "2020/08/04 18:23:15",
			["locals"] = "frame = ChatFrame3 {\n GatherSelectedText = <function> defined =[C]:-1\n RefreshIfNecessary = <function> defined =[C]:-1\n OnPostShow = <function> defined =[C]:-1\n CalculateLineAlphaValueFromTimestamp = <function> defined =[C]:-1\n ScrollUp = <function> defined =[C]:-1\n tellTimer = 14807.952000\n fadeDurationSecs = 3\n GetFading = <function> defined =[C]:-1\n IsTextCopyable = <function> defined =[C]:-1\n shouldFadeAfterInactivity = true\n SetIndentedWordWrap = <function> defined =[C]:-1\n GetJustifyV = <function> defined =[C]:-1\n ScrollToBottom = <function> defined =[C]:-1\n GetMaxLines = <function> defined =[C]:-1\n GetIndentedWordWrap = <function> defined =[C]:-1\n buttonSide = \"left\"\n GetFont = <function> defined =[C]:-1\n SetMaxLines = <function> defined =[C]:-1\n CalculateSelectingCharacterIndicesForVisibleLine = <function> defined =[C]:-1\n OnPostUpdate = <function> defined =[C]:-1\n RefreshDisplay = <function> defined =[C]:-1\n SetFontObject = <function> defined =[C]:-1\n textIsCopyable = false\n SetOnScrollChangedCallback = <function> defined =[C]:-1\n CalculateNumVisibleLines = <function> defined =[C]:-1\n overrideFadeTimestamp = 0\n MarkDisplayDirty = <function> defined =[C]:-1\n GetMessageInfo = <function> defined =[C]:-1\n GetOnScrollChangedCallback = <function> defined =[C]:-1\n AtTop = <function> defined =[C]:-1\n GetFontObject = <function> defined =[C]:-1\n fontStringPool = <table> {\n }\n CanEffectivelyFade = <function> defined =[C]:-1\n OnPreSizeChanged = <function> defined =[C]:-1\n GetScrollOffset = <function> defined =[C]:-1\n GetSpacing = <function> defined =[C]:-1\n OnPreLoad = <function> defined =[C]:-1\n SetSpacing = <function> defined =[C]:-1\n name = \"Groups and parties\"\n CalculateLineSpacing = <function> defined =[C]:-1\n AddMessage = <function> defined @Interface\\AddOns\\xVermin\\Chat.lua:40\n InitializeFontableFrame = <function> defined =[C]:-1\n OnPostMouseDown = <function> defined =[C]:-1\n isUninteractable = false\n SetOnTextCopiedCallback = <function> defined =[C]:-1\n originalShow = <function> defined =[C]:-1\n RemoveMessagesByPredicate = <function> defined =[C]:-1\n TransformMessages = <function> defined =[C]:-1\n SetShadowColor = <function> defined =[C]:-1\n buttonFrame = ChatFrame3ButtonFrame {\n }\n HasFontObject = <function> defined =[C]:-1\n GetOnTextCopiedCallback = <function> defined =[C]:-1\n SetFading = <function> defined =[C]:-1\n OnPostHide = <function> defined =[C]:-1\n alternativeDefaultLanguage = \"Orcish\"\n isInitialized = 1\n GetNumVisibleLines = <function> defined =[C]:-1\n GetInsertMode = <function> defined =[C]:-1\n SetTimeVisible = <function> defined =[C]:-1\n hasOwnFontObject = true\n Clear = <function> defined =[C]:-1\n oldAlpha = 0\n channelList = <table> {\n }\n GetTimeVisible = <function> defined =[C]:-1\n IsSelectingText = <function> defined =[C]:-1\n SetTextCopyable = <function> defined =[C]:-1\n Show = <function> defined @Interface\\FrameXML\\FrameLocks.lua:135\n BackFillMessage = <function> defined =[C]:-1\n UnpackageEntry = <function> defined =[C]:-1\n FontStringContainer = <unnamed> {\n }\n SetShadowOffset = <function> defined =[C]:-1\n messageTypeList = <table> {\n }\n flashTimer = 0\n timeVisibleSecs = 120\n PackageEntry = <function> defined =[C]:-1\n MakeFontObjectCustom = <function> defined =[C]:-1\n SetPoint = <function> defined @Interface\\AddOns\\xVermin\\Chat.lua:200\n fontObject = table: 0x11cafa8a0 {\n }\n SetInsertMode = <function> defined =[C]:-1\n originalHide = <function> defined =[C]:-1\n ScrollDown = <function> defined =[C]:-1\n zoneChannelList = <table> {\n }\n SetScrollOffset = <function> defined =[C]:-1\n onDisplayRefreshedCallback = <function> defined =[C]:-1\n insertMode = 2\n ResetSelectingText = <function> defined =[C]:-1\n Hide = <function> defined @Interface\\FrameXML\\FrameLocks.lua:131\n GetTextColor = <function> defined =[C]:-1\n CallOnDisplayRefreshed = <function> defined =[C]:-1\n ResetAllFadeTimes = <function> defined =[C]:-1\n 0 = <userdata>\n ResizeButton = ChatFrame3ResizeButton {\n }\n UpdateSelectingText = <function> defined =[C]:-1\n OnFontObjectUpdated = <function> defined =[C]:-1\n MarkLayoutDirty = <function> defined =[C]",
			["stack"] = "Interface\\AddOns\\xVermin\\Chat-Chat.lua:251: in function <Interface\\AddOns\\xVermin\\Chat.lua:83>",
			["session"] = 1691,
			["counter"] = 12,
		}, -- [126]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Config.lua:83: attempt to index global 'xVermin' (a nil value)",
			["time"] = "2020/08/08 20:36:28",
			["locals"] = "(*temporary) = nil\n(*temporary) = <table> {\n petdebuff = <table> {\n }\n buff = <table> {\n }\n petbuff = <table> {\n }\n border = <table> {\n }\n font = <table> {\n }\n ReplacedDebuffTypeColor = <table> {\n }\n UIscale = 0.600000\n debuff = <table> {\n }\n background = <table> {\n }\n}\n(*temporary) = <table> {\n Disease = <table> {\n }\n Poison = <table> {\n }\n Curse = <table> {\n }\n Magic = <table> {\n }\n none = <table> {\n }\n}\n(*temporary) = <table> {\n b = 0\n g = 0.600000\n r = 0\n}\n(*temporary) = \"BOTTOMRIGHT\"\n(*temporary) = nil\n(*temporary) = \"BOTTOMRIGHT\"\n(*temporary) = 0\n(*temporary) = 2\n(*temporary) = \"Interface\\AddOns\\xVermin\\Media\\ItemQuality5\"\n(*temporary) = \"Interface\\AddOns\\xVermin\\Media\\ItemQuality6\"\n(*temporary) = \"Interface\\AddOns\\xVermin\\Media\\ItemQuality7\"\n(*temporary) = \"attempt to index global 'xVermin' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Config.lua:83: in main chunk",
			["session"] = 1719,
			["counter"] = 1,
		}, -- [127]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Frames/CustomContainers.lua:25: attempt to index global 'xVermin' (a nil value)",
			["time"] = "2020/08/08 20:36:28",
			["locals"] = "_ = \"Priest\"\nclass = \"PRIEST\"\ncolor = <table> {\n colorStr = \"ffffffff\"\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 1\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 1\n r = 1\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = CustomContainer_Combat {\n 0 = <userdata>\n}\n(*temporary) = <table> {\n}\n(*temporary) = nil\n(*temporary) = \"LEFT\"\n(*temporary) = 0\n(*temporary) = 0\n(*temporary) = <userdata>\n(*temporary) = \"attempt to index global 'xVermin' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Frames/CustomContainers.lua:25: in main chunk",
			["session"] = 1719,
			["counter"] = 1,
		}, -- [128]
		{
			["message"] = "Interface\\AddOns\\xVermin\\DamageFont.lua:4: attempt to index global 'xVermin' (a nil value)",
			["time"] = "2020/08/08 20:36:28",
			["locals"] = "self = DamageFont {\n 0 = <userdata>\n ApplySystemFonts = <function> defined @Interface\\AddOns\\xVermin\\DamageFont.lua:3\n}\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'xVermin' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\DamageFont.lua:4: in function `ApplySystemFonts'\nInterface\\AddOns\\xVermin\\DamageFont.lua:17: in main chunk",
			["session"] = 1719,
			["counter"] = 1,
		}, -- [129]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Experience.lua:59: attempt to index global 'xVermin' (a nil value)",
			["time"] = "2020/08/08 20:36:28",
			["locals"] = "_ = \"Priest\"\nclass = \"PRIEST\"\n_ = 5\nr = nil\ng = nil\nb = nil\nNewXP = nil\nhmmm = nil\ngained = nil\nXPToLVL = nil\nnum = nil\nsegment = nil\nrelperc = nil\nr1 = nil\nr2 = nil\ng1 = nil\ng2 = nil\nb1 = nil\nb2 = nil\nf = nil\nPetExpFrame = nil\nPlayerExpFrame = PlayerExpFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\npercent = nil\nrested = nil\noutput = nil\npcxp = nil\npmxp = nil\nppercent = nil\ncmtk = nil\ncolor = <table> {\n colorStr = \"ffffffff\"\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 1\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 1\n r = 1\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\nColorGradient = <function> defined @Interface\\AddOns\\xVermin\\Experience.lua:16\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = <userdata>\n(*temporary) = \"attempt to index global 'xVermin' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Experience.lua:59: in main chunk",
			["session"] = 1719,
			["counter"] = 1,
		}, -- [130]
		{
			["message"] = "Interface\\AddOns\\xVermin\\GarbageCollector.lua:9: attempt to index global 'xVermin' (a nil value)",
			["time"] = "2020/08/08 20:36:28",
			["locals"] = "cgt = CustomContainer_CombatGarbageText {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = \"ARTWORK\"\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = \"attempt to index global 'xVermin' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\GarbageCollector.lua:9: in main chunk",
			["session"] = 1719,
			["counter"] = 1,
		}, -- [131]
		{
			["message"] = "...face\\AddOns\\xVermin\\PlayerTargetHealthPercentage.lua:7: attempt to index global 'xVermin' (a nil value)",
			["time"] = "2020/08/08 20:36:28",
			["locals"] = "TargetHealthFrame = TargetHealthFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = \"ARTWORK\"\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = <userdata>\n(*temporary) = \"attempt to index global 'xVermin' (a nil value)\"\n",
			["stack"] = "...face\\AddOns\\xVermin\\PlayerTargetHealthPercentage.lua:7: in main chunk",
			["session"] = 1719,
			["counter"] = 1,
		}, -- [132]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Unit.lua:19: attempt to index global 'xVermin' (a nil value)",
			["time"] = "2020/08/08 20:36:28",
			["locals"] = "_ = \"Priest\"\nclass = \"PRIEST\"\ncolor = <table> {\n colorStr = \"ffffffff\"\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 1\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 1\n r = 1\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\ncus = CustomContainer_CombatUnitState {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = \"ARTWORK\"\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = <userdata>\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'xVermin' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Unit.lua:19: in main chunk",
			["session"] = 1719,
			["counter"] = 1,
		}, -- [133]
		{
			["message"] = "Interface\\AddOns\\xVermin\\UIScale.lua:19: attempt to index global 'xVermin' (a nil value)",
			["time"] = "2020/08/08 20:36:28",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n}\nevent = \"UI_SCALE_CHANGED\"\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = UIParent {\n 0 = <userdata>\n firstTimeLoaded = 1\n}\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'xVermin' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\UIScale.lua:19: in function <Interface\\AddOns\\xVermin\\UIScale.lua:6>",
			["session"] = 1719,
			["counter"] = 2,
		}, -- [134]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Chat-Chat.lua:85: attempt to index global 'xVermin' (a nil value)",
			["time"] = "2020/08/08 20:36:35",
			["locals"] = "(*temporary) = 1365.333407\n(*temporary) = nil\n(*temporary) = UIParent {\n 0 = <userdata>\n firstTimeLoaded = 1\n variablesLoaded = true\n}\n(*temporary) = 0.640000\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'xVermin' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Chat-Chat.lua:85: in function <Interface\\AddOns\\xVermin\\Chat.lua:83>",
			["session"] = 1719,
			["counter"] = 1,
		}, -- [135]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:142: MonkeyQuestFrame:SetPoint(): Couldn't find region named 'CustomContainer_2'",
			["time"] = "2020/08/08 20:36:35",
			["locals"] = "(*temporary) = MonkeyQuestFrame {\n 0 = <userdata>\n}\n(*temporary) = \"TOPRIGHT\"\n(*temporary) = \"CustomContainer_2\"\n(*temporary) = \"TOPLEFT\"\n(*temporary) = -10\n(*temporary) = 0\n",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\xVermin\\xVermin-54000.lua:142: in function <Interface\\AddOns\\xVermin\\xVermin.lua:32>",
			["session"] = 1719,
			["counter"] = 1,
		}, -- [136]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Frames/CharacterFrame.lua:42: attempt to index global 'xVermin' (a nil value)",
			["time"] = "2020/08/08 20:36:35",
			["locals"] = "itemLink = nil\nr = nil\ng = nil\nb = nil\nitemLink = nil\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = CharacterHeadSlot {\n }\n 2 = CharacterNeckSlot {\n }\n 3 = CharacterShoulderSlot {\n }\n 4 = CharacterBackSlot {\n }\n 5 = CharacterChestSlot {\n }\n 6 = CharacterWristSlot {\n }\n 7 = CharacterHandsSlot {\n }\n 8 = CharacterWaistSlot {\n }\n 9 = CharacterLegsSlot {\n }\n 10 = CharacterFeetSlot {\n }\n 11 = CharacterFinger0Slot {\n }\n 12 = CharacterFinger1Slot {\n }\n 13 = CharacterTrinket0Slot {\n }\n 14 = CharacterTrinket1Slot {\n }\n 15 = CharacterMainHandSlot {\n }\n 16 = CharacterSecondaryHandSlot {\n }\n 17 = CharacterRangedSlot {\n }\n 18 = CharacterAmmoSlot {\n }\n 19 = CharacterTabardSlot {\n }\n 20 = CharacterShirtSlot {\n }\n}\n(for control) = 1\ni = 1\nv = CharacterHeadSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n beautyShadow = <table> {\n }\n backgroundTextureName = 136516\n IconOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n checkRelic = false\n Count = CharacterHeadSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterHeadSlotSearchOverlay {\n }\n icon = CharacterHeadSlotIconTexture {\n }\n}\n(*temporary) = <function> defined @Interface\\AddOns\\!Beautycase\\!Beautycase.lua:130\n(*temporary) = CharacterHeadSlot {\n 0 = <userdata>\n UpdateTooltip = <function> defined @Interface\\FrameXML\\PaperDollFrame.lua:815\n beautyShadow = <table> {\n }\n backgroundTextureName = 136516\n IconOverlay = <unnamed> {\n }\n beautyBorder = <table> {\n }\n checkRelic = false\n Count = CharacterHeadSlotCount {\n }\n IconBorder = <unnamed> {\n }\n searchOverlay = CharacterHeadSlotSearchOverlay {\n }\n icon = CharacterHeadSlotIconTexture {\n }\n}\n(*temporary) = nil\n(*temporary) = 136516\n(*temporary) = false\n(*temporary) = 1\n(*temporary) = 136516\n(*temporary) = false\n(*temporary) = 1\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'xVermin' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Frames/CharacterFrame.lua:42: in function <Interface\\AddOns\\xVermin\\Frames/CharacterFrame.lua:1>",
			["session"] = 1719,
			["counter"] = 8,
		}, -- [137]
		{
			["message"] = "[string \"print(e(768 / string.match(({GetScreenResolutions()})[GetCurren...\"]:1: ')' expected near '<eof>'",
			["time"] = "2020/08/08 20:40:06",
			["locals"] = "(*temporary) = \"print(e(768 / string.match(({GetScreenResolutions()})[GetCurrentResolution()], \"%d+x(%d+)\"))\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1720,
			["counter"] = 1,
		}, -- [138]
		{
			["message"] = "[string \"SetScale(0.6)\"]:1: attempt to call global 'SetScale' (a nil value)",
			["time"] = "2020/08/08 20:41:02",
			["locals"] = "(*temporary) = nil\n(*temporary) = 0.600000\n(*temporary) = \"attempt to call global 'SetScale' (a nil value)\"\n",
			["stack"] = "[string \"SetScale(0.6)\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1720,
			["counter"] = 1,
		}, -- [139]
		{
			["message"] = "Interface\\AddOns\\Backpack\\core\\EventHandler.lua:13: Attempt to register unknown event \"PLAYERREAGENTBANKSLOTS_CHANGED\"",
			["time"] = "2020/08/09 09:57:29",
			["locals"] = "(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = \"PLAYERREAGENTBANKSLOTS_CHANGED\"\n",
			["stack"] = "[C]: in function `RegisterEvent'\nInterface\\AddOns\\Backpack\\core\\EventHandler.lua:13: in function <Interface\\AddOns\\Backpack\\core\\EventHandler.lua:6>\nInterface\\AddOns\\Backpack\\core\\EventHandler.lua:70: in function <Interface\\AddOns\\Backpack\\core\\EventHandler.lua:69>\nInterface\\AddOns\\Backpack\\core\\ContainerAPI.lua:117: in main chunk",
			["session"] = 1729,
			["counter"] = 1,
		}, -- [140]
		{
			["message"] = "Interface\\AddOns\\Backpack\\core\\Core.lua:7: attempt to call field 'MixinAPI' (a nil value)",
			["time"] = "2020/08/09 09:57:29",
			["locals"] = "P = <table> {\n printf = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:11\n error = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:16\n print = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:7\n name = \"Backpack\"\n}\nE = <table> {\n}\nBackpack = Backpack {\n locked = true\n Dropdown = BackpackMenu {\n }\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = Backpack {\n locked = true\n Dropdown = BackpackMenu {\n }\n 0 = <userdata>\n}\n(*temporary) = \"attempt to call field 'MixinAPI' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\Backpack\\core\\Core.lua:7: in main chunk",
			["session"] = 1729,
			["counter"] = 1,
		}, -- [141]
		{
			["message"] = "Interface\\AddOns\\Backpack\\core\\Categories-Categories.lua:65: attempt to call field 'Expose' (a nil value)",
			["time"] = "2020/08/09 09:57:29",
			["locals"] = "P = <table> {\n categories = <table> {\n }\n name = \"Backpack\"\n AddCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:45\n printf = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:11\n GetCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:28\n print = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:7\n error = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:16\n}\nE = <table> {\n}\nL = <table> {\n}\nMAX_INDEX = 999\nMIN_INDEX = 100\ndefaultSort = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:7\ndefaultFilter = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:23\n(*temporary) = nil\n(*temporary) = \"AddCategory\"\n(*temporary) = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:65\n(*temporary) = \"attempt to call field 'Expose' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\Backpack\\core\\Categories-Categories.lua:65: in main chunk",
			["session"] = 1729,
			["counter"] = 1,
		}, -- [142]
		{
			["message"] = "Interface\\AddOns\\Backpack\\core\\ContainerButtons.lua:68: attempt to index global 'BackpackBank' (a nil value)",
			["time"] = "2020/08/09 09:57:29",
			["locals"] = "P = <table> {\n categories = <table> {\n }\n AddContainerSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:33\n CreateContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:4\n print = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:7\n GetContainers = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:54\n printf = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:11\n GetAllContainers = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:50\n CreateContainerButton = <function> defined @Interface\\AddOns\\Backpack\\core\\ContainerButtons.lua:39\n GetCategoryContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:29\n RemoveContainerSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:38\n UpdateContainerPositions = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:134\n name = \"Backpack\"\n AddCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:45\n HasContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:58\n UpdateContainerSizes = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:62\n error = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:16\n GetCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:28\n}\nE = <table> {\n}\nL = <table> {\n}\natBank = nil\nUpdatePositions = <function> defined @Interface\\AddOns\\Backpack\\core\\ContainerButtons.lua:4\nShowTooltip = <function> defined @Interface\\AddOns\\Backpack\\core\\ContainerButtons.lua:31\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'BackpackBank' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\Backpack\\core\\ContainerButtons.lua:68: in main chunk",
			["session"] = 1729,
			["counter"] = 1,
		}, -- [143]
		{
			["message"] = "Interface\\AddOns\\Backpack\\core\\Modules.lua:11: attempt to call field 'Expose' (a nil value)",
			["time"] = "2020/08/09 09:57:29",
			["locals"] = "P = <table> {\n categories = <table> {\n }\n AddContainerSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:33\n CreateContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:4\n print = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:7\n GetContainers = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:54\n printf = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:11\n GetAllContainers = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:50\n CreateContainerButton = <function> defined @Interface\\AddOns\\Backpack\\core\\ContainerButtons.lua:39\n GetCategoryContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:29\n RemoveContainerSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:38\n UpdateContainerPositions = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:134\n name = \"Backpack\"\n AddCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:45\n HasContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:58\n UpdateContainerSizes = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:62\n error = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:16\n GetCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:28\n}\nE = <table> {\n}\nL = <table> {\n}\nmodules = <table> {\n}\n(*temporary) = nil\n(*temporary) = \"AddModule\"\n(*temporary) = <function> defined @Interface\\AddOns\\Backpack\\core\\Modules.lua:11\n(*temporary) = \"attempt to call field 'Expose' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\Backpack\\core\\Modules.lua:11: in main chunk",
			["session"] = 1729,
			["counter"] = 1,
		}, -- [144]
		{
			["message"] = "Interface\\AddOns\\Backpack\\core\\Position.lua:91: attempt to call method 'AddModule' (a nil value)",
			["time"] = "2020/08/09 09:57:29",
			["locals"] = "P = <table> {\n AddContainerSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:33\n UpdateContainerCooldowns = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:227\n print = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:7\n GetContainers = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:54\n UpdateContainerSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:237\n RemoveCategorySlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:293\n GetAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:118\n GetSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:114\n UpdateSlotInfo = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:189\n CreateSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:71\n UpdateContainerSizes = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:62\n RemoveContainerSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:38\n UpdateContainerPositions = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:134\n name = \"Backpack\"\n categorySlots = <table> {\n }\n UpdateSlotCooldown = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:220\n categories = <table> {\n }\n CreateContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:4\n HasContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:58\n UpdateSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:130\n InitializeAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:261\n InitializePosition = <function> defined @Interface\\AddOns\\Backpack\\core\\Position.lua:52\n printf = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:11\n GetAllContainers = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:50\n PositionSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:306\n GetCategoryContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:29\n GetCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:28\n AddCategorySlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:276\n GetAllParents = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:122\n AddCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:45\n HasParent = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:126\n UpdateAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:243\n error = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:16\n CreateContainerButton = <function> defined @Interface\\AddOns\\Backpack\\core\\ContainerButtons.lua:39\n}\nE = <table> {\n}\nL = <table> {\n}\ndefaultPositions = <table> {\n BackpackBank = <table> {\n }\n Backpack = <table> {\n }\n}\nOnDragStop = <function> defined @Interface\\AddOns\\Backpack\\core\\Position.lua:8\nOnDragStart = <function> defined @Interface\\AddOns\\Backpack\\core\\Position.lua:46\nOnClick = <function> defined @Interface\\AddOns\\Backpack\\core\\Position.lua:69\nInit = <function> defined @Interface\\AddOns\\Backpack\\core\\Position.lua:76\n(*temporary) = nil\n(*temporary) = Backpack {\n locked = true\n Dropdown = BackpackMenu {\n }\n 0 = <userdata>\n}\n(*temporary) = \"ToggleLock\"\n(*temporary) = <function> defined @Interface\\AddOns\\Backpack\\core\\Position.lua:76\n(*temporary) = nil\n(*temporary) = true\n(*temporary) = \"attempt to call method 'AddModule' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\Backpack\\core\\Position.lua:91: in main chunk",
			["session"] = 1729,
			["counter"] = 1,
		}, -- [145]
		{
			["message"] = "Interface\\AddOns\\Backpack\\core\\Blizzard.lua:22: attempt to index global 'ReagentBankFrame' (a nil value)",
			["time"] = "2020/08/09 09:57:29",
			["locals"] = "P = <table> {\n AddContainerSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:33\n UpdateContainerCooldowns = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:227\n print = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:7\n GetContainers = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:54\n UpdateContainerSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:237\n RemoveCategorySlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:293\n GetAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:118\n GetSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:114\n UpdateSlotInfo = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:189\n CreateSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:71\n UpdateContainerSizes = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:62\n RemoveContainerSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:38\n UpdateContainerPositions = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:134\n name = \"Backpack\"\n categorySlots = <table> {\n }\n UpdateSlotCooldown = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:220\n categories = <table> {\n }\n CreateContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:4\n HasContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:58\n UpdateSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:130\n InitializeAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:261\n InitializePosition = <function> defined @Interface\\AddOns\\Backpack\\core\\Position.lua:52\n printf = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:11\n GetAllContainers = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:50\n PositionSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:306\n GetCategoryContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:29\n GetCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:28\n AddCategorySlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:276\n GetAllParents = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:122\n AddCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:45\n HasParent = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:126\n UpdateAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:243\n error = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:16\n CreateContainerButton = <function> defined @Interface\\AddOns\\Backpack\\core\\ContainerButtons.lua:39\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = true\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'ReagentBankFrame' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\Backpack\\core\\Blizzard.lua:22: in main chunk",
			["session"] = 1729,
			["counter"] = 1,
		}, -- [146]
		{
			["message"] = "Interface\\AddOns\\Backpack\\modules\\Restack.lua:40: attempt to call method 'AddModule' (a nil value)",
			["time"] = "2020/08/09 09:57:29",
			["locals"] = "P = <table> {\n AddContainerSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:33\n UpdateContainerCooldowns = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:227\n print = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:7\n GetContainers = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:54\n UpdateContainerSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:237\n RemoveCategorySlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:293\n GetAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:118\n GetSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:114\n UpdateSlotInfo = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:189\n CreateSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:71\n UpdateContainerSizes = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:62\n RemoveContainerSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:38\n UpdateContainerPositions = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:134\n name = \"Backpack\"\n categorySlots = <table> {\n }\n UpdateSlotCooldown = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:220\n categories = <table> {\n }\n CreateContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:4\n HasContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:58\n UpdateSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:130\n InitializeAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:261\n InitializePosition = <function> defined @Interface\\AddOns\\Backpack\\core\\Position.lua:52\n printf = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:11\n GetAllContainers = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:50\n PositionSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:306\n GetCategoryContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:29\n GetCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:28\n AddCategorySlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:276\n GetAllParents = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:122\n AddCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:45\n HasParent = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:126\n UpdateAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:243\n error = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:16\n CreateContainerButton = <function> defined @Interface\\AddOns\\Backpack\\core\\ContainerButtons.lua:39\n}\nE = <table> {\n}\nL = <table> {\n}\nOnClick = <function> defined @Interface\\AddOns\\Backpack\\modules\\Restack.lua:3\nCreateButton = <function> defined @Interface\\AddOns\\Backpack\\modules\\Restack.lua:13\nInit = <function> defined @Interface\\AddOns\\Backpack\\modules\\Restack.lua:29\n(*temporary) = nil\n(*temporary) = Backpack {\n locked = true\n Dropdown = BackpackMenu {\n }\n 0 = <userdata>\n}\n(*temporary) = \"Restack\"\n(*temporary) = <function> defined @Interface\\AddOns\\Backpack\\modules\\Restack.lua:29\n(*temporary) = nil\n(*temporary) = true\n(*temporary) = \"attempt to call method 'AddModule' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\Backpack\\modules\\Restack.lua:40: in main chunk",
			["session"] = 1729,
			["counter"] = 1,
		}, -- [147]
		{
			["message"] = "Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:194: attempt to call method 'AddModule' (a nil value)",
			["time"] = "2020/08/09 09:57:29",
			["locals"] = "P = <table> {\n AddContainerSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:33\n UpdateContainerCooldowns = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:227\n print = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:7\n GetContainers = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:54\n UpdateContainerSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:237\n RemoveCategorySlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:293\n GetAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:118\n GetSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:114\n UpdateSlotInfo = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:189\n CreateSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:71\n UpdateContainerSizes = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:62\n RemoveContainerSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:38\n UpdateContainerPositions = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:134\n name = \"Backpack\"\n categorySlots = <table> {\n }\n UpdateSlotCooldown = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:220\n categories = <table> {\n }\n CreateContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:4\n HasContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:58\n UpdateSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:130\n InitializeAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:261\n InitializePosition = <function> defined @Interface\\AddOns\\Backpack\\core\\Position.lua:52\n printf = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:11\n GetAllContainers = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:50\n PositionSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:306\n GetCategoryContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:29\n GetCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:28\n AddCategorySlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:276\n GetAllParents = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:122\n AddCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:45\n HasParent = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:126\n UpdateAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:243\n error = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:16\n CreateContainerButton = <function> defined @Interface\\AddOns\\Backpack\\core\\ContainerButtons.lua:39\n}\nE = <table> {\n}\nL = <table> {\n}\nbags = <table> {\n}\ninventoryIDToBagID = <table> {\n}\nUpdateBag = <function> defined @Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:6\nUpdate = <function> defined @Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:22\nOnClick = <function> defined @Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:42\nOnDragStart = <function> defined @Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:56\nOnEnter = <function> defined @Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:60\nCreateBag = <function> defined @Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:73\nOnShow = <function> defined @Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:119\nOnHide = <function> defined @Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:130\nCreateParent = <function> defined @Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:137\nToggle = <function> defined @Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:150\nHideBagSlots = <function> defined @Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:155\nInit = <function> defined @Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:159\n(*temporary) = nil\n(*temporary) = Backpack {\n locked = true\n Dropdown = BackpackMenu {\n }\n 0 = <userdata>\n}\n(*temporary) = \"BagSlots\"\n(*temporary) = <function> defined @Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:159\n(*temporary) = <function> defined @Interface\\AddOns\\Backpack\\modules\\BagSlots.lua",
			["stack"] = "Interface\\AddOns\\Backpack\\modules\\BagSlots.lua:194: in main chunk",
			["session"] = 1729,
			["counter"] = 1,
		}, -- [148]
		{
			["message"] = "Interface\\AddOns\\Backpack\\modules\\Currencies.lua:72: attempt to call method 'AddModule' (a nil value)",
			["time"] = "2020/08/09 09:57:29",
			["locals"] = "P = <table> {\n AddContainerSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:33\n UpdateContainerCooldowns = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:227\n print = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:7\n GetContainers = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:54\n UpdateContainerSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:237\n RemoveCategorySlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:293\n GetAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:118\n GetSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:114\n UpdateSlotInfo = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:189\n CreateSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:71\n UpdateContainerSizes = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:62\n RemoveContainerSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:38\n UpdateContainerPositions = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:134\n name = \"Backpack\"\n categorySlots = <table> {\n }\n UpdateSlotCooldown = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:220\n categories = <table> {\n }\n CreateContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:4\n HasContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:58\n UpdateSlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:130\n InitializeAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:261\n InitializePosition = <function> defined @Interface\\AddOns\\Backpack\\core\\Position.lua:52\n printf = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:11\n GetAllContainers = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:50\n PositionSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:306\n GetCategoryContainer = <function> defined @Interface\\AddOns\\Backpack\\core\\Containers.lua:29\n GetCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:28\n AddCategorySlot = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:276\n GetAllParents = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:122\n AddCategory = <function> defined @Interface\\AddOns\\Backpack\\core\\Categories.lua:45\n HasParent = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:126\n UpdateAllSlots = <function> defined @Interface\\AddOns\\Backpack\\core\\Slots.lua:243\n error = <function> defined @Interface\\AddOns\\Backpack\\core\\Private.lua:16\n CreateContainerButton = <function> defined @Interface\\AddOns\\Backpack\\core\\ContainerButtons.lua:39\n}\nUpdate = <function> defined @Interface\\AddOns\\Backpack\\modules\\Currencies.lua:3\nOnEnter = <function> defined @Interface\\AddOns\\Backpack\\modules\\Currencies.lua:26\nOnClick = <function> defined @Interface\\AddOns\\Backpack\\modules\\Currencies.lua:32\nInit = <function> defined @Interface\\AddOns\\Backpack\\modules\\Currencies.lua:38\n(*temporary) = nil\n(*temporary) = Backpack {\n locked = true\n Dropdown = BackpackMenu {\n }\n 0 = <userdata>\n}\n(*temporary) = \"Currencies\"\n(*temporary) = <function> defined @Interface\\AddOns\\Backpack\\modules\\Currencies.lua:38\n(*temporary) = <function> defined @Interface\\AddOns\\Backpack\\modules\\Currencies.lua:3\n(*temporary) = false\n(*temporary) = \"CURRENCY_DISPLAY_UPDATE\"\n(*temporary) = \"attempt to call method 'AddModule' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\Backpack\\modules\\Currencies.lua:72: in main chunk",
			["session"] = 1729,
			["counter"] = 1,
		}, -- [149]
		{
			["message"] = "Interface\\AddOns\\Backpack\\core\\Blizzard.lua:4: attempt to call method 'Toggle' (a nil value)",
			["time"] = "2020/08/09 09:57:47",
			["locals"] = "(*temporary) = nil\n(*temporary) = Backpack {\n locked = true\n Dropdown = BackpackMenu {\n }\n 0 = <userdata>\n}\n(*temporary) = \"attempt to call method 'Toggle' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\Backpack\\core\\Blizzard.lua:4: in function `ToggleAllBags'\n[string \"OPENALLBAGS\"]:1: in function <[string \"OPENALLBAGS\"]:1>",
			["session"] = 1729,
			["counter"] = 1,
		}, -- [150]
		{
			["message"] = "Interface\\AddOns\\Backpack\\core\\Blizzard.lua:14: attempt to call method 'Toggle' (a nil value)",
			["time"] = "2020/08/09 09:57:51",
			["locals"] = "(*temporary) = nil\n(*temporary) = Backpack {\n locked = true\n Dropdown = BackpackMenu {\n }\n 0 = <userdata>\n}\n(*temporary) = false\n(*temporary) = \"attempt to call method 'Toggle' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\Backpack\\core\\Blizzard.lua:14: in function <Interface\\AddOns\\Backpack\\core\\Blizzard.lua:13>\n[C]: in function `securecall'\nInterface\\FrameXML\\UIParent.lua:1891: in function `ShowUIPanel'\nInterface\\FrameXML\\UIParent.lua:1793: in function <Interface\\FrameXML\\UIParent.lua:1789>\n[C]: in function `SetAttribute'\nInterface\\FrameXML\\UIParent.lua:2535: in function `ShowUIPanel'\nInterface\\FrameXML\\UIParent.lua:3382: in function `ToggleGameMenu'\n[string \"TOGGLEGAMEMENU\"]:1: in function <[string \"TOGGLEGAMEMENU\"]:1>",
			["session"] = 1729,
			["counter"] = 2,
		}, -- [151]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:56: Attempt to find 'this' in non-table object (used '.' instead of ':' ?)",
			["time"] = "2020/08/09 10:17:05",
			["locals"] = "(*temporary) = \"TOPRIGHT\"\n(*temporary) = \"ChatFrame3\"\n(*temporary) = \"TOPLEFT\"\n(*temporary) = -2\n(*temporary) = 2\n",
			["stack"] = "[C]: ?\nInterface\\AddOns\\xVermin\\xVermin-54000.lua:56: in function `MoveDTT'\nInterface\\AddOns\\xVermin\\xVermin-54000.lua:59: in function <Interface\\AddOns\\xVermin\\xVermin.lua:32>",
			["session"] = 1740,
			["counter"] = 4,
		}, -- [152]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'xVermin' tried to call the protected function 'SetBinding()'.",
			["time"] = "2020/08/09 12:35:08",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `SetBinding'\nInterface\\AddOns\\xVermin\\Bindings.lua:2: in function <Interface\\AddOns\\xVermin\\Bindings.lua:1>\nInterface\\AddOns\\xVermin\\Bindings.lua:126: in function <Interface\\AddOns\\xVermin\\Bindings.lua:125>\n[C]: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:353: in function `UIParentLoadAddOn'\nInterface\\FrameXML\\UIParent.lua:412: in function `TalentFrame_LoadUI'\nInterface\\FrameXML\\UIParent.lua:497: in function `ToggleTalentFrame'\n[string \"TOGGLETALENTS\"]:1: in function <[string \"TOGGLETALENTS\"]:1>",
			["session"] = 1749,
			["counter"] = 1,
		}, -- [153]
		{
			["message"] = "[string \"print(GetItemInfo(|cffffffff|Hitem:14542::::::::30:::::::|h[Kra...\"]:1: unexpected symbol near '|'",
			["time"] = "2020/08/09 19:52:02",
			["locals"] = "(*temporary) = \"print(GetItemInfo(|cffffffff|Hitem:14542::::::::30:::::::|h[Kravel's Crate]|h|r))\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1764,
			["counter"] = 1,
		}, -- [154]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:252: attempt to index local 'b' (a nil value)",
			["time"] = "2020/08/09 20:21:03",
			["locals"] = "a = <table> {\n id = 3712\n type = \"Meat\"\n}\nb = nil\n(*temporary) = 4\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = 4\n(*temporary) = \"attempt to index local 'b' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\BestFood.lua:252: in function <Interface\\AddOns\\xVermin\\BestFood.lua:251>\n[C]: in function `sort'\nInterface\\AddOns\\xVermin\\BestFood.lua:160: in function `Sorted'\nInterface\\AddOns\\xVermin\\BestFood.lua:108: in function `UpdateMacros'\nInterface\\AddOns\\xVermin\\BestFood.lua:50: in function <Interface\\AddOns\\xVermin\\BestFood.lua:45>",
			["session"] = 1764,
			["counter"] = 3,
		}, -- [155]
		{
			["message"] = "[string \"AdiBags:LayoutBags()\"]:1: attempt to index global 'AdiBags' (a nil value)",
			["time"] = "2020/08/11 16:15:16",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'AdiBags' (a nil value)\"\n",
			["stack"] = "[string \"AdiBags:LayoutBags()\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1776,
			["counter"] = 1,
		}, -- [156]
		{
			["message"] = "[string \"addon:LayoutBags()\"]:1: attempt to index global 'addon' (a nil value)",
			["time"] = "2020/08/11 16:16:02",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'addon' (a nil value)\"\n",
			["stack"] = "[string \"addon:LayoutBags()\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1776,
			["counter"] = 1,
		}, -- [157]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/AdiBags.lua:30: attempt to index local 'AdiBagsContainer' (a nil value)",
			["time"] = "2020/08/11 16:31:58",
			["locals"] = "AdiBagsContainer = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'AdiBagsContainer' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Addons/AdiBags.lua:30: in main chunk",
			["session"] = 1779,
			["counter"] = 1,
		}, -- [158]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/AdiBags.lua:31: attempt to index local 'AdiBagsContainer' (a nil value)",
			["time"] = "2020/08/11 16:33:52",
			["locals"] = "AdiBagsContainer = nil\n(*temporary) = \"AdiBags\"\n(*temporary) = nil\n(*temporary) = true\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'AdiBagsContainer' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Addons/AdiBags.lua:31: in main chunk",
			["session"] = 1780,
			["counter"] = 1,
		}, -- [159]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/AdiBags.lua:45: attempt to index global 'myTimer' (a nil value)",
			["time"] = "2020/08/12 09:23:37",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'myTimer' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Addons/AdiBags.lua:45: in function <Interface\\AddOns\\xVermin\\Addons/AdiBags.lua:42>\n[C]: ?",
			["session"] = 1792,
			["counter"] = 1,
		}, -- [160]
		{
			["message"] = "[string \"us:Show()\"]:1: attempt to index global 'us' (a nil value)",
			["time"] = "2020/08/12 09:33:13",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'us' (a nil value)\"\n",
			["stack"] = "[string \"us:Show()\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1797,
			["counter"] = 1,
		}, -- [161]
		{
			["message"] = "[string \"print(us:IsVisible())\"]:1: attempt to index global 'us' (a nil value)",
			["time"] = "2020/08/12 09:37:29",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'us' (a nil value)\"\n",
			["stack"] = "[string \"print(us:IsVisible())\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1800,
			["counter"] = 1,
		}, -- [162]
		{
			["message"] = "Interface\\FrameXML\\UIParent.lua:3817: attempt to perform arithmetic on local 'challengeLevel' (a nil value)",
			["time"] = "2020/08/12 12:42:49",
			["locals"] = "unitLevel = 25\nchallengeLevel = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to perform arithmetic on local 'challengeLevel' (a nil value)\"\n",
			["stack"] = "Interface\\FrameXML\\UIParent.lua:3817: in function <Interface\\FrameXML\\UIParent.lua:3816>\n(tail call): ?\n[string \"print(GetQuestDifficultyColor(level))\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1804,
			["counter"] = 1,
		}, -- [163]
		{
			["message"] = "Interface\\AddOns\\nMinimap\\tab.lua:239: attempt to call method 'GenerateHexColor' (a nil value)",
			["time"] = "2020/08/12 12:39:37",
			["locals"] = "entry = GuildScrollFrameEntry2 {\n RightText = GuildScrollFrameEntry2RightText {\n }\n LeftText = GuildScrollFrameEntry2LeftText {\n }\n index = 2\n id = 4\n 0 = <userdata>\n}\nscrollFrame = GuildScrollFrame {\n offset = 0\n scrollChild = GuildScrollChild {\n }\n entries = <table> {\n }\n entryHeight = 17\n numEntries = 5\n scrollBar = GuildScrollFrameScrollBar {\n }\n 0 = <userdata>\n totalEntriesHeight = 85\n ScrollBar = GuildScrollFrameScrollBar {\n }\n}\nindex = 2\nheight = 17\nminWidth = 320.788513\nzonec = <table> {\n a = 1\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 0.750000\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 0.750000\n r = 0.750000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\nclassc = <table> {\n b = 1\n colorStr = \"ff326fff\"\n g = 0.435294\n r = 0.196078\n}\nlevelc = <table> {\n b = 0.100000\n font = \"QuestDifficulty_Impossible\"\n g = 0.100000\n r = 1\n}\nname = \"Hooftallow-Golemagg\"\nrank = \"Sailor\"\n_ = 7\nlevel = \"|cffff191960|r\"\n_ = \"Shaman\"\nzone = \"Stratholme\"\nnote = \"Morvious\"\nofficernote = \"\"\nconnected = true\nstatus = 0\nclass = \"SHAMAN\"\n_ = -1\n(*temporary) = <function> defined @Interface\\SharedXML\\Util.lua:603\n(*temporary) = \"Hooftallow-Golemagg\"\n(*temporary) = nil\n(*temporary) = <table> {\n b = 1\n colorStr = \"ff326fff\"\n g = 0.435294\n r = 0.196078\n}\n(*temporary) = \"attempt to call method 'GenerateHexColor' (a nil value)\"\nGuildListEntries = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n 4 = <table> {\n }\n 5 = <table> {\n }\n}\nactivezone = <table> {\n a = 1\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 0\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 1\n r = 0.300000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\ninactivezone = <table> {\n a = 1\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 0.750000\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 0.750000\n r = 0.750000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\nstatusText = <table> {\n 0 = \"\"\n 2 = \"Do not Disturb\"\n 1 = \"AFK\"\n}\n",
			["stack"] = "Interface\\AddOns\\nMinimap\\tab.lua:239: in function `nMinimap_UpdateGuildButton'\nInterface\\AddOns\\nMinimap\\tab.lua:279: in function `nMinimap_UpdateGuildMembers'\nInterface\\AddOns\\nMinimap\\tab.lua:325: in function `nMinimapTab_Guild_UpdateScrollFrame'\nInterface\\AddOns\\nMinimap\\tab.lua:333: in function <Interface\\AddOns\\nMinimap\\tab.lua:328>",
			["session"] = 1804,
			["counter"] = 21,
		}, -- [164]
		{
			["message"] = "Interface\\AddOns\\nMinimap\\tab.lua:240: attempt to call method 'GenerateHexColor' (a nil value)",
			["time"] = "2020/08/12 12:43:26",
			["locals"] = "entry = GuildScrollFrameEntry3 {\n RightText = GuildScrollFrameEntry3RightText {\n }\n LeftText = GuildScrollFrameEntry3LeftText {\n }\n index = 3\n id = 4\n 0 = <userdata>\n}\nscrollFrame = GuildScrollFrame {\n offset = 0\n scrollChild = GuildScrollChild {\n }\n entries = <table> {\n }\n entryHeight = 17\n numEntries = 7\n scrollBar = GuildScrollFrameScrollBar {\n }\n 0 = <userdata>\n totalEntriesHeight = 119\n ScrollBar = GuildScrollFrameScrollBar {\n }\n}\nindex = 3\nheight = 17\nminWidth = 320.788513\nzonec = <table> {\n a = 1\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 0.750000\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 0.750000\n r = 0.750000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\nclassc = <table> {\n b = 1\n colorStr = \"ff326fff\"\n g = 0.435294\n r = 0.196078\n}\nlevelc = <table> {\n b = 0.100000\n font = \"QuestDifficulty_Impossible\"\n g = 0.100000\n r = 1\n}\nname = \"Hooftallow-Golemagg\"\nrank = \"Sailor\"\n_ = 7\nlevel = \"|cffff191960|r\"\n_ = \"Shaman\"\nzone = \"Stratholme\"\nnote = \"Morvious\"\nofficernote = \"\"\nconnected = true\nstatus = 0\nclass = \"SHAMAN\"\n_ = -1\n(*temporary) = <function> defined @Interface\\SharedXML\\Util.lua:603\n(*temporary) = \"Hooftallow-Golemagg\"\n(*temporary) = nil\n(*temporary) = <table> {\n b = 1\n colorStr = \"ff326fff\"\n g = 0.435294\n r = 0.196078\n}\n(*temporary) = \"attempt to call method 'GenerateHexColor' (a nil value)\"\nGuildListEntries = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n 4 = <table> {\n }\n 5 = <table> {\n }\n 6 = <table> {\n }\n 7 = <table> {\n }\n}\nactivezone = <table> {\n a = 1\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 0\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 1\n r = 0.300000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\ninactivezone = <table> {\n a = 1\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 0.750000\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 0.750000\n r = 0.750000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\nstatusText = <table> {\n 0 = \"\"\n 2 = \"Do not Disturb\"\n 1 = \"AFK\"\n}\n",
			["stack"] = "Interface\\AddOns\\nMinimap\\tab.lua:240: in function `nMinimap_UpdateGuildButton'\nInterface\\AddOns\\nMinimap\\tab.lua:280: in function `nMinimap_UpdateGuildMembers'\nInterface\\AddOns\\nMinimap\\tab.lua:326: in function `nMinimapTab_Guild_UpdateScrollFrame'\nInterface\\AddOns\\nMinimap\\tab.lua:334: in function <Interface\\AddOns\\nMinimap\\tab.lua:329>",
			["session"] = 1808,
			["counter"] = 31,
		}, -- [165]
		{
			["message"] = "Interface\\AddOns\\nMinimap\\tab.lua:242: attempt to call method 'GenerateHexColor' (a nil value)",
			["time"] = "2020/08/12 12:46:58",
			["locals"] = "entry = GuildScrollFrameEntry2 {\n RightText = GuildScrollFrameEntry2RightText {\n }\n LeftText = GuildScrollFrameEntry2LeftText {\n }\n index = 2\n id = 3\n 0 = <userdata>\n}\nscrollFrame = GuildScrollFrame {\n offset = 0\n scrollChild = GuildScrollChild {\n }\n entries = <table> {\n }\n entryHeight = 17\n numEntries = 8\n scrollBar = GuildScrollFrameScrollBar {\n }\n 0 = <userdata>\n totalEntriesHeight = 136\n ScrollBar = GuildScrollFrameScrollBar {\n }\n}\nindex = 2\nheight = 17\nminWidth = 320.788513\nzonec = <table> {\n a = 1\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 0.750000\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 0.750000\n r = 0.750000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\nclassc = <table> {\n b = 1\n colorStr = \"ff326fff\"\n g = 0.435294\n r = 0.196078\n}\nlevelc = <table> {\n b = 0.100000\n font = \"QuestDifficulty_Impossible\"\n g = 0.100000\n r = 1\n}\nname = \"Hooftallow-Golemagg\"\nrank = \"Sailor\"\n_ = 7\nlevel = 60\n_ = \"Shaman\"\nzone = \"Stratholme\"\nnote = \"Morvious\"\nofficernote = \"\"\nconnected = true\nstatus = 0\nclass = \"SHAMAN\"\n_ = -1\n(*temporary) = <function> defined @Interface\\SharedXML\\Util.lua:603\n(*temporary) = \"Hooftallow-Golemagg\"\n(*temporary) = nil\n(*temporary) = <table> {\n b = 1\n colorStr = \"ff326fff\"\n g = 0.435294\n r = 0.196078\n}\n(*temporary) = \"attempt to call method 'GenerateHexColor' (a nil value)\"\nGuildListEntries = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n 4 = <table> {\n }\n 5 = <table> {\n }\n 6 = <table> {\n }\n 7 = <table> {\n }\n 8 = <table> {\n }\n}\nactivezone = <table> {\n a = 1\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 0\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 1\n r = 0.300000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\ninactivezone = <table> {\n a = 1\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 0.750000\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 0.750000\n r = 0.750000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\nstatusText = <table> {\n 0 = \"\"\n 2 = \"Do not Disturb\"\n 1 = \"AFK\"\n}\n",
			["stack"] = "Interface\\AddOns\\nMinimap\\tab.lua:242: in function `nMinimap_UpdateGuildButton'\nInterface\\AddOns\\nMinimap\\tab.lua:282: in function `nMinimap_UpdateGuildMembers'\nInterface\\AddOns\\nMinimap\\tab.lua:328: in function `nMinimapTab_Guild_UpdateScrollFrame'\nInterface\\AddOns\\nMinimap\\tab.lua:336: in function <Interface\\AddOns\\nMinimap\\tab.lua:331>",
			["session"] = 1809,
			["counter"] = 4,
		}, -- [166]
		{
			["message"] = "Interface\\AddOns\\nMinimap\\tab.lua:774: attempt to index global 'nMinimapTab' (a nil value)",
			["time"] = "2020/08/12 20:59:29",
			["locals"] = "_ = \"nMinimap\"\nnMinimap = <table> {\n UpdateGuildText = <function> defined @Interface\\AddOns\\nMinimap\\tab.lua:203\n Config = <table> {\n }\n}\ncfg = <table> {\n scale = 1.100000\n tab = <table> {\n }\n mouseover = <table> {\n }\n location = <table> {\n }\n}\nselect = <function> defined =[C]:-1\nceil = <function> defined =[C]:-1\nmodf = <function> defined =[C]:-1\nformat = <function> defined =[C]:-1\nsort = <function> defined =[C]:-1\ntinsert = <function> defined =[C]:-1\nplayerName = \"Vermin\"\n_ = nil\nplayerRealm = \"Golemagg\"\nNUM_ADDONS_TO_DISPLAY = 86\nactivezone = <table> {\n a = 1\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 0\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 1\n r = 0.300000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\ninactivezone = <table> {\n a = 1\n GetRGB = <function> defined @Interface\\SharedXML\\Util.lua:633\n OnLoad = <function> defined @Interface\\SharedXML\\Util.lua:622\n b = 0.750000\n GenerateHexColorMarkup = <function> defined @Interface\\SharedXML\\Util.lua:664\n WrapTextInColorCode = <function> defined @Interface\\SharedXML\\Util.lua:668\n GenerateHexColor = <function> defined @Interface\\SharedXML\\Util.lua:660\n GetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:641\n IsEqualTo = <function> defined @Interface\\SharedXML\\Util.lua:626\n g = 0.750000\n r = 0.750000\n SetRGBA = <function> defined @Interface\\SharedXML\\Util.lua:649\n GetRGBAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:637\n SetRGB = <function> defined @Interface\\SharedXML\\Util.lua:656\n GetRGBAAsBytes = <function> defined @Interface\\SharedXML\\Util.lua:645\n}\nguildIcon = \"|TInterface\\GossipFrame\\TabardGossipIcon:16:16:0:0:16:16:0:16:0:16|t\"\nfriendIcon = \"|A:groupfinder-icon-friend:18:18:0:0|a\"\nperformanceIcon = \"|TInterface\\AddOns\\nMinimap\\media\\texturePerformance:10:10:0:0:32:32:0:32:0:32|t\"\nFriendListEntries = <table> {\n}\nGuildListEntries = <table> {\n}\nMemoryListEntries = <table> {\n}\nAddonTable = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n 4 = <table> {\n }\n 5 = <table> {\n }\n 6 = <table> {\n }\n 7 = <table> {\n }\n 8 = <table> {\n }\n 9 = <table> {\n }\n 10 = <table> {\n }\n 11 = <table> {\n }\n 12 = <table> {\n }\n 13 = <table> {\n }\n 14 = <table> {\n }\n 15 = <table> {\n }\n 16 = <table> {\n }\n 17 = <table> {\n }\n 18 = <table> {\n }\n 19 = <table> {\n }\n 20 = <table> {\n }\n 21 = <table> {\n }\n 22 = <table> {\n }\n 23 = <table> {\n }\n 24 = <table> {\n }\n 25 = <table> {\n }\n 26 = <table> {\n }\n 27 = <table> {\n }\n 28 = <table> {\n }\n 29 = <table> {\n }\n 30 = <table> {\n }\n 31 = <table> {\n }\n 32 = <table> {\n }\n 33 = <table> {\n }\n 34 = <table> {\n }\n 35 = <table> {\n }\n 36 = <table> {\n }\n 37 = <table> {\n }\n 38 = <table> {\n }\n 39 = <table> {\n }\n 40 = <table> {\n }\n 41 = <table> {\n }\n 42 = <table> {\n }\n 43 = <table> {\n }\n 44 = <table> {\n }\n 45 = <table> {\n }\n 46 = <table> {\n }\n 47 = <table> {\n }\n 48 = <table> {\n }\n 49 = <table> {\n }\n 50 = <table> {\n }\n 51 = <table> {\n }\n 52 = <table> {\n }\n 53 = <table> {\n }\n 54 = <table> {\n }\n 55 = <table> {\n }\n 56 = <table> {\n }\n 57 = <table> {\n }\n 58 = <table> {\n }\n 59 = <table> {\n }\n 60 = <table> {\n }\n 61 = <table> {\n }\n 62 = <table> {\n }\n 63 = <table> {\n }\n 64 = <table> {\n }\n 65 = <table> {\n }\n 66 = <table> {\n }\n 67 = <table> {\n }\n 68 = <table> {\n }\n 69 = <table> {\n }\n 70 = <table> {\n }\n 71 = <table> {\n }\n 72 = <table> {\n }\n 73 = <table> {\n }\n 74 = <table> {\n }\n 75 = <table> {\n }\n 76 = <table> {\n }\n 77 = <table> {\n }\n 78 = <table> {\n }\n 79 = <table> {\n }\n 80 = <table> {\n }\n 81 = <table> {\n }\n 82 = <table> {\n }\n 83 = <table",
			["stack"] = "Interface\\AddOns\\nMinimap\\tab.lua:774: in main chunk",
			["session"] = 1820,
			["counter"] = 1,
		}, -- [167]
		{
			["message"] = "Error loading Interface\\AddOns\\TradeSkillMaster_AppHelper\\AppData.lua",
			["time"] = "2020/08/13 21:31:07",
			["session"] = 1843,
			["counter"] = 6,
		}, -- [168]
		{
			["message"] = "Interface\\AddOns\\TradeSkillMaster_AppHelper\\AppData.lua:2: unexpected symbol near ')'",
			["time"] = "2020/08/13 21:24:07",
			["locals"] = "",
			["stack"] = "",
			["session"] = 1844,
			["counter"] = 12,
		}, -- [169]
		{
			["message"] = "...angeDisplay\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-17.lua:74: attempt to call global 'GetNumSpecializationsForClassID' (a nil value)",
			["time"] = "2020/08/16 22:11:27",
			["locals"] = "MAJOR = \"LibDualSpec-1.0\"\nMINOR = 17\nlib = <table> {\n registry = <table> {\n }\n options = <table> {\n }\n upgrades = <table> {\n }\n currentSpec = 0\n eventFrame = <unnamed> {\n }\n mixin = <table> {\n }\n}\nminor = nil\nregistry = <table> {\n}\noptions = <table> {\n}\nmixin = <table> {\n}\nupgrades = <table> {\n}\nAceDB3 = <table> {\n db_registry = <table> {\n }\n frame = <unnamed> {\n }\n New = <function> defined @Interface\\AddOns\\AdiBags\\libs\\AceDB-3.0\\AceDB-3.0.lua:709\n}\nAceDBOptions3 = <table> {\n optionTables = <table> {\n }\n handlers = <table> {\n }\n GetOptionsTable = <function> defined @Interface\\AddOns\\ChocolateBar\\libs\\AceDBOptions-3.0\\AceDBOptions-3.0.lua:442\n}\nAceConfigRegistry3 = <table> {\n RegisterOptionsTable = <function> defined @Interface\\AddOns\\ChocolateBar\\libs\\AceConfig-3.0\\AceConfigRegistry-3.0\\AceConfigRegistry-3.0.lua:315\n validated = <table> {\n }\n tables = <table> {\n }\n callbacks = <table> {\n }\n RegisterCallback = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:90\n GetOptionsTable = <function> defined @Interface\\AddOns\\ChocolateBar\\libs\\AceConfig-3.0\\AceConfigRegistry-3.0\\AceConfigRegistry-3.0.lua:360\n UnregisterCallback = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:153\n IterateOptionsTables = <function> defined @Interface\\AddOns\\ChocolateBar\\libs\\AceConfig-3.0\\AceConfigRegistry-3.0\\AceConfigRegistry-3.0.lua:346\n NotifyChange = <function> defined @Interface\\AddOns\\ChocolateBar\\libs\\AceConfig-3.0\\AceConfigRegistry-3.0\\AceConfigRegistry-3.0.lua:289\n ValidateOptionsTable = <function> defined @Interface\\AddOns\\ChocolateBar\\libs\\AceConfig-3.0\\AceConfigRegistry-3.0\\AceConfigRegistry-3.0.lua:276\n UnregisterAllCallbacks = <function> defined @Interface\\AddOns\\AdiBags\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:174\n}\n_ = \"Mage\"\n_ = \"MAGE\"\nclassId = 8\n(*temporary) = nil\n(*temporary) = 8\n(*temporary) = \"attempt to call global 'GetNumSpecializationsForClassID' (a nil value)\"\n",
			["stack"] = "...angeDisplay\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-17.lua:74: in main chunk",
			["session"] = 1885,
			["counter"] = 1,
		}, -- [170]
		{
			["message"] = "Interface\\AddOns\\RangeDisplay\\RangeDisplay-v4.8.3.lua:715: attempt to call method 'EnhanceDatabase' (a nil value)",
			["time"] = "2020/08/16 22:11:27",
			["stack"] = "Interface\\AddOns\\RangeDisplay\\RangeDisplay-v4.8.3.lua:715: in function <Interface\\AddOns\\RangeDisplay\\RangeDisplay.lua:707>\n[C]: ?\n...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:70: in function <...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:65>\n...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:498: in function `InitializeAddon'\n...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:613: in function <...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:605>",
			["session"] = 1885,
			["counter"] = 1,
		}, -- [171]
		{
			["message"] = "Interface\\AddOns\\RangeDisplay\\RangeDisplay-v4.8.3.lua:780: attempt to index field 'db' (a nil value)",
			["time"] = "2020/08/16 22:11:40",
			["stack"] = "Interface\\AddOns\\RangeDisplay\\RangeDisplay-v4.8.3.lua:780: in function `applySettings'\nInterface\\AddOns\\RangeDisplay\\RangeDisplay-v4.8.3.lua:764: in function <Interface\\AddOns\\RangeDisplay\\RangeDisplay.lua:763>\n[C]: ?\n...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:70: in function <...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:65>\n...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:527: in function `EnableAddon'\n...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:620: in function <...ce\\AddOns\\AdiBags\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:605>\n[C]: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:353: in function `UIParentLoadAddOn'\nInterface\\FrameXML\\UIParent.lua:380: in function `CombatLog_LoadUI'\nInterface\\FrameXML\\UIParent.lua:695: in function <Interface\\FrameXML\\UIParent.lua:658>",
			["session"] = 1885,
			["counter"] = 1,
		}, -- [172]
		{
			["message"] = "(null)",
			["session"] = 1885,
			["time"] = "2020/07/24 16:00:06",
			["counter"] = 63,
		}, -- [173]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:87: attempt to index global 'RangeDisplayMainFrame_mouseover' (a nil value)",
			["time"] = "2020/08/17 12:11:10",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"CENTER\"\n(*temporary) = UIParent {\n 0 = <userdata>\n firstTimeLoaded = 1\n variablesLoaded = true\n}\n(*temporary) = \"CENTER\"\n(*temporary) = 0\n(*temporary) = -20\n(*temporary) = <userdata>\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'RangeDisplayMainFrame_mouseover' (a nil value)\"\nxVermin = <table> {\n AOE = <function> defined @Interface\\AddOns\\xVermin\\Rotation/_Core.lua:3\n Config = <table> {\n }\n}\n",
			["stack"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:87: in function <Interface\\AddOns\\xVermin\\xVermin.lua:34>",
			["session"] = 1890,
			["counter"] = 1,
		}, -- [174]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:89: attempt to index global 'RangeDisplayMainFrame_mouseover' (a nil value)",
			["time"] = "2020/08/17 12:17:24",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"CENTER\"\n(*temporary) = UIParent {\n 0 = <userdata>\n firstTimeLoaded = 1\n variablesLoaded = true\n}\n(*temporary) = \"CENTER\"\n(*temporary) = 0\n(*temporary) = -20\n(*temporary) = <userdata>\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'RangeDisplayMainFrame_mouseover' (a nil value)\"\nxVermin = <table> {\n AOE = <function> defined @Interface\\AddOns\\xVermin\\Rotation/_Core.lua:3\n Config = <table> {\n }\n}\n",
			["stack"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:89: in function <Interface\\AddOns\\xVermin\\xVermin.lua:34>",
			["session"] = 1891,
			["counter"] = 1,
		}, -- [175]
		{
			["message"] = "[ADDON_ACTION_FORBIDDEN] AddOn 'TradeSkillMaster' tried to call the protected function 'RunBinding()'.",
			["time"] = "2020/08/17 12:37:15",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `RunBinding'\nInterface\\FrameXML\\StackSplitFrame.lua:182: in function <Interface\\FrameXML\\StackSplitFrame.lua:179>\n[C]: in function `Hide'\nInterface\\FrameXML\\StackSplitFrame.lua:168: in function `StackSplitFrameOkay_Click'\nInterface\\FrameXML\\StackSplitFrame.lua:113: in function <Interface\\FrameXML\\StackSplitFrame.lua:91>",
			["session"] = 1894,
			["counter"] = 1,
		}, -- [176]
		{
			["message"] = "[string \"MultiBarBottomLeft:SetPoint(\"TOP\", MainMenuBar, \"BOTTOM\" 0, 0)\"]:1: ')' expected near '0'",
			["time"] = "2020/08/19 13:45:42",
			["locals"] = "(*temporary) = \"MultiBarBottomLeft:SetPoint(\"TOP\", MainMenuBar, \"BOTTOM\" 0, 0)\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1909,
			["counter"] = 1,
		}, -- [177]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Experience.lua:286: attempt to call global 'FormatValue' (a nil value)",
			["time"] = "2020/08/19 20:46:14",
			["locals"] = "(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = 10097\n(*temporary) = \"attempt to call global 'FormatValue' (a nil value)\"\nf2 = PlayerXPFrame {\n 0 = <userdata>\n Power = PlayerXPFrameStatusBar {\n }\n}\nMaxXP = 50800\nCurrentXP = 10097\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Experience.lua:286: in function <Interface\\AddOns\\xVermin\\Experience.lua:283>\nInterface\\AddOns\\xVermin\\Experience.lua:298: in function <Interface\\AddOns\\xVermin\\Experience.lua:297>\nInterface\\AddOns\\xVermin\\Experience.lua:310: in function <Interface\\AddOns\\xVermin\\Experience.lua:309>",
			["session"] = 1924,
			["counter"] = 2,
		}, -- [178]
		{
			["message"] = "[string \"f2.XPbar.Rested:SetPoint(\"TOP\", f2.XPbar.Va...\"]:1: attempt to index global 'f2' (a nil value)",
			["time"] = "2020/08/19 21:01:17",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'f2' (a nil value)\"\n",
			["stack"] = "[string \"f2.XPbar.Rested:SetPoint(\"TOP\", f2.XPbar.Va...\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1928,
			["counter"] = 1,
		}, -- [179]
		{
			["message"] = "[string \"PlayerXPFrameStatusBar.Rested:SetPoint(\"TOP...\"]:1: attempt to index global 'f2' (a nil value)",
			["time"] = "2020/08/19 21:01:52",
			["locals"] = "(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = \"TOP\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'f2' (a nil value)\"\n",
			["stack"] = "[string \"PlayerXPFrameStatusBar.Rested:SetPoint(\"TOP...\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1928,
			["counter"] = 1,
		}, -- [180]
		{
			["message"] = "[ADDON_ACTION_FORBIDDEN] AddOn 'nMinimap' tried to call the protected function 'CopyToClipboard()'.",
			["time"] = "2020/08/19 21:02:06",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `CopyToClipboard'\n...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua:548: in function `FrameStackTooltip_HandleFrameCommand'\n...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua:518: in function `command'\nInterface\\SharedXML\\KeyCommand.lua:46: in function `Update'\nInterface\\SharedXML\\KeyCommand.lua:110: in function `KeyCommand_Update'\n...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua:727: in function <...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools.lua:726>",
			["session"] = 1928,
			["counter"] = 1,
		}, -- [181]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Experience/Player.lua:85: attempt to call global 'ColorGradient' (a nil value)",
			["time"] = "2020/08/19 21:08:45",
			["locals"] = "self = nil\nevent = nil\n(*temporary) = nil\n(*temporary) = Infinite\n(*temporary) = 1\n(*temporary) = 0\n(*temporary) = 0\n(*temporary) = 1\n(*temporary) = 1\n(*temporary) = 0\n(*temporary) = 0\n(*temporary) = 1\n(*temporary) = 0\n(*temporary) = \"attempt to call global 'ColorGradient' (a nil value)\"\nMaxXP = 0\n_ = 1\nPlayerXP = PlayerXPFrame {\n 0 = <userdata>\n XPbar = PlayerXPFrameStatusBar {\n }\n}\nCurrentXP = 0\nFormatValue = <function> defined @Interface\\AddOns\\xVermin\\Experience/Player.lua:61\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Experience/Player.lua:85: in function <Interface\\AddOns\\xVermin\\Experience/Player.lua:77>\nInterface\\AddOns\\xVermin\\Experience/Player.lua:100: in function <Interface\\AddOns\\xVermin\\Experience/Player.lua:98>\nInterface\\AddOns\\xVermin\\Experience/Player.lua:118: in function <Interface\\AddOns\\xVermin\\Experience/Player.lua:109>",
			["session"] = 1929,
			["counter"] = 2,
		}, -- [182]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Experience/Pet.lua:79: attempt to call global 'ColorGradient' (a nil value)",
			["time"] = "2020/08/19 21:08:46",
			["locals"] = "(*temporary) = nil\n(*temporary) = 0.870000\n(*temporary) = 1\n(*temporary) = 0\n(*temporary) = 0\n(*temporary) = 1\n(*temporary) = 1\n(*temporary) = 0\n(*temporary) = 0\n(*temporary) = 1\n(*temporary) = 0\n(*temporary) = \"attempt to call global 'ColorGradient' (a nil value)\"\nPetXP = PlayerXPFrame {\n 0 = <userdata>\n XPbar = PlayerXPFrameStatusBar {\n }\n}\nFormatValue = <function> defined @Interface\\AddOns\\xVermin\\Experience/Pet.lua:53\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Experience/Pet.lua:79: in function <Interface\\AddOns\\xVermin\\Experience/Pet.lua:74>",
			["session"] = 1929,
			["counter"] = 2,
		}, -- [183]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Experience/Pet.lua:81: Usage: PlayerXPFrameStatusBar:SetMinMaxValues(min, max)",
			["time"] = "2020/08/19 21:11:24",
			["locals"] = "(*temporary) = PlayerXPFrameStatusBar {\n 0 = <userdata>\n Below = <unnamed> {\n }\n Value = <unnamed> {\n }\n Background = <unnamed> {\n }\n Above = <unnamed> {\n }\n BackgroundShadow = <unnamed> {\n }\n}\n(*temporary) = 0\n(*temporary) = nil\n",
			["stack"] = "[C]: in function `SetMinMaxValues'\nInterface\\AddOns\\xVermin\\Experience/Pet.lua:81: in function <Interface\\AddOns\\xVermin\\Experience/Pet.lua:74>",
			["session"] = 1930,
			["counter"] = 2,
		}, -- [184]
		{
			["message"] = "Error loading Interface\\AddOns\\xVermin\\Experience.lua",
			["time"] = "2020/08/19 21:35:15",
			["session"] = 1943,
			["counter"] = 6,
		}, -- [185]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'ItemRack' tried to call the protected function 'ItemRackButton0:SetAttribute()'.",
			["time"] = "2020/08/02 11:49:42",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `SetAttribute'\nInterface\\AddOns\\ItemRack\\ItemRackButtons.lua:35: in function `InitButtons'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:282: in function `func'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:970: in function `OnUpdate'\n[string \"*:OnUpdate\"]:1: in function <[string \"*:OnUpdate\"]:1>",
			["session"] = 1945,
			["counter"] = 5,
		}, -- [186]
		{
			["message"] = "[string \"print(UnitMaxXP(\"player\"))\"]:1: attempt to call global 'UnitMaxXP' (a nil value)",
			["time"] = "2020/08/20 14:24:17",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = \"player\"\n(*temporary) = \"attempt to call global 'UnitMaxXP' (a nil value)\"\n",
			["stack"] = "[string \"print(UnitMaxXP(\"player\"))\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1955,
			["counter"] = 1,
		}, -- [187]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Experience/Player.lua:82: attempt to perform arithmetic on global 'MaxXP' (a nil value)",
			["time"] = "2020/08/20 14:33:13",
			["locals"] = "self = nil\nevent = nil\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = 2937\n(*temporary) = nil\n(*temporary) = 0\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to perform arithmetic on global 'MaxXP' (a nil value)\"\n_ = \"xVermin\"\nxVermin = <table> {\n Config = <table> {\n }\n AOE = <function> defined @Interface\\AddOns\\xVermin\\Rotation/_Core.lua:3\n ColorGradient = <function> defined @Interface\\AddOns\\xVermin\\xVermin.lua:3\n}\nPlayerXP = PlayerXPFrame {\n 0 = <userdata>\n XPbar = PlayerXPFrameStatusBar {\n }\n}\nFormatValue = <function> defined @Interface\\AddOns\\xVermin\\Experience/Player.lua:62\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Experience/Player.lua:82: in function <Interface\\AddOns\\xVermin\\Experience/Player.lua:78>\nInterface\\AddOns\\xVermin\\Experience/Player.lua:96: in function <Interface\\AddOns\\xVermin\\Experience/Player.lua:94>\nInterface\\AddOns\\xVermin\\Experience/Player.lua:115: in function <Interface\\AddOns\\xVermin\\Experience/Player.lua:105>",
			["session"] = 1960,
			["counter"] = 1,
		}, -- [188]
		{
			["message"] = "[string \"local formatted = string.format(\"]:1: unexpected symbol near '<eof>'",
			["time"] = "2020/08/20 19:04:30",
			["locals"] = "(*temporary) = \"local formatted = string.format(\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1968,
			["counter"] = 1,
		}, -- [189]
		{
			["message"] = "[string \"print(string.format(\"]:1: unexpected symbol near '<eof>'",
			["time"] = "2020/08/20 19:04:30",
			["locals"] = "(*temporary) = \"print(string.format(\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2783: in function <Interface\\FrameXML\\ChatFrame.lua:2776>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1968,
			["counter"] = 1,
		}, -- [190]
		{
			["message"] = "[string \"print(BreakUpLargeNumbers(UnitXP(\"player)))\"]:1: unfinished string near '<eof>'",
			["time"] = "2020/08/20 19:09:26",
			["locals"] = "(*temporary) = \"print(BreakUpLargeNumbers(UnitXP(\"player)))\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4695: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4356: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4392: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1969,
			["counter"] = 1,
		}, -- [191]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Experience/Player.lua:85: attempt to call global 'FormatNumber' (a nil value)",
			["time"] = "2020/08/20 19:20:39",
			["locals"] = "self = nil\nevent = nil\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = 13399\n(*temporary) = \",\"\n(*temporary) = \"attempt to call global 'FormatNumber' (a nil value)\"\n_ = 1\nxVermin = <table> {\n Config = <table> {\n }\n AOE = <function> defined @Interface\\AddOns\\xVermin\\Rotation/_Core.lua:3\n ColorGradient = <function> defined @Interface\\AddOns\\xVermin\\xVermin.lua:3\n}\nPlayerXP = PlayerXPFrame {\n 0 = <userdata>\n XPbar = PlayerXPFrameStatusBar {\n }\n}\n",
			["stack"] = "Interface\\AddOns\\xVermin\\Experience/Player.lua:85: in function <Interface\\AddOns\\xVermin\\Experience/Player.lua:76>\nInterface\\AddOns\\xVermin\\Experience/Player.lua:94: in function <Interface\\AddOns\\xVermin\\Experience/Player.lua:92>\nInterface\\AddOns\\xVermin\\Experience/Player.lua:107: in function <Interface\\AddOns\\xVermin\\Experience/Player.lua:106>",
			["session"] = 1974,
			["counter"] = 1,
		}, -- [192]
	},
}
